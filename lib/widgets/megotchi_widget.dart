import 'package:flutter/material.dart';
import '../models/megotchi.dart'; // Handles the connection to your model file

class MegotchiWidget extends StatelessWidget {
  final Megotchi megotchi;

  // This constructor now demands the Megotchi data!
  const MegotchiWidget({super.key, required this.megotchi});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. The Speech Bubble
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('lib/images/heart.png', width: 20, height: 20),
              const SizedBox(width: 8),
              const Text(
                'I feel happy!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFF5D4037),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        // 2. The Megotchi Character Image
        megotchi.customImageBytes != null
            ? Image.memory(
                megotchi.customImageBytes!,
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              )
            : Image.asset(
                'lib/images/megotchi.png',
                width: 180,
                height: 180,
              ),
      ],
    );
  }
}