import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../game/tile.dart';

class TileDisplay extends StatelessWidget {
  final Color? tileColor;
  final int x;
  final int y;

  const TileDisplay(this.tileColor, this.x, this.y, {super.key});

  @override
  Widget build(BuildContext context) {
    var tileSize = Tile.getSize(context);

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: SizedBox(
          height: tileSize,
          width: tileSize,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: getSecondaryColor(),
                    borderRadius:
                        BorderRadius.all(Radius.circular(tileSize * 0.1))),
              ),
              Positioned(
                left: tileSize * 0.05,
                child: SizedBox(
                  height: tileSize * 0.9,
                  width: tileSize * 0.9,
                  child: Container(
                    decoration: BoxDecoration(
                        color: getMainColor(),
                        borderRadius:
                            BorderRadius.all(Radius.circular(tileSize * 0.1))),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Color? getMainColor() {
    if (tileColor != null) {
      return tileColor!;
    }

    var colorA = const Color(0xff7d80fa);
    var colorB = const Color(0xff8db7ff);

    Color defaultColor;

    if (((x ~/ 3) + (3 * (y ~/ 3))) % 2 == 0) {
      defaultColor = colorA;
    } else {
      defaultColor = colorB;
    }

    return defaultColor;
  }

  Color? getSecondaryColor() {
    if (tileColor != null) {
      return Color.lerp(tileColor, Colors.black, 0.3);
    }

    return getMainColor();
  }
}
