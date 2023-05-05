import 'package:flutter/material.dart';
import 'package:fyp/provider/fyp_provider.dart';
import 'package:fyp/provider/splash_provider.dart';
import 'package:fyp/splash.dart';
import 'package:provider/provider.dart';

import 'aws/check.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   // return MaterialApp(home : AWS());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (_) => SplashProvider()),
        ChangeNotifierProvider(create:  (_) => FypProvider())
      ],

      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: "FYP",
        home: MyLoadingScreen(),
      ),
    );
  }
}

