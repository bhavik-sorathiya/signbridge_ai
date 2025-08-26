import 'package:flutter/material.dart';

// Import all your pages
import 'pages/Homepage.dart';
import 'pages/Loadingpage.dart';
import 'pages/EngToSignPage.dart';
import 'pages/TextTranslationPage.dart';
import 'pages/TranslationResultPage.dart';
import 'pages/SignToEnglishPage.dart';
import 'pages/SignToTextPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SignBridge",
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // Start with LoadingPage
      initialRoute: '/loading',

      // Routes for navigation
      routes: {
        '/home': (context) => const Homepage(),
        '/loading': (context) => const Loadingpage(),
        '/eng_to_sign': (context) => const EngToSignPage(),
        '/text_translation': (context) => const TextTranslationPage(),
        '/translation_result': (context) => const TranslationResultPage(),
        '/sign_to_english': (context) => const SignToEnglishPage(),
        '/sign_to_text': (context) => const SignToTextPage(),
      },
    );
  }
}
