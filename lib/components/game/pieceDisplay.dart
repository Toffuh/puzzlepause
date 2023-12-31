import 'package:flutter/cupertino.dart';
import 'package:puzzelpause/game/piece.dart';

import '../../game/tile.dart';

class PieceDisplay extends StatelessWidget {
  final Piece piece;

  const PieceDisplay(this.piece, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (piece.width() * Tile.size).toDouble(),
      height: (piece.height() * Tile.size).toDouble(),
      child: Stack(
        children: [
          for (var positions in piece.relativePositions)
            Positioned(
                left: (Tile.size * (positions.x - piece.minX())).toDouble(),
                top: (Tile.size * (positions.y - piece.minY())).toDouble(),
                width: Tile.size.toDouble(),
                height: Tile.size.toDouble(),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: piece.color,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(Tile.size * 0.1))),
                  ),
                )),
        ],
      ),
    );
  }
}
