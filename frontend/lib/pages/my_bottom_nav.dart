import 'dart:ui';
import 'package:flutter/material.dart';

class MyBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF2C3E50), // dark slate
            unselectedItemColor: const Color(0xFF4A5568), // lighter slate
            showUnselectedLabels: true,
            currentIndex: currentIndex,
            onTap: onTap,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.text_fields), label: "Text"),
              BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: "Eng-to-Sign"),
              BottomNavigationBarItem(icon: Icon(Icons.switch_video), label: "Sign-to-Eng"),
            ],
          ),
        ),
      ),
    );
  }
}
