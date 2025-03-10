import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:quizz_app/screens/test.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int totalQuestions;

  const ResultScreen({Key? key, required this.score, required this.totalQuestions}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 5));

    // If user gets a perfect score, start confetti
    if (widget.score == widget.totalQuestions) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color backgroundColor = theme.colorScheme.surface;
    final Color textColor = theme.colorScheme.onSurface;
    final Color cardColor = theme.colorScheme.secondaryContainer;
    final Color buttonColor = theme.colorScheme.primary;
    final Color buttonTextColor = theme.colorScheme.onPrimary;

    // Performance Message Logic
    String performanceMessage;
    if (widget.score == widget.totalQuestions) {
      performanceMessage = "🌟 Excellent! Perfect Score! 🌟";
    } else if (widget.score > widget.totalQuestions * 0.7) {
      performanceMessage = "🎯 Great Job! You did really well!";
    } else if (widget.score > widget.totalQuestions * 0.5) {
      performanceMessage = "🙂 Not bad! Keep Practicing.";
    } else {
      performanceMessage = "📖 Keep Learning! You can do better.";
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.star,
                    size: 80,
                    color: Colors.amber,
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    "Test Completed!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Performance Message
                  Text(
                    performanceMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Score Container
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.colorScheme.primary, width: 2),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Your Score",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${widget.score} / ${widget.totalQuestions}",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Retry Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Testscreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        foregroundColor: buttonTextColor,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Retry Test',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Go Back Button
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Go Back",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
          // Confetti Animation (Triggers on perfect score)
          if (widget.score == widget.totalQuestions)
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter, // Confetti starts from the top
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: -pi / 2, // Shoots straight up
                  emissionFrequency: 0.08, // More particles per second
                  numberOfParticles: 30, // Higher quantity
                  maxBlastForce: 15, // Faster explosion
                  minBlastForce: 10, // Ensures variation in speed
                  gravity: 0.2, // Faster fall-down effect
                  shouldLoop: false,
                  blastDirectionality: BlastDirectionality.explosive,
                ),
              ),
            ),


        ],
      ),
    );
  }
}
