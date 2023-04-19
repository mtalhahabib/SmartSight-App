import 'package:flutter/material.dart';
import 'package:fyp/home.dart';
import 'package:fyp/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FYP",
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => MyLoadingScreen(),
        '/home': (context) => MyHomePage(),
      },
    );
  }
}

