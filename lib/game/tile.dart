import 'dart:ui';

import '../util/position.dart';

class Tile {
  static const int size = 20;

  final Color _color;

  late final List<Position> _relativePositions;

  Tile.pieceT(this._color) {
    _relativePositions = [
      Position(0, 0),
      Position(0, 1),
      Position(-1, -1),
      Position(0, -1),
      Position(1, -1)
    ];
  }

  Tile.pieceL(this._color) {
    _relativePositions = [
      Position(0, 0),
      Position(0, 1),
      Position(0, -1),
      Position(1, -1)
    ];
  }

  Tile.pieceLine(this._color) {
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
}
