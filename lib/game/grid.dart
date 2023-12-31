import 'package:puzzelpause/game/tile.dart';

class Grid {
  late List<List<Tile?>> _gameField;

  static const int size = 9;

  Grid() {
    _gameField = List.generate(
      size,
      growable: false,
      (index) => List.generate(size, growable: false, (index) => null),
    );
  }

  Tile? getTile(int x, int y) {
    return _gameField[x][y];
  }

  void setTile(int x, int y, Tile tile) {
    _gameField[x][y] = tile;
  }

  void clear() {
    //columns
    outer:
    for (var x = 0; x < size; x++) {
      for (var y = 0; y < size; y++) {
        if (_gameField[x][y] == null) {
          continue outer;
        }
      }

      _gameField[x] = List.generate(size, growable: false, (index) => null);
    }

    //rows
    outer:
    for (var y = 0; y < size; y++) {
      for (var x = 0; x < size; x++) {
        if (_gameField[x][y] == null) {
          continue outer;
        }
      }

      //reset row
      for (var x = 0; x < size; x++) {
        _gameField[x][y] = null;
      }
    }

    //3x3
    for (var quadX = 0; quadX < 3; quadX++) {
      outer:
      for (var quadY = 0; quadY < 3; quadY++) {
        //inner 3x3
        for (var x = 0; x < 3; x++) {
          for (var y = 0; y < 3; y++) {
            if (_gameField[quadX * 3 + x][quadY * 3 + y] == null) {
              continue outer;
            }
          }
        }

        for (var x = 0; x < 3; x++) {
          for (var y = 0; y < 3; y++) {
            _gameField[quadX * 3 + x][quadY * 3 + y] = null;
          }
        }
      }
    }
  }

  bool isNotInGrid(int x, int y) {
    return x < 0 || x >= size || y < 0 || y >= size;
  }

  bool isValidPosition(int x, int y) {
    if (isNotInGrid(x, y)) {
      return false;
    }

    return getTile(x, y) == null;
  }
}
