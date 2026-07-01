import 'package:flutter/material.dart';

class MegotchiWidget extends StatelessWidget {
  const MegotchiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          '(•ᴗ•)',
          style: TextStyle(fontSize: 60),
        ),
        Text(
          'Megotchi',
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}