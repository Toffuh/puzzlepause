import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puzzelpause/util/position.dart';

import '../../game/grid.dart';
import '../../game/tile.dart';

class GridDisplay extends StatefulWidget {
  final Grid _grid;
  final Function(Tile tile, int x, int y) _onAccept;

  const GridDisplay(this._grid, this._onAccept, {super.key});

  @override
  State<GridDisplay> createState() => _GridDisplayState();
}

class _GridDisplayState extends State<GridDisplay> {
  List<Position> _selected = [];
  Color? selectedColor;

  void update() {
    Timer(Duration.zero, () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _selected = [];
    selectedColor = null;
    return Column(
      children: [
        for (var y = 0; y < widget._grid.width; y++)
          Row(
            children: [
              for (var x = 0; x < widget._grid.height; x++)
                DragTarget<Tile>(
                  builder: (BuildContext context, List<Tile?> candidateData,
                      List<dynamic> rejectedData) {
                    if (candidateData.isNotEmpty) {
                      var candidate = candidateData.elementAtOrNull(0)!;

                      for (var value in candidate.relativPositions) {
                        _selected.add(Position(value.x + x, value.y + y));
                      }

                      selectedColor = candidate.color.withOpacity(0.5);

                      update();
                    }

                    Color? color =
                        widget._grid.getTile(x, y)?.color ?? Colors.grey;

                    if (_selected.contains(Position(x, y))) {
                      color = selectedColor;
                    }

                    return SizedBox(
                        height: 20, width: 20, child: Container(color: color));
                  },
                  onAccept: (data) => widget._onAccept(data, x, y),
                )
            ],
          )
      ],
    );
  }
}
