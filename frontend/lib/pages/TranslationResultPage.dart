import 'package:flutter/material.dart';
import 'my_bottom_nav.dart'; // ✅ Import your custom bottom nav

class TranslationResultPage extends StatelessWidget {
  const TranslationResultPage({super.key});

  void _navigate(BuildContext context, String route) {
    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Aurora gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF4B4D4), // aurora pink
                  Color(0xFFD5C4E9), // aurora lavender
                  Color(0xFFA3C1F1), // aurora blue
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Page Content
          Column(
            children: [
              // Header
              AppBar(
                title: const Text(
                  "Translation Result",
                  style: TextStyle(
                    color: Color(0xFF1F2937), // dark text
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.white.withOpacity(0.7),
                elevation: 0,
              ),

              // Main content
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Frosted glass card with sign image
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            "https://lh3.googleusercontent.com/aida-public/AB6AXuBcL9UfT1BDlzdM7eBxN87rrDPEO8m7i4Eklcc2hoDzVQ4bxyK10KJipV4KTKYtXT7WSEogHOR3O4fd8ddMgV3Zxvx29R0GmFtW_v27eG4-FPchxoDu3X21pbhRW_vbBIkt0qBvyjFYKCJ09Und-yP55zT-vAagJUj8ZAHkYLusqtPCW__RQ42h4s5THXgTyK9lPOjEBmCJClTwpIGubiGxjo2KFdlxHEI8fhkr7qIQ7zKtP1pYBfQxMEgbx4DJCO9Z-e8BTIKubPM",
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Text
                      const Text(
                        "Original Text:",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        "Hello",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Translate Another Button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF58A6FF), // primary blue
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                    ),
                    onPressed: () {
                      // Navigate back to TextTranslationPage
                      Navigator.pushReplacementNamed(context, "/text");
                    },
                    child: const Text(
                      "Translate Another",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      // 🔹 Reusable Bottom Navigation
      bottomNavigationBar: MyBottomNav(
        currentIndex: -1, // This page is not part of main nav flow
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
              _navigate(context, "/sign_to_text");
              break;
          }
        },
      ),
    );
  }
}
