import 'package:flutter/cupertino.dart';
import 'package:puzzelpause/game/tile.dart';

class TileDisplay extends StatelessWidget {
  final Tile tile;

  const TileDisplay(this.tile, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          for (var positions in tile.relativePositions)
            Positioned(
                left: (Tile.size * (positions.x - tile.minX())).toDouble(),
                top: (Tile.size * (positions.y - tile.minY())).toDouble(),
                width: Tile.size.toDouble(),
                height: Tile.size.toDouble(),
                child: Container(
                  color: tile.color,
                ))
        ],
      ),
    );
  }
}
