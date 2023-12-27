import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puzzelpause/components/game/gridDisplay.dart';
import 'package:puzzelpause/components/game/tileDisplay.dart';
import 'package:puzzelpause/game/grid.dart';

import '../game/tile.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late Grid grid;
  late List<Tile> openTiles;

  bool isInGrid = false;

  @override
  void initState() {
    grid = Grid(10, 10);

    openTiles = [
      Tile.pieceT(Colors.red),
      Tile.pieceL(Colors.yellow),
      Tile.pieceLine(Colors.green)
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
              (tile, x, y) => {
                    setState(
                      () {
                        //validate position
                        for (var position in tile.relativePositions) {
                          if (!grid.isValidPosition(
                              position.x + x, position.y + y)) {
                            return;
                          }
                        }

                        //set tiles
                        for (var position in tile.relativePositions) {
                          grid.setTile(position.x + x, position.y + y, tile);
                          openTiles.remove(tile);
                        }
                      },
                    )
                  },
              offsetX,
              offsetY),
          Column(
            children: [
              for (var value in openTiles)
                Draggable<Tile>(
                    data: value,
                    feedback: TileDisplay(value),
                    child: Listener(
                        onPointerDown: (details) {
                          setState(() {
                            offsetX = details.localPosition.dx ~/
                                Tile.size.toDouble();
                            offsetY = details.localPosition.dy ~/
                                Tile.size.toDouble();
                          });
                        },
                        child: TileDisplay(value)))
            ],
          ),
        ],
      ),
    );
  }
}
