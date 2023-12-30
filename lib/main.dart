import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:puzzelpause/pages/game.dart';
import 'package:puzzelpause/pages/home.dart';
import 'package:puzzelpause/pages/leaderboard.dart';
import 'package:puzzelpause/pages/login.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
