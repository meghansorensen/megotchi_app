import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DrawingScreen extends StatefulWidget {
  final Uint8List? initialImageBytes;

  const DrawingScreen({super.key, this.initialImageBytes});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  List<Offset?> _points = [];
  final GlobalKey _globalKey = GlobalKey();
  
  // Local storage for the background drawing that we can modify or delete
  Uint8List? _currentBackgroundBytes;
  
  // Version tracker used to force the layout tree to wipe clean on reset
  int _canvasVersion = 0;

  @override
  void initState() {
    super.initState();
    _currentBackgroundBytes = widget.initialImageBytes;
  }

  Future<void> _saveDrawing() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();
        Navigator.pop(context, pngBytes);
      }
    } catch (e) {
      print("Error saving image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE6),
      appBar: AppBar(
        title: const Text('Adopt a Pet'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: RepaintBoundary(
                key: _globalKey,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      _points.add(details.localPosition);
                    });
                  },
                  onPanEnd: (details) {
                    _points.add(null);
                  },
                  child: Container(
                    key: ValueKey(_canvasVersion), // Crucial: Wipes both background image and strokes on update!
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.amber.shade200, width: 4),
                    ),
                    child: Stack(
                      children: [
                        // Layer 1: The old drawing background
                        if (_currentBackgroundBytes != null)
                          Image.memory(
                            _currentBackgroundBytes!,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        // Layer 2: New brush strokes
                        CustomPaint(
                          painter: DrawingPainter(points: _points),
                          size: Size.infinite,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Button 1: Clear Strokes
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _points.clear();
                      _canvasVersion++; // Redraws a clean canvas layer
                    });
                  },
                  icon: const Icon(Icons.undo),
                  label: const Text('Clear Strokes'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
                ),
                // Button 2: Start Over
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _points.clear();
                      _currentBackgroundBytes = null; // Wipes out initial picture data
                      _canvasVersion++; // Forces the entire box to dump its state clean
                    });
                  },
                  icon: const Icon(Icons.restart_alt_rounded),
                  label: const Text('Start Over'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                ),
                // Button 3: Save & Adopt
                ElevatedButton.icon(
                  onPressed: _saveDrawing,
                  icon: const Icon(Icons.check),
                  label: const Text('Save & Adopt'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;
  DrawingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) => true;
}