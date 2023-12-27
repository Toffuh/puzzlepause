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
                left: (20 * (positions.x - tile.minX())).toDouble(),
                top: (20 * (positions.y - tile.minY())).toDouble(),
                width: 20,
                height: 20,
                child: Container(
                  color: tile.color,
                ))
        ],
      ),
    );
  }
}
