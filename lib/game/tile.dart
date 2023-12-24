import 'dart:ui';

import '../util/position.dart';

class Tile {
  final Color _color;

  //always can currently not have negativ values because of rendering
  late final List<Position> _relativPositions;

  Tile.pieceT(this._color) {
    _relativPositions = [
      Position(1, 1),
      Position(1, 2),
      Position(0, 0),
      Position(1, 0),
      Position(2, 0)
    ];
  }

  Tile.pieceL(this._color) {
    _relativPositions = [
      Position(1, 1),
      Position(1, 2),
      Position(1, 0),
      Position(2, 0)
    ];
  }

  Tile.pieceLine(this._color) {
    _relativPositions = [
      Position(1, 1),
      Position(1, 2),
      Position(1, 0),
    ];
  }

  Color get color => _color;

  List<Position> get relativPositions => _relativPositions;
}
