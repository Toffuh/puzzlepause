import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  List<String> items = ["a", "c", "b"];
  List<String?> setItems = [null, null, null];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              for (var (index, item) in setItems.indexed)
                DragTarget<String>(
                  builder: (BuildContext context, List<String?> candidateData,
                      List<dynamic> rejectedData) {
                    return SizedBox(
                        height: 20, width: 200, child: Text(item ?? "nothing"));
                  },
                  onAccept: (item) {
                    print(item);
                    print(index);

                    setState(() {
                      setItems[index] = item;
                    });
                  },
                )
            ],
          ),
          Column(
            children: [
              for (var value in items)
                Draggable<String>(
                  data: value,
                  feedback: Text(value),
                  child: Text(value),
                )
            ],
          ),
        ],
      ),
    );
  }
}
