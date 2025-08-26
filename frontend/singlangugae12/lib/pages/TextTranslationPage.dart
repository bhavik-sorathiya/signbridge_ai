import 'dart:ui';
import 'package:flutter/material.dart';
import 'my_bottom_nav.dart';

class TextTranslationPage extends StatelessWidget {
  const TextTranslationPage({super.key});

  void _navigate(BuildContext context, String route) {
    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.pushReplacementNamed(context, route);
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
          // 🔹 Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD6EAFF), Color(0xFFFDEBDC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 🔹 Content
          Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Text Translation",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                ),
              ),

              // Main Card
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: isWideScreen ? 600 : 400),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withOpacity(0.4)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.1),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Input Language
                          DropdownButtonFormField<String>(
                            value: "English",
                            items: const [
                              DropdownMenuItem(value: "English", child: Text("English")),
                              DropdownMenuItem(value: "Spanish", child: Text("Spanish")),
                              DropdownMenuItem(value: "French", child: Text("French")),
                            ],
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              labelText: "Input Language",
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Input Text
                          TextField(
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: "Enter text...",
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Swap Button
                          Center(
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
                                    color: Colors.purple.withOpacity(0.25),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.compare_arrows, size: 32, color: Colors.white),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Output Language
                          DropdownButtonFormField<String>(
                            value: "American Sign Language (ASL)",
                            items: const [
                              DropdownMenuItem(
                                  value: "American Sign Language (ASL)",
                                  child: Text("American Sign Language (ASL)")),
                              DropdownMenuItem(
                                  value: "British Sign Language (BSL)",
                                  child: Text("British Sign Language (BSL)")),
                            ],
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              labelText: "Output Language",
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Output Text
                          Container(
                            height: 140,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white.withOpacity(0.4)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.05),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Text(
                              "Translation will appear here...",
                              style: TextStyle(
                                color: Color(0xFF2C3E50),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      // 🔹 Bottom Navigation
      bottomNavigationBar: MyBottomNav(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              _navigate(context, "/home");
              break;
            case 1:
              _navigate(context, "/text_translation");
              break;
            case 2:
              _navigate(context, "/eng_to_sign");
              break;
            case 3:
              _navigate(context, "/sign_to_english");
              break;
          }
        },
      ),
    );
  }
}
