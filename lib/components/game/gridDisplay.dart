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

  bool isUpdate = false;

  void update() {
    Timer(Duration.zero, () {
      isUpdate = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var render = Column(
      children: [
        for (var y = 0; y < widget._grid.width; y++)
          Row(
            children: [
              for (var x = 0; x < widget._grid.height; x++)
                DragTarget<Tile>(
                  builder: (BuildContext context, List<Tile?> candidateData,
                      List<dynamic> rejectedData) {
                    if (candidateData.isNotEmpty) {
                      if (!isUpdate) {
                        var candidate = candidateData.elementAtOrNull(0)!;

                        //validate position
                        var isValid = true;
                        for (var value in candidate.relativePositions) {
                          if (!widget._grid
                              .isValidPosition(value.x + x, value.y + y)) {
                            isValid = false;
                            break;
                          }
                        }

                        if (isValid) {
                          //set tile
                          for (var value in candidate.relativePositions) {
                            _selected.add(Position(value.x + x, value.y + y));
                          }

                          selectedColor = candidate.color.withOpacity(0.5);

                          update();
                        }
                      } else {
                        isUpdate = false;
                      }
                    }

                    Color? color =
                        widget._grid.getTile(x, y)?.color ?? Colors.grey;

                    if (_selected.contains(Position(x, y))) {
                      color = selectedColor;
                    }

                    return SizedBox(
                        height: 20, width: 20, child: Container(color: color));
                  },
                  onAccept: (data) {
                    _selected = [];
                    selectedColor = null;
                    widget._onAccept(data, x, y);
                  },
                  onLeave: (data) {
                    _selected = [];
                    selectedColor = null;

                    update();
                  },
                )
            ],
          )
      ],
    );

    return render;
  }
}
