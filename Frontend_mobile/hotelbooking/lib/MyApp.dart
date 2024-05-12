import 'package:flutter/material.dart';
import 'package:hotelbooking/browse_screen.dart';
import 'package:hotelbooking/find_my_room_screen.dart';

import 'splash_screen.dart';
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}