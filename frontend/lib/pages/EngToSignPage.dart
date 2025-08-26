import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'my_bottom_nav.dart';

class EngToSignPage extends StatefulWidget {
  const EngToSignPage({super.key});

  @override
  State<EngToSignPage> createState() => _EngToSignPageState();
}

class _EngToSignPageState extends State<EngToSignPage>
    with TickerProviderStateMixin {
  bool isListening = false;

  late AnimationController waveController;
  late AnimationController stopButtonController;

  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();

    // Wave animation controller
    waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Stop button pulse
    stopButtonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      lowerBound: 0.95,
      upperBound: 1.1,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    waveController.dispose();
    stopButtonController.dispose();
    super.dispose();
  }

  void _onNavTapped(int index) {
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/text_translation');
        break;
      case 2:
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/sign_to_english');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWideScreen = width > 600;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD6EAFF), Color(0xFFFDEBDC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "SignBridge",
                    style: TextStyle(
                      fontSize: isWideScreen ? 44 : 36,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C3E50),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: isWideScreen ? 600 : double.infinity),
                        child: isListening
                            ? _buildListeningView(isWideScreen)
                            : _buildDefaultView(isWideScreen),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
      MyBottomNav(currentIndex: _currentIndex, onTap: _onNavTapped),
    );
  }

  Widget _buildDefaultView(bool isWideScreen) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Input box
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.white.withOpacity(0.4)),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: TextField(
            style: const TextStyle(color: Color(0xFF1F2937), fontSize: 18),
            decoration: InputDecoration(
              hintText: "Type or tap the mic to speak...",
              hintStyle: const TextStyle(color: Color(0xFF6B7280)),
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.mic, color: Color(0xFF3B82F6), size: 28),
                onPressed: () => setState(() => isListening = true),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: isWideScreen ? 300 : double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              elevation: 10,
              shadowColor: const Color(0xFF3B82F6).withOpacity(0.4),
            ),
            onPressed: () => Navigator.pushNamed(context, '/translation_result'),
            child: const Text(
              "Translate",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListeningView(bool isWideScreen) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Listening...",
          style: TextStyle(
            color: Color(0xFF2C3E50),
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 40),

        // Live Moving Waves
        SizedBox(
          height: 140,
          width: double.infinity,
          child: AnimatedBuilder(
            animation: waveController,
            builder: (context, child) {
              return CustomPaint(
                painter: LiveWavePainter(waveController.value),
                size: const Size(double.infinity, 140),
              );
            },
          ),
        ),
        const SizedBox(height: 50),

        // Animated Stop Button
        ScaleTransition(
          scale: stopButtonController,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.all(50),
                shape: const CircleBorder(),
                elevation: 0,
              ),
              onPressed: () => setState(() => isListening = false),
              child: const Text(
                "Stop\nTranslate",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                        color: Colors.black26,
                        offset: Offset(1, 2),
                        blurRadius: 3)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Live Wave Painter (vertical moving waves)
class LiveWavePainter extends CustomPainter {
  final double progress;
  LiveWavePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..shader = const LinearGradient(
        colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6), Color(0xFFEC4899)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final path2 = Path();

    for (double x = 0; x <= size.width; x++) {
      double y1 = size.height / 2 +
          20 * math.sin((x / size.width * 3 * math.pi) + progress * 2 * math.pi) +
          10 * math.sin(progress * 2 * math.pi * 3 + x / 50); // vertical shift
      double y2 = size.height / 2 +
          20 * math.cos((x / size.width * 3 * math.pi) + progress * 2 * math.pi) +
          10 * math.cos(progress * 2 * math.pi * 3 + x / 50); // vertical shift

      if (x == 0) {
        path.moveTo(x, y1);
        path2.moveTo(x, y2);
      } else {
        path.lineTo(x, y1);
        path2.lineTo(x, y2);
      }
    }

    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant LiveWavePainter oldDelegate) => true;
}
