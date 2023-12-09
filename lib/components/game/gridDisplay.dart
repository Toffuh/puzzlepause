import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../game/grid.dart';
import '../../game/tile.dart';

class GridDisplay extends StatelessWidget {
  final Grid _grid;
  final Function(Tile tile, int x, int y) _onAccept;

  const GridDisplay(this._grid, this._onAccept, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var x = 0; x < _grid.width; x++)
          Row(
            children: [
              for (var y = 0; y < _grid.height; y++)
                DragTarget<Tile>(
                  builder: (BuildContext context, List<Tile?> candidateData,
                      List<dynamic> rejectedData) {
                    return SizedBox(
                        height: 20,
                        width: 20,
                        child: Container(
                            color: _grid.getTile(x, y)?.color ??
                                candidateData
                                    .elementAtOrNull(0)
                                    ?.color
                                    .withOpacity(0.5) ??
                                Colors.grey));
                  },
                  onAccept: (data) => _onAccept(data, x, y),
                )
            ],
          )
      ],
    );
  }
}
