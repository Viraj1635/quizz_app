import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/screens/result.dart';

class Testscreen extends StatefulWidget {
  const Testscreen({super.key});

  @override
  State<Testscreen> createState() => _TestscreenState();
}

class _TestscreenState extends State<Testscreen> {
  int _time = 120;
  Timer? _timer;
  int _questionIndex = 0;
  int? _selectedOption;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'If it takes 5 hours for 5 men to dig 5 holes, how long does it take for 100 men to dig 100 holes?',
      'options': ['1 Hour', '2 Hours', '5 Hours', '10 Hours'],
      'correctAnswer': 2
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_time > 0) {
        setState(() {
          _time--;
        });
      } else {
        _timer?.cancel();
        _endQuiz();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final minutes = _time ~/ 60;
    final seconds = _time % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _selectOption(int index) {
    setState(() {
      _selectedOption = index;
    });
  }

  void _endQuiz() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          score: _calculateScore(),
          totalQuestions: _questions.length,
        ),
      ),
    );
  }

  int _calculateScore() {
    return _selectedOption == _questions[_questionIndex]['correctAnswer'] ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(theme.colorScheme.onPrimary),
          ),
        ),
        title: Text(
          'Aptitude Test',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Icon(CupertinoIcons.clock, color: theme.colorScheme.surface, size: 18),
                const SizedBox(width: 6),
                Text(
                  _formattedTime,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Question Number
            Text(
              "Question ${_questionIndex + 1} of ${_questions.length}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),

            // Question Text
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _questions[_questionIndex]['question'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Multiple Choice Options
            ..._buildMultipleChoiceOptions(_questions[_questionIndex]['options']),

            const Spacer(),

            // Next / Finish Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_questionIndex < _questions.length - 1) {
                      _questionIndex++;
                      _selectedOption = null;
                    } else {
                      _endQuiz();
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  _questionIndex < _questions.length - 1 ? 'Next' : 'Finish',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMultipleChoiceOptions(List<String> options) {
    final theme = Theme.of(context);
    final Color selectedColor = theme.colorScheme.primaryContainer;
    final Color selectedBorderColor = theme.colorScheme.primary;
    final Color defaultBorderColor = theme.colorScheme.outlineVariant;

    return options.asMap().entries.map((entry) {
      int index = entry.key;
      String text = entry.value;
      final bool isSelected = _selectedOption == index;

      return GestureDetector(
        onTap: () => _selectOption(index),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: isSelected ? selectedColor : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: isSelected ? selectedBorderColor : defaultBorderColor,
              width: 2.0,
            ),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: 2,
              )
            ]
                : [],
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? selectedBorderColor : defaultBorderColor,
                    width: 2.0,
                  ),
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
