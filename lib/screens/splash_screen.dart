import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quizz_app/screens/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to Login or Home after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [theme.colorScheme.surfaceVariant, theme.colorScheme.background] // Dark Mode Colors
                : [theme.colorScheme.onSecondary, theme.colorScheme.inversePrimary, theme.colorScheme.inversePrimary, theme.colorScheme.primary], // Light Mode Colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🎨 App Logo with Fade-in Effect
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 2),
              builder: (context, double opacity, child) {
                return Opacity(opacity: opacity, child: child);
              },
              child: Column(
                children: [
                  // 🔹 Replace with your actual logo
                  Icon(Icons.quiz, size: 100, color: theme.colorScheme.primary),
                  const SizedBox(height: 20),
                  Text(
                    "Quiz App",
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
