import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puzzelpause/components/game/tileDisplay.dart';
import 'package:puzzelpause/util/position.dart';

import '../../game/grid.dart';
import '../../game/piece.dart';

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

  @override
  Widget build(BuildContext context) {
    var render = Column(
      children: [
        for (var y = 0; y < Grid.size; y++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var x = 0; x < Grid.size; x++)
                DragTarget<Piece>(
                  builder: (BuildContext context, List<Piece?> candidateData,
                      List<dynamic> rejectedData) {
                    Color? color = widget._grid.getTile(x, y)?.color;

                    if (_selected.contains(Position(x, y))) {
                      color = selectedColor;
                    }

                    return TileDisplay(color, x, y);
                  },
                  onWillAccept: (piece) {
                    if (piece != null) {
                      if (!widget._grid.isValidPiece(
                          piece, x, y, widget._offsetX, widget._offsetY)) {
                        return false;
                      }

                      //set tile
                      for (var position in piece.relativePositions) {
                        _selected.add(Position(
                            position.getGridX(x, piece, widget._offsetX),
                            position.getGridY(y, piece, widget._offsetY)));
                      }

                      selectedColor = piece.color.withOpacity(0.5);

                      setState(() {});
                    }

                    return true;
                  },
                  onAccept: (data) {
                    _selected = [];
                    selectedColor = null;
                    widget._onAccept(data, x, y);
                  },
                  onLeave: (data) {
                    _selected = [];
                    selectedColor = null;

                    setState(() {});
                  },
                )
            ],
          )
      ],
    );

    return render;
  }
}
