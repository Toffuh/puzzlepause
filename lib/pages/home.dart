import 'package:flutter/material.dart';
import 'package:puzzelpause/globals/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final SharedPreferences sharedPreferences;
  bool loading = true;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    sharedPreferences = await SharedPreferences.getInstance();

    List<String>? items = sharedPreferences.getStringList("list");
    items ??= [];

    for (var value in items) {
      List<String> splitted = value.split(";");

      String uid = splitted[0];
      String email = splitted[1];
      String displayName = splitted[2];
      String photoURL = splitted[3];

      UserData.getInstance().uid = uid;
      UserData.getInstance().email = email;
      UserData.getInstance().displayName = displayName;
      UserData.getInstance().photoURL = photoURL;
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 16, 42),
      body: !loading
          ? Center(
              child: Column(
                children: [
                  const Padding(
                      padding: EdgeInsets.all(30),
                      child: Stack(
                        children: [
                          Center(
                            child: Text("PuzzlePause - Gemütliches Tetris",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30)),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: TextButton(
                        onPressed: () =>
                            {Navigator.pushNamed(context, "/game")},
                        child: const Text("Spielen",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: TextButton(
                        onPressed: () =>
                            {Navigator.pushNamed(context, "/login")},
                        child: const Text("Anmelden",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: TextButton(
                        onPressed: () =>
                            {Navigator.pushNamed(context, "/leaderboard")},
                        child: const Text("Bestenliste",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22))),
                  ),
                ],
              ),
            )
          : const Text("loading"),
    );
  }
}
