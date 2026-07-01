import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class MegotchiApp extends StatelessWidget {
  const MegotchiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Megotchi',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}