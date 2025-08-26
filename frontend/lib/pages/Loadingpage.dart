import 'package:flutter/material.dart';

class Loadingpage extends StatefulWidget {
  const Loadingpage({super.key});

  @override
  State<Loadingpage> createState() => _LoadingpageState();
}

class _LoadingpageState extends State<Loadingpage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Animation controller for icons/progress
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 4))
      ..repeat();

    // Navigate to HomePage after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔹 Gradient Circle
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF4A90E2), Color(0xFFF56565)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.waving_hand, // placeholder logo
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 🔹 Title & subtitle
              const Text(
                "SignBridge",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Breaking the silence, building the bridge.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF333333),
                ),
              ),

              const SizedBox(height: 40),

              // 🔹 Animated Icons Row
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  double progress = _controller.value * 4;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _fadeIcon(Icons.hearing, 0, progress, Colors.blue),
                      const SizedBox(width: 16),
                      _fadeIcon(Icons.waving_hand, 1, progress, Colors.redAccent),
                      const SizedBox(width: 16),
                      _fadeIcon(Icons.chat_bubble, 2, progress, Colors.blue),
                      const SizedBox(width: 16),
                      _fadeIcon(Icons.connect_without_contact, 3, progress, Colors.redAccent),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),

              // 🔹 Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  minHeight: 8,
                  backgroundColor: const Color(0xFFA8D1FF),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF4A90E2)),
                  value: _controller.value,
                ),
              ),

              const SizedBox(height: 12),
              const Text(
                "Connecting...",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Helper method for animated icons
  Widget _fadeIcon(IconData icon, int index, double progress, Color color) {
    double opacity = (progress - index).clamp(0.0, 1.0);
    return Opacity(
      opacity: opacity,
      child: Icon(icon, size: 40, color: color),
    );
  }
}
