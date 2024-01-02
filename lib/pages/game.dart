import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puzzelpause/components/game/gridDisplay.dart';
import 'package:puzzelpause/components/game/pieceDisplay.dart';
import 'package:puzzelpause/game/grid.dart';
import 'package:puzzelpause/game/tile.dart';

import '../game/piece.dart';
import '../game/tile.dart';
import '../util/position.dart';

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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 16, 42),
      body: Column(
        children: [
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
                (piece, x, y) => {
                      setState(
                        () {
                          //validate position
                          if (!grid.isValidPiece(
                              piece, x, y, offsetX, offsetY)) {
                            return;
                          }

                          //set tiles
                          for (var position in piece.relativePositions) {
                            grid.setTile(
                                position.getGridX(x, piece, offsetX),
                                position.getGridY(y, piece, offsetY),
                                Tile.fromPiece(piece));
                          }

                          removeOpenPiece(piece);
                          points += grid.clear();
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
                              offsetX = details.localPosition.dx ~/
                                  Tile.size.toDouble();
                              offsetY = details.localPosition.dy ~/
                                  Tile.size.toDouble();
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
}
