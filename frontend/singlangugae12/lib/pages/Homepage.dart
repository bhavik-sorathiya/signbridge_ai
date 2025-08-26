import 'dart:ui';
import 'package:flutter/material.dart';
import 'my_bottom_nav.dart'; // Reusable footer

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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
          // 🔹 Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD6EAFF), Color(0xFFFDEBDC)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 🔹 Aurora shapes
          Positioned(
            top: -100,
            left: -100,
            child: _auroraShape(300, Colors.pinkAccent.withOpacity(0.4)),
          ),
          Positioned(
            bottom: -150,
            right: -150,
            child: _auroraShape(400, Colors.purple.withOpacity(0.4)),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            right: -50,
            child: _auroraShape(250, const Color(0xFF6CA0DC).withOpacity(0.2)),
          ),

          // 🔹 Page Content
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 24),
                      const Text(
                        "SignBridge",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.settings, color: Color(0xFF2C3E50)),
                      )
                    ],
                  ),
                ),

                // Cards
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        _FrostedCard(
                          title: "Translate English to Sign",
                          imageUrl:
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuApxXERsnRsBY1uWc7e2jfDwW3ar__HEqco-xUSIkzvoHJ7y91ztJYfNrW9csTO9Ha59VDsWrMg9VErilClloonD4cDuKKjbzoLoD_NSEdAtRdrp1YFtcjnw1OTVozcrXkX5CVVR1xdnQcaImjDLAiYCtTRDBp9y6-KSvo6T773HKAscb7RNspJGJ0sOex8wGxifNN1wdnerLSN_4XE-om0464WuOIHXwLS1m2fV3KyM25dZeBJgIpPQSksZp9J1pEami25uUPQskk",
                          onTap: () => _navigate(context, "/eng_to_sign"),
                          isWideScreen: isWideScreen,
                        ),
                        const SizedBox(height: 20),
                        _FrostedCard(
                          title: "Translate Sign to English",
                          imageUrl:
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuBGzhIXcDcU7PDWX26AJhEN95Etlw3zXngX1u2P2tfXyJSYgwFU-p0k6ml2t2D8qepCLzzXu7-Tq9QQFmCWhL4GhMCgzXYSz_YJTRHXOLDqThiS_RQnT3wu5UYpttAaNc9ZOKYZApqPZSURRRL-Ky1UV0EJL_DEDr6R_hIoxyS18OzVCNqJP4dZ49OshFoQ6chyD1LpH1Su8zmenqocB_ZNcmF0RxTGF80YJTP4cCVANCopuB5a3KdsnOC1TfVD14_-CdTKG5sAIKw",
                          onTap: () => _navigate(context, "/sign_to_english"),
                          isWideScreen: isWideScreen,
                        ),
                        const SizedBox(height: 20),
                        _FrostedCard(
                          title: "Standard Text Translator",
                          imageUrl:
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuBmuS0qDYiEeFtKbIDvoJeze5wIco6q-a2M9ewnojlIsbveo9IVW3gUq8DuKk95Dkjypmyo65K3DdD5T6074yEXjaK8gGgAglBthekDfbh3TPOhqqkmK4bpd15oOFqusWbm6WJzD6ceBMucTb80D2_bR-rgdNosTpRnWL1zndvALszaziUrciG8v94gtnm8evRHYbOCWR5EzrRRAX3eiNtxyem4VATyVkP_klObFOSdgn1QqknMQSbQYgwhX7bYCi7fBNe3Wv5N_L0",
                          onTap: () => _navigate(context, "/text_translation"),
                          isWideScreen: isWideScreen,
                        ),
                        const SizedBox(height: 40), // extra bottom padding
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: MyBottomNav(
        currentIndex: 0, // Home is active
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

  // Aurora Shape
  Widget _auroraShape(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}

// Frosted Card
class _FrostedCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;
  final bool isWideScreen;

  const _FrostedCard({
    required this.title,
    required this.imageUrl,
    required this.onTap,
    required this.isWideScreen,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        constraints: BoxConstraints(maxWidth: isWideScreen ? 600 : double.infinity),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.4)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6CA0DC).withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network(imageUrl, height: 100, width: 100, fit: BoxFit.cover),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
