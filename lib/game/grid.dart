import 'package:puzzelpause/game/tile.dart';

class Grid {
  late List<List<Tile?>> _gameField;

  final int _width;
  final int _height;

  Grid(this._width, this._height) {
    _gameField = List.generate(
      _width,
      growable: false,
      (index) => List.generate(_height, growable: false, (index) => null),
    );
  }

  Tile? getTile(int x, int y) {
    return _gameField[x][y];
  }

  void setTile(int x, int y, Tile tile) {
    _gameField[x][y] = tile;
  }

  int get height => _height;

  int get width => _width;
}
