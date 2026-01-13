import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:go_router/go_router.dart'; // Import go_router untuk navigasi

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Menunggu 3 detik, lalu navigasi ke halaman Auth
    Future.delayed(const Duration(seconds: 3), () {
      context.goNamed('auth'); // Navigasi ke 'auth' route setelah 3 detik
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background putih
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Rentara', // Splash screen text
                    textStyle: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Black color for contrast on white
                    ),
                    speed: const Duration(milliseconds: 150),
                  ),
                ],
                isRepeatingAnimation: false,
                onFinished: () {
                  // Any action when animation finishes, if required
                },
              ),
              const SizedBox(height: 20),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.black, // Adjust spinner color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
