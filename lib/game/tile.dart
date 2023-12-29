import 'dart:ui';

import 'package:puzzelpause/game/piece.dart';

class Tile {
  static const int size = 20;

  late final Color _color;

  Tile(this._color);

  Tile.fromPiece(Piece piece) {
    _color = piece.color;
  }

  Color get color => _color;
}
