import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'models/megotchi.dart';
import 'widgets/stat_card.dart';
import 'widgets/action_button.dart';
import 'widgets/megotchi_widget.dart';
import 'screens/drawing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Megotchi myMegotchi;

  @override
  void initState() {
    super.initState();
    myMegotchi = Megotchi(name: "Mochi");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE6), // Cute light cream background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Profile Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        myMegotchi.name,
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.grey),
                        onPressed: () async {
                          // Navigate to Drawing Studio and wait for image bytes
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Image.asset('lib/images/coin.png', width: 20, height: 20),
                        const SizedBox(width: 4),
                        Text('${myMegotchi.coins}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),

              // The Central Pet Widget
              MegotchiWidget(megotchi: myMegotchi),

              // The Stats Row
              Row(
                children: [
                  StatCard(
                    label: 'Happiness',
                    iconPath: 'lib/images/heart.png',
                    value: myMegotchi.happiness,
                    color: Colors.pink,
                  ),
                  StatCard(
                    label: 'Hunger',
                    iconPath: 'lib/images/strawberry.png',
                    value: myMegotchi.hunger,
                    color: Colors.orange,
                  ),
                  StatCard(
                    label: 'Energy',
                    iconPath: 'lib/images/energy.png',
                    value: myMegotchi.energy,
                    color: Colors.blue,
                  ),
                ],
              ),

              // The Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ActionButton(
                    label: 'Feed',
                    iconPath: 'lib/images/strawberry.png',
                    color: Colors.green,
                    onTap: () {
                      setState(() {
                        myMegotchi.feed();
                      });
                    },
                  ),
                  ActionButton(
                    label: 'Play',
                    iconPath: 'lib/images/game.png',
                    color: Colors.indigo,
                    onTap: () {
                      setState(() {
                        myMegotchi.play();
                      });
                    },
                  ),
                  ActionButton(
                    label: 'Sleep',
                    iconPath: 'lib/images/moon.png',
                    color: Colors.purple,
                    onTap: () {
                      setState(() {
                        myMegotchi.sleep();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}