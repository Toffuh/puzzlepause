import 'package:flutter/material.dart';
import 'package:puzzelpause/pages/game.dart';
import 'package:puzzelpause/pages/home.dart';
import 'package:puzzelpause/pages/leaderboard.dart';
import 'package:puzzelpause/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => const Home(),
        "/game": (context) => const Game(),
        "/leaderboard": (context) => const Leaderboard(),
        "/login": (context) => const Login()
      },
      initialRoute: "/",
    );
  }
}
