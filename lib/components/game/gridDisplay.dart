import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puzzelpause/util/position.dart';

import '../../game/grid.dart';
import '../../game/piece.dart';
import '../../game/tile.dart';

class GridDisplay extends StatefulWidget {
  final Grid _grid;
  final Function(Piece piece, int x, int y) _onAccept;

  final int _offsetX;
  final int _offsetY;

  const GridDisplay(this._grid, this._onAccept, this._offsetX, this._offsetY,
      {super.key});

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

  int getGridX(Piece piece, Position position, int x) {
    return position.x + x - widget._offsetX - piece.minX();
  }

  int getGridY(Piece piece, Position position, int y) {
    return position.y + y - widget._offsetY - piece.minY();
  }

  @override
  Widget build(BuildContext context) {
    var render = Column(
      children: [
        for (var y = 0; y < widget._grid.width; y++)
          Row(
            children: [
              for (var x = 0; x < widget._grid.height; x++)
                DragTarget<Piece>(
                  builder: (BuildContext context, List<Piece?> candidateData,
                      List<dynamic> rejectedData) {
                    if (candidateData.isNotEmpty) {
                      if (!isUpdate) {
                        var piece = candidateData.elementAtOrNull(0)!;

                        //validate position
                        var isValid = true;
                        for (var position in piece.relativePositions) {
                          if (!widget._grid.isValidPosition(
                              getGridX(piece, position, x),
                              getGridY(piece, position, y))) {
                            isValid = false;
                            break;
                          }
                        }

                        if (isValid) {
                          //set tile
                          for (var position in piece.relativePositions) {
                            _selected.add(Position(
                                getGridX(piece, position, x),
                                getGridY(piece, position, y)));
                          }

                          selectedColor = piece.color.withOpacity(0.5);

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
                        height: Tile.size.toDouble(),
                        width: Tile.size.toDouble(),
                        child: Container(color: color));
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
