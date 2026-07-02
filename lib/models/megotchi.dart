import 'dart:typed_data'; // Add this import at the very top of your file

class Megotchi {
  String name;
  int happiness;
  int hunger;
  int energy;
  int level;
  int coins;
  Uint8List? customImageBytes; // Stores the raw custom drawing bytes

  Megotchi({
    required this.name,
    this.happiness = 80,
    this.hunger = 60,
    this.energy = 70,
    this.level = 1,
    this.coins = 125,
    this.customImageBytes, // Initialized as empty/null by default
  });

  void feed() {
    hunger = (hunger + 20).clamp(0, 100);
    happiness = (happiness + 10).clamp(0, 100);
  }

  void play() {
    happiness = (happiness + 15).clamp(0, 100);
    energy = (energy - 10).clamp(0, 100);
  }

  void sleep() {
    energy = (energy + 25).clamp(0, 100);
  }
}