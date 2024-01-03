import 'package:flutter/cupertino.dart';
import 'package:puzzelpause/components/game/tileDisplay.dart';
import 'package:puzzelpause/game/piece.dart';

import '../../game/tile.dart';

class PieceDisplay extends StatelessWidget {
  final Piece piece;

  const PieceDisplay(this.piece, {super.key});

  @override
  Widget build(BuildContext context) {
    var tileSize = Tile.getSize(context);

    return SizedBox(
      width: (piece.width() * (tileSize + 2)).toDouble(),
      height: (piece.height() * (tileSize + 2)).toDouble(),
      child: Stack(
        children: [
          for (var positions in piece.relativePositions)
            Positioned(
                left:
                    ((tileSize + 2) * (positions.x - piece.minX())).toDouble(),
                top: ((tileSize + 2) * (positions.y - piece.minY())).toDouble(),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TileDisplay(piece.color, 0, 0),
                )),
        ],
      ),
    );
  }
}
