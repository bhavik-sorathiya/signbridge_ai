import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'my_bottom_nav.dart';

class SignToEnglishPage extends StatefulWidget {
  const SignToEnglishPage({super.key});

  @override
  State<SignToEnglishPage> createState() => _SignToEnglishPageState();
}

class _SignToEnglishPageState extends State<SignToEnglishPage>
    with TickerProviderStateMixin {
  bool isRecording = false;
  int seconds = 0;
  bool permissionGranted = false;

  List<CameraDescription> cameras = [];
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;
  Timer? _timer;
  CameraLensDirection currentLens = CameraLensDirection.front;

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

    _requestPermissionAndSetupCamera();
  }

  Future<void> _requestPermissionAndSetupCamera() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      setState(() => permissionGranted = true);
      cameras = await availableCameras();
      await _initializeCamera(currentLens);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Camera permission is required")),
        );
      }
    }
  }

  Future<void> _initializeCamera(CameraLensDirection lensDirection) async {
    if (cameras.isEmpty) return;

    final camera = cameras.firstWhere(
          (cam) => cam.lensDirection == lensDirection,
      orElse: () => cameras.first,
    );

    await _cameraController?.dispose();
    _cameraController =
        CameraController(camera, ResolutionPreset.medium, enableAudio: false);
    _initializeControllerFuture = _cameraController!.initialize();
    if (mounted) setState(() {});
  }

  void toggleRecording() {
    setState(() {
      isRecording = !isRecording;
      if (isRecording) {
        seconds = 0;
        _timer = Timer.periodic(
            const Duration(seconds: 1), (timer) => setState(() => seconds++));
      } else {
        _timer?.cancel();
      }
    });
  }

  void switchCamera() async {
    if (cameras.length < 2) return;
    currentLens = currentLens == CameraLensDirection.front
        ? CameraLensDirection.back
        : CameraLensDirection.front;
    await _initializeCamera(currentLens);
  }

  void _onNavTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, "/home");
        break;
      case 1:
        Navigator.pushReplacementNamed(context, "/text_translation");
        break;
      case 2:
        Navigator.pushReplacementNamed(context, "/eng_to_sign");
        break;
      case 3:
        break;
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _timer?.cancel();
    pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWideScreen = width > 600;

    return Scaffold(
      extendBody: true,
      body: permissionGranted
          ? Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD6EAFF), Color(0xFFFDEBDC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Camera Preview
          FutureBuilder(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  _cameraController != null &&
                  _cameraController!.value.isInitialized) {
                return CameraPreview(_cameraController!);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          // Scrollable overlay
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildFrostedCard(
                    child: Text(
                      "Sign to English",
                      style: TextStyle(
                        fontSize: isWideScreen ? 26 : 22,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2C3E50),
                      ),
                    ),
                  ),
                  _buildFrostedCard(
                    child: Text(
                      "Position the person signing within the frame.",
                      style: TextStyle(
                        fontSize: isWideScreen ? 16 : 14,
                        color: const Color(0xFF2C3E50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 300), // Spacer for camera buttons
                ],
              ),
            ),
          ),
          // Recording Controls
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Record Button
                  ScaleTransition(
                    scale: pulseController,
                    child: FloatingActionButton(
                      backgroundColor: isRecording
                          ? Colors.redAccent
                          : const Color(0xFF3B82F6),
                      onPressed: toggleRecording,
                      child: isRecording
                          ? Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      )
                          : const Icon(Icons.videocam, size: 36),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Timer
                  if (isRecording)
                    _buildFrostedCard(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: Text(
                        "00:${seconds.toString().padLeft(2, '0')}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF2C3E50),
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                    ),
                  const SizedBox(width: 16),
                  // Switch Camera
                  if (cameras.length > 1)
                    FloatingActionButton(
                      backgroundColor: Colors.green,
                      onPressed: switchCamera,
                      child: const Icon(Icons.cameraswitch),
                    ),
                ],
              ),
            ),
          ),
        ],
      )
          : Center(
        child: ElevatedButton(
          onPressed: _requestPermissionAndSetupCamera,
          child: const Text("Grant Camera Permission"),
        ),
      ),
      bottomNavigationBar: MyBottomNav(
        currentIndex: 3,
        onTap: _onNavTapped,
      ),
    );
  }

  Widget _buildFrostedCard({required Widget child, EdgeInsets? padding}) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            padding: padding ?? const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
