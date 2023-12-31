import 'dart:ui';

import '../util/position.dart';

class Piece {
  final Color _color;

  late final List<Position> _relativePositions;

  Piece.pieceT(this._color) {
    _relativePositions = [
      Position(0, 0),
      Position(0, 1),
      Position(-1, -1),
      Position(0, -1),
      Position(1, -1)
    ];
  }

  Piece.pieceL(this._color) {
    _relativePositions = [
      Position(0, 0),
      Position(0, 1),
      Position(0, -1),
      Position(1, -1)
    ];
  }

  Piece.pieceLine(this._color) {
    _relativePositions = [
      Position(0, 0),
      Position(0, 1),
      Position(0, -1),
    ];
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
