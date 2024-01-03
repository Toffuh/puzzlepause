import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:puzzelpause/game/piece.dart';

class Tile {
  static double getSize(BuildContext context) {
    return min((MediaQuery.of(context).size.width - 100) / 9, 50);
  }

  late final Color _color;

  Tile(this._color);

  Tile.fromPiece(Piece piece) {
    _color = piece.color;
  }

  Color get color => _color;
}
