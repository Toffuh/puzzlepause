import 'package:puzzelpause/game/piece.dart';
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

  void setTile(int x, int y, Tile? tile) {
    _gameField[x][y] = tile;
  }

  int clear() {
    int? points;

    //columns
    outer:
    for (var x = 0; x < size; x++) {
      for (var y = 0; y < size; y++) {
        if (_gameField[x][y] == null) {
          continue outer;
        }
      }

      points = (points ?? 1) * 3;

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
      points = (points ?? 1) * 3;

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

        points = (points ?? 1) * 3;

        for (var x = 0; x < 3; x++) {
          for (var y = 0; y < 3; y++) {
            _gameField[quadX * 3 + x][quadY * 3 + y] = null;
          }
        }
      }
    }

    return points ?? 0;
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

  bool isValidPiece(Piece piece, int x, int y, int offsetX, int offsetY) {
    for (var position in piece.relativePositions) {
      if (!isValidPosition(position.getGridX(x, piece, offsetX),
          position.getGridY(y, piece, offsetY))) {
        return false;
      }
    }

    return true;
  }
}
