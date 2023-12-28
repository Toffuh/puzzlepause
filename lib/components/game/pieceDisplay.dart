import 'package:flutter/cupertino.dart';
import 'package:puzzelpause/game/piece.dart';

import '../../game/tile.dart';

class PieceDisplay extends StatelessWidget {
  final Piece piece;

  const PieceDisplay(this.piece, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          for (var positions in piece.relativePositions)
            Positioned(
                left: (Tile.size * (positions.x - piece.minX())).toDouble(),
                top: (Tile.size * (positions.y - piece.minY())).toDouble(),
                width: Tile.size.toDouble(),
                height: Tile.size.toDouble(),
                child: Container(
                  color: piece.color,
                ))
        ],
      ),
    );
  }
}
