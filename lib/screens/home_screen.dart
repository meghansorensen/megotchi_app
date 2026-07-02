import 'package:flutter/material.dart';
import 'dart:typed_data';
import '../widgets/megotchi_widget.dart';
import '../models/megotchi.dart'; // 1. Added this so the app understands what a Megotchi is!
import 'drawing_screen.dart';     // 2. Added this so we can jump to the drawing canvas

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 3. This is where 'myMegotchi' lives now!
  late Megotchi myMegotchi;

  @override
  void initState() {
    super.initState();
    // 4. Set Mochi's starting name here
    myMegotchi = Megotchi(name: "Mochi");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE6),
      appBar: AppBar(
        title: Text(myMegotchi.name),
        actions: [
          // 5. This button lets you jump to the drawing screen
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final Uint8List? drawnBytes = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DrawingScreen()),
              );
              
              if (drawnBytes != null) {
                setState(() {
                  myMegotchi.customImageBytes = drawnBytes;
                });
              }
            },
          ),
        ],
      ),
      body: Center(
        // 6. Now myMegotchi is perfectly defined and passed in!
        child: MegotchiWidget(megotchi: myMegotchi),
      ),
    );
  }
}