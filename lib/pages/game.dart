import 'dart:async';

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

  @override
  void initState() {
    grid = Grid(9, 9);

    openPieces = Piece.generateRandomPieces(3);

    super.initState();
  }

  int offsetX = 0;
  int offsetY = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 16, 42),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridDisplay(
                grid,
                (piece, x, y) => {
                      setState(
                        () {
                          //validate position
                          for (var position in piece.relativePositions) {
                            if (!grid.isValidPosition(
                                position.getGridX(x, piece, offsetX),
                                position.getGridY(y, piece, offsetY))) {
                              return;
                            }
                          }

                        //set tiles
                        for (var position in piece.relativePositions) {
                          grid.setTile(
                              position.getGridX(x, piece, offsetX),
                              position.getGridY(y, piece, offsetY),
                              Tile.fromPiece(piece));
                        }

                        removeOpenPiece(piece);
                      },
                    )
                  },
              offsetX,
              offsetY),
          Column(
                          //set tiles
                          for (var position in piece.relativePositions) {
                            grid.setTile(
                                position.getGridX(x, piece, offsetX),
                                position.getGridY(y, piece, offsetY),
                                Tile.fromPiece(piece));
                            openPieces.remove(piece);
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
  }
}
