import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class X extends StatelessWidget {
  const X({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 31, 16, 42),
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Punkte: $points",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (bombCount > 0)
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: bombIcon()),
                    if (singleTileCount > 0)
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: singleTileIcon()),
                    if (refreshCount > 0)
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: refreshIcon())
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.highlight_remove_sharp, size: 50, color: Colors.white),
                    onPressed: () => endGame(),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Center());
  }
}
