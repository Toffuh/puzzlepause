import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puzzelpause/components/game/gridDisplay.dart';
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

  @override
  void initState() {
    grid = Grid(10, 10);

    openTiles = [Tile(Colors.red), Tile(Colors.yellow), Tile(Colors.green)];

    super.initState();
  }

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
                        grid.setTile(x, y, tile);
                        openTiles.remove(tile);
                      },
                    )
                  }),
          Column(
            children: [
              for (var value in openTiles)
                Draggable<Tile>(
                    data: value,
                    feedback: SizedBox(
                        height: 20,
                        width: 20,
                        child: Container(
                          color: value.color,
                        )),
                    child: SizedBox(
                        height: 20,
                        width: 20,
                        child: Container(
                          color: value.color,
                        )))
            ],
          ),
        ],
      ),
    );
  }
}
