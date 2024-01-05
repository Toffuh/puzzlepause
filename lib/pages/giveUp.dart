import 'package:flutter/material.dart';

class GiveUp extends StatelessWidget {

  Function func;

  GiveUp({super.key, required this.func});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Möchtest du aufhören?"),
          Row(
            children: [
              TextButton(onPressed: func(true), child: const Text("JA")),
              TextButton(onPressed: func(false), child: const Text("NEIN"))
            ],
          )
        ],
      ),
    )
  }
}
