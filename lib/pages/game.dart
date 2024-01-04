import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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

  @override
  void initState() {
    grid = Grid();

    bombCount = 1;
    singleTileCount = 1;

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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (bombCount > 0) bombIcon(),
              if (singleTileCount > 0) singleTileIcon()
            ],
          ),
          if (hasLost)
            const Text("You have lost...",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
          Text("Points: $points",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              )),
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

                            var clearCount = grid.clear();

                            points += clearCount * 3;

                            if (clearCount > 0) {
                              getRandomPowerup();
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

  void removeOpenPiece(Piece piece) {
    openPieces.remove(piece);

    if (openPieces.isEmpty) {
      openPieces = Piece.generateRandomPieces(3);
    }

    if (checkLost()) {
      hasLost = true;

      UserData.getInstance().points = points;
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
        child: Stack(children: [
          bombIcon,
          Positioned(
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: tileSize * 0.5,
                width: tileSize * 0.5,
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Center(
                        child: Text(
                      "$bombCount",
                      style: const TextStyle(color: Colors.white),
                    ))),
              ))
        ]),
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
            child: PieceDisplay(piece)));
  }

  void getRandomPowerup() {
    switch (Random().nextInt(2)) {
      case 0:
        bombCount++;
      case 1:
        singleTileCount++;
    }
  }
}
