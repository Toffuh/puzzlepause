import '../game/tile.dart';

class Position {
  int x;
  int y;

  Position(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  int getGridX(int column, Tile tile, int dragOffsetX) {
    return x + column - dragOffsetX - tile.minX();
  }

  int getGridY(int row, Tile tile, int dragOffsetY) {
    return y + row - dragOffsetY - tile.minY();
  }
}
