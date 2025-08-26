import 'dart:async';
import 'package:flutter/material.dart';
import 'my_bottom_nav.dart'; // ✅ Custom bottom nav

class SignToTextPage extends StatefulWidget {
  const SignToTextPage({super.key});

  @override
  State<SignToTextPage> createState() => _SignToTextPageState();
}

class _SignToTextPageState extends State<SignToTextPage>
    with TickerProviderStateMixin {
  bool isRecording = false;
  int seconds = 0;
  Timer? timer;

  late AnimationController pulseController;

  @override
  void initState() {
    super.initState();
    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.95,
      upperBound: 1.05,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    timer?.cancel();
    pulseController.dispose();
    super.dispose();
  }

  void _toggleRecording() {
    setState(() {
      if (isRecording) {
        isRecording = false;
        timer?.cancel();
        seconds = 0;
      } else {
        isRecording = true;
        timer = Timer.periodic(const Duration(seconds: 1), (t) {
          setState(() => seconds++);
        });
      }
    });
  }

  void _navigateTo(String route) {
    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD6EAFF), Color(0xFFFDEBDC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 🔹 Camera placeholder overlay (optional)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1517048676732-d65bc937f952?q=80&w=2070&auto=format&fit=crop",
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black26, BlendMode.darken), // darken for readability
              ),
            ),
          ),

          // 🔹 Overlay UI
          Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.only(top: 50, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: const [
                    Text(
                      "Sign to Text",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Position the person signing within the frame.",
                      style: TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Recording Controls
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Center(
                  child: isRecording
                      ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Stop Button with pulse
                      ScaleTransition(
                        scale: pulseController,
                        child: ElevatedButton(
                          onPressed: _toggleRecording,
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: Colors.redAccent,
                            padding: const EdgeInsets.all(24),
                            shadowColor: Colors.redAccent.withOpacity(0.5),
                            elevation: 12,
                          ),
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Timer
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: const Offset(0, 2))
                          ],
                        ),
                        child: Text(
                          _formatTime(seconds),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  )
                      : ScaleTransition(
                    scale: pulseController,
                    child: ElevatedButton(
                      onPressed: _toggleRecording,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(28),
                        shadowColor: Colors.blueAccent.withOpacity(0.5),
                        elevation: 12,
                        backgroundColor: const Color(0xFF3B82F6),
                      ),
                      child: const Icon(
                        Icons.videocam,
                        size: 36,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      bottomNavigationBar: MyBottomNav(
        currentIndex: 3, // Sign-to-Text active
        onTap: (index) {
          switch (index) {
            case 0:
              _navigateTo("/home");
              break;
            case 1:
              _navigateTo("/text_translation");
              break;
            case 2:
              _navigateTo("/eng_to_sign");
              break;
            case 3:
              _navigateTo("/sign_to_text");
              break;
          }
        },
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }
}
