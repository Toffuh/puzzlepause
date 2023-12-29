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
    grid = Grid(10, 10);

    openPieces = [
      Piece.pieceT(Colors.red),
      Piece.pieceL(Colors.yellow),
      Piece.pieceLine(Colors.green)
    ];

    super.initState();
  }

  int offsetX = 0;
  int offsetY = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GridDisplay(
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
                          grid.setTile(position.getGridX(x, piece, offsetX),
                              position.getGridY(y, piece, offsetY), Tile.fromPiece(piece));
                          openPieces.remove(piece);
                        }
                      },
                    )
                  },
              offsetX,
              offsetY),
          Column(
            children: [
              for (var piece in openPieces)
                Draggable<Piece>(
                    data: piece,
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
                        child: PieceDisplay(piece)))
            ],
          ),
        ],
      ),
    );
  }
}
