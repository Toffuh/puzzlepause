import 'dart:math';
import 'package:flutter/material.dart';
import 'package:puzzelpause/game/grid_placeable.dart';

import '../util/position.dart';

class Piece extends GridPlaceable {
  static final List<List<Position>> pieceStructures = [
    [
      Position(0, 0),
      Position(0, 1),
      Position(-1, -1),
      Position(0, -1),
      Position(1, -1)
    ],
    [Position(0, 0), Position(0, 1), Position(0, -1), Position(1, -1)],
    [
      Position(0, 0),
      Position(0, 1),
      Position(0, -1),
    ],
    [Position(0, 0), Position(0, 1), Position(1, 1), Position(1, 0)],
    [
      Position(0, -1),
      Position(-1, 0),
      Position(0, 0),
      Position(0, 1),
    ],
    [
      Position(0, -1),
      Position(-1, 0),
      Position(0, 0),
      Position(1, 0),
      Position(0, 1),
    ],
    [
      Position(0, 0),
      Position(0, 1),
      Position(1, 1),
      Position(1, 0),
      Position(2, 1)
    ],
    [
      Position(0, 0),
      Position(1, 1)
    ],
    [
      Position(0, 1),
      Position(1, 0)
    ],
    [
      Position(0, 1),
      Position(1, 0),
      Position(2, -1),
    ]
  ];

  static final List<Color> pieceColors = [
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.yellow,
    Colors.purple,
    Colors.brown,
  ];

  final Color _color;

  late List<Position> _relativePositions;

  Piece._(this._color, this._relativePositions);

  Piece.singleTile(this._color) {
    _relativePositions = [Position(0, 0)];
  }

  static List<Piece> generateRandomPieces(int count) {
    List<Piece> pieces = [];

    for (var i = 0; i < count; i++) {
      var piece = Piece._(pieceColors[Random().nextInt(pieceColors.length)],
          pieceStructures[Random().nextInt(pieceStructures.length)]);

      for (var i = 0; i < Random().nextInt(4); i++) {
        piece.rotate();
      }

      pieces.add(piece);
    }

    return pieces;
  }

  void rotate() {
    List<Position> positions = [];

    for (var position in relativePositions) {
      var newY = -position.x;
      var newX = -position.y;

      positions.add(Position(newX, newY));
    }

    _relativePositions = positions;
  }

  Color get color => _color;

  List<Position> get relativePositions => _relativePositions;

  int minY() {
    var min = 0;

    for (var value in _relativePositions) {
      if (min > value.y) {
        min = value.y;
      }
    }

    return min;
  }

  int minX() {
    var min = 0;

    for (var value in _relativePositions) {
      if (min > value.x) {
        min = value.x;
      }
    }

    return min;
  }

  int maxY() {
    var max = 0;

    for (var value in _relativePositions) {
      if (max < value.y) {
        max = value.y;
      }
    }

    return max;
  }

  int maxX() {
    var max = 0;

    for (var value in _relativePositions) {
      if (max < value.x) {
        max = value.x;
      }
    }

    return max;
  }

  int width() {
    return maxX() - minX() + 1;
  }

  int height() {
    return maxY() - minY() + 1;
  }
}
