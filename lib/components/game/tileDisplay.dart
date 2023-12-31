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
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: SizedBox(
          height: Tile.size.toDouble(),
          width: Tile.size.toDouble(),
          child: Container(
            decoration: BoxDecoration(
                color: getColor(),
                borderRadius:
                    const BorderRadius.all(Radius.circular(Tile.size * 0.1))),
          )),
    );
  }

  Color? getColor() {
    var colorA = const Color(0xff7d80fa);
    var colorB = const Color(0xff8db7ff);

    Color defaultColor;

    if (((x ~/ 3) + (3 * (y ~/ 3))) % 2 == 0) {
      defaultColor = colorA;
    } else {
      defaultColor = colorB;
    }

    return tileColor ?? defaultColor;
  }
}
