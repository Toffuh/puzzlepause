import 'dart:math';

import 'package:flutter/material.dart';
import 'package:puzzelpause/components/game/gridDisplay.dart';
import 'package:puzzelpause/components/game/pieceDisplay.dart';
import 'package:puzzelpause/game/grid.dart';
import 'package:puzzelpause/game/single_tile.dart';
import 'package:puzzelpause/game/tile.dart';

import '../game/bomb.dart';
import '../game/piece.dart';
import '../globals/userData.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late Grid grid;
  late List<Piece> openPieces;

  bool isInGrid = false;

  bool hasLost = false;

  //powerups
  int bombCount = 0;
  int singleTileCount = 0;
  int refreshCount = 0;
  int turnCount = 0;

  int powerupProgress = 0;
  static const int maxPowerupProgress = 12;

  @override
  void initState() {
    grid = Grid();

    openPieces = Piece.generateRandomPieces(3);

    super.initState();
  }

  int offsetX = 0;
  int offsetY = 0;

  int points = 0;

  @override
  Widget build(BuildContext context) {
    var tileSize = Tile.getSize(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 16, 42),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 31, 16, 42),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Puzzlepause"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.highlight_remove_sharp,
                size: 40, color: Colors.white),
            onPressed: () => endGame(),
          )
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Text("Punkte: $points",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                )),
          ),
          SizedBox(
            height: 110,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (bombCount > 0)
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: bombIcon()),
                    if (singleTileCount > 0)
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: singleTileIcon()),
                    if (refreshCount > 0)
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: refreshIcon()),
                    if (turnCount > 0)
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: turnIcon())
                  ],
                ),
                SizedBox(
                  height: (bombCount > 0 || singleTileCount > 0 || refreshCount > 0 || turnCount > 0) ?  10 : 20,
                  width: tileSize * 7,
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    tween: Tween<double>(
                      begin: 0,
                      end: powerupProgress / maxPowerupProgress,
                    ),
                    builder: (context, value, _) => LinearProgressIndicator(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        color: const Color.fromARGB(255, 91, 166, 117),
                        value: value),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridDisplay(
                grid,
                (object, x, y) => {
                      setState(
                        () {
                          if (object is Piece) {
                            var piece = object;
                            //set tiles
                            for (var position in piece.relativePositions) {
                              grid.setTile(
                                  position.getGridX(x, piece, offsetX),
                                  position.getGridY(y, piece, offsetY),
                                  Tile.fromPiece(piece));
                            }

                            int clearCount = grid.clear();

                            if (clearCount > 0) {
                              var additionPoints = pow(3, clearCount) as int;
                              points += additionPoints;
                              updatePowerUpProgress(additionPoints);
                            }

                            if (piece is SingleTile) {
                              singleTileCount--;
                            } else {
                              removeOpenPiece(piece);
                            }
                          } else if (object is Bomb) {
                            bombCount--;

                            for (var offsetX = -1; offsetX <= 1; offsetX++) {
                              for (var offsetY = -1; offsetY <= 1; offsetY++) {
                                grid.setTile(x + offsetX, y + offsetY, null);
                              }
                            }
                          }
                        },
                      )
                    },
                offsetX,
                offsetY),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var piece in openPieces)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Draggable<Piece>(
                      data: piece,
                      childWhenDragging: Container(),
                      feedback: PieceDisplay(piece),
                      child: Listener(
                          onPointerDown: (details) {
                            setState(() {
                              offsetX = details.localPosition.dx ~/ tileSize;
                              offsetY = details.localPosition.dy ~/ tileSize;
                            });
                          },
                          child: PieceDisplay(piece))),
                )
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> showGameEndDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text("Spiel beenden?")),
          content: const Center(
              heightFactor: 4,
              child: Text("Möchtest du aufhören?",
                  style: TextStyle(fontSize: 16))),
          actions: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      hasLost = true;
                      Navigator.of(context).pop();
                    },
                    child:
                        const Text("JA", style: TextStyle(color: Colors.green)),
                  ),
                  TextButton(
                    onPressed: () {
                      hasLost = false;
                      Navigator.of(context).pop();
                    },
                    child:
                        const Text("NEIN", style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );

    if (hasLost) {
      return true;
    } else {
      return false;
    }
  }

  endGame() async {
    bool gameEnd = await showGameEndDialog();

    if (gameEnd) {
      int currentHighScore = UserData.getInstance().points;

      if (points > currentHighScore) {
        await UserData.getInstance().setPoints(points);
      }

      changeToLeaderboard();
    }
  }

  void changeToLeaderboard() {
    Navigator.pushNamed(context, "/leaderboard");
  }

  void removeOpenPiece(Piece piece) {
    openPieces.remove(piece);

    if (openPieces.isEmpty) {
      openPieces = Piece.generateRandomPieces(3);
    }

    if (checkLost()) {
      endGame();
    }
  }

  bool checkLost() {
    for (var piece in openPieces) {
      for (int x = 0; x < Grid.size; x++) {
        for (int y = 0; y < Grid.size; y++) {
          if (grid.isValidPiece(piece, x, y, 0, 0)) {
            return false;
          }
        }
      }
    }

    return true;
  }

  Widget bombIcon() {
    var tileSize = Tile.getSize(context);

    var bombIcon = Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: const Image(
          image: NetworkImage(
              "https://cdn3.iconfinder.com/data/icons/streamline-icon-set-free-pack/48/Streamline-02-256.png")),
    );

    return Draggable(
      data: Bomb(),
      feedback: SizedBox(
        height: tileSize,
        width: tileSize,
        child: bombIcon,
      ),
      child: SizedBox(
        height: tileSize,
        width: tileSize,
        child: Stack(children: [bombIcon, iconCount(tileSize, bombCount)]),
      ),
    );
  }

  Widget singleTileIcon() {
    var tileSize = Tile.getSize(context);
    var piece = SingleTile.singleTile(Colors.blueGrey);

    return Draggable<Piece>(
        data: piece,
        feedback: PieceDisplay(piece),
        child: Listener(
            onPointerDown: (details) {
              setState(() {
                offsetX = details.localPosition.dx ~/ tileSize;
                offsetY = details.localPosition.dy ~/ tileSize;
              });
            },
            child: Stack(children: [
              PieceDisplay(piece),
              iconCount(tileSize, singleTileCount)
            ])));
  }

  Widget refreshIcon() {
    return iconPowerup(Icons.delete, refreshCount, onRefresh);
  }

  void onRefresh() {
    refreshCount--;

    openPieces = Piece.generateRandomPieces(openPieces.length);

    setState(() {});
  }

  Widget turnIcon() {
    return iconPowerup(Icons.refresh, turnCount, onTurn);
  }

  Widget iconPowerup(IconData icon, int count, void Function() onPress) {
    var tileSize = Tile.getSize(context);

    return SizedBox(
      height: tileSize,
      width: tileSize,
      child: Stack(children: [
        FloatingActionButton(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
          onPressed: onPress,
          child: Container(
              padding: const EdgeInsets.all(5),
              child: Icon(
                  color: Colors.black, size: tileSize.toDouble() - 10, icon)),
        ),
        iconCount(tileSize, count)
      ]),
    );
  }

  void onTurn() {
    turnCount--;

    for (var piece in openPieces) {
      var count = Random().nextInt(3);

      for (var i = 0; i < count; i++) {
        piece.rotate();
      }
    }

    setState(() {});
  }

  Widget iconCount(double tileSize, int count) {
    return Positioned(
        right: 0,
        bottom: 0,
        child: SizedBox(
          height: tileSize * 0.5,
          width: tileSize * 0.5,
          child: Container(
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Center(
                  child: Text(
                "$count",
                style: const TextStyle(color: Colors.white),
              ))),
        ));
  }

  void getRandomPowerup() {
    switch (Random().nextInt(4)) {
      case 0:
        bombCount++;
      case 1:
        singleTileCount++;
      case 2:
        refreshCount++;
      case 3:
        refreshCount++;
    }
  }

  void updatePowerUpProgress(int addition) {
    for (var i = 0; i < addition; i++) {
      powerupProgress++;

      if (powerupProgress >= maxPowerupProgress) {
        getRandomPowerup();
        powerupProgress = 0;
      }
    }
  }
}
