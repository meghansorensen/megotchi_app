import 'package:flutter/material.dart';
import '../widgets/megotchi_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MegotchiWidget(),
      ),
    );
  }
}