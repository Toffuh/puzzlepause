import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:puzzelpause/globals/userData.dart';

import '../util/user.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  late List<User> userList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    fetchUsers();

    super.initState();
  }

  fetchUsers() async {
    userList.clear();

    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    final snapshot = await databaseReference.child("users").get();

    Map<dynamic, dynamic> users = snapshot.value as Map<dynamic, dynamic>;
    users.forEach((key, value) {
      userList.add(User(value["displayName"], key, value["points"]));
    });

    for (var i = 0; i < 30; i++) {
      userList.add(User("name", "uid", 22));
    }

    for (var i = 0; i < 10; i++) {
      userList.add(User("name", "uid", 2));
    }

    userList.sort((a, b) => b.points.compareTo(a.points));

    //other stuff
    for (int i = 0; i < userList.length; i++) {
      _sizedBoxKeys.add(GlobalKey());
    }

    setState(() {});

    Timer(const Duration(seconds: 1), () {
      _scrollToHighlightedUser();
    });
  }

  void _scrollToHighlightedUser() {
    print(getSize());

    UserData currentUser = UserData.getInstance();
    int highlightedIndex =
        userList.indexWhere((user) => user.uid == currentUser.uid);

    if (highlightedIndex != -1) {
      print(context.size?.height);
      _scrollController.animateTo(
        //                 ↓ height of listTile                       ↓ height of appBar
        highlightedIndex * getSize() - ((context.size?.height ?? 0 - 60) / 2) + (getSize() / 2),
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  final List<GlobalKey> _sizedBoxKeys = [];

  double getSize() {
    for (var value in _sizedBoxKeys) {
      if (value.currentContext != null) {
        final RenderBox renderBox =
        value.currentContext!.findRenderObject() as RenderBox;

        return renderBox.size.height;
      }
    }

    return -1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 31, 16, 42),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 31, 16, 42),
          surfaceTintColor: const Color.fromARGB(255, 31, 16, 42),
          toolbarHeight: 60,
          leading: IconButton(
            onPressed: () => {Navigator.pushNamed(context, "/")},
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          ),
          title: const Center(
            child: Text(
              "Bestenliste",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  fetchUsers();
                },
                icon: const Icon(Icons.refresh, color: Colors.white, size: 30))
          ],
        ),
        body: ListView.builder(
          controller: _scrollController,
          itemCount: userList.length,
          itemBuilder: (BuildContext context, int index) {
            bool highlight = userList[index].uid == UserData.getInstance().uid;

            return Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: highlight
                        ? const Color.fromARGB(255, 91, 166, 117)
                        : Colors.transparent),
                child: SizedBox(
                  key: _sizedBoxKeys.isNotEmpty ? _sizedBoxKeys[index] : null,
                  width: 400,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text((index + 1).toString()),
                    ),
                    title: Text(
                      userList[index].name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    trailing: Text(
                      userList[index].points.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
