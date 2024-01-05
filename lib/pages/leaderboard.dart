import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../util/user.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  late List<User> userList = [];

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
      userList.add(User(value["displayName"], value["points"]));
    });

    userList.sort((a, b) => b.points.compareTo(a.points));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 31, 16, 42),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 31, 16, 42),
          leading: IconButton(
            onPressed: () => {Navigator.pushNamed(context, "/")},
            icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                icon: const Icon(Icons.refresh, color: Colors.white))
          ],
        ),
        body: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: SizedBox(
                width: 400,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text((index + 1).toString()),
                  ),
                  title: Text(userList[index].name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
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
            );
          },
        ));
  }
}
