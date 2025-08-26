import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FastAPI Fetch Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String message = "Fetching...";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // replace with your FastAPI server URL, e.g. http://127.0.0.1:8000/
      final response = await http.get(Uri.parse("http://10.0.2.2:8000/"));
      // NOTE: use 10.0.2.2 instead of localhost for Android emulator

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          message = data["Hello"];
        });
      } else {
        setState(() {
          message = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        message = "Failed to connect: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FastAPI + Flutter")),
      body: Center(
        child: Text(message, style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}