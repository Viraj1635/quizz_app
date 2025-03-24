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
  int _score = 0;
  int _questionIndex = 0;
  int? _selectedOption;
  final TextEditingController _textAnswerController = TextEditingController();

  final List<Map<String, dynamic>> _questions = [
    {
      'type': 'mcq',
      'question': 'If it takes 5 hours for 5 men to dig 5 holes, how long does it take for 100 men to dig 100 holes?',
      'options': ['1 Hour', '2 Hours', '5 Hours', '10 Hours'],
      'correctAnswer': 2
    },
    {
      'type': 'text',
      'question': 'What is the capital of France?',
      'correctAnswer': 'paris'
    },
    {
      'type': 'mcq',
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Earth', 'Mars', 'Jupiter', 'Venus'],
      'correctAnswer': 1
    }
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
    _textAnswerController.dispose();
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

  void _nextQuestion() {

    _calculateScore();

    FocusScope.of(context).unfocus();

    setState(() {
      if (_questionIndex < _questions.length - 1) {
        _questionIndex++;
        _selectedOption = null;
        _textAnswerController.clear();
      } else {
        _endQuiz();  // ✅ Quiz ends after last question
      }
    });
  }

  void _calculateScore() {
    final currentQuestion = _questions[_questionIndex];

    if (currentQuestion['type'] == 'mcq') {
      if (_selectedOption == currentQuestion['correctAnswer']) {
        _score++;  // ✅ Add 1 if MCQ answer is correct
      }
    } else if (currentQuestion['type'] == 'text') {
      if (_textAnswerController.text.trim().toLowerCase() == currentQuestion['correctAnswer']) {
        _score++;  // ✅ Add 1 if text answer is correct
      }
    }
  }

  void _endQuiz() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          score: _score,  // ✅ Send final score
          totalQuestions: _questions.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentQuestion = _questions[_questionIndex];

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
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
                  currentQuestion['question'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Question Type: MCQ or Text Input
              currentQuestion['type'] == 'mcq'
                  ? _buildMultipleChoiceOptions(currentQuestion['options'])
                  : _buildTextInput(),

              const Spacer(),

              // Next / Finish Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextQuestion,
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
      ),
    );
  }

  Widget _buildTextInput() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: _textAnswerController,
        decoration: InputDecoration(
          hintText: "Type your answer here...",
          filled: true,
          fillColor: theme.colorScheme.surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildMultipleChoiceOptions(List<String> options) {
    final theme = Theme.of(context);
    return Column(
      children: options.asMap().entries.map((entry) {
        int index = entry.key;
        String text = entry.value;
        bool isSelected = _selectedOption == index;

        return GestureDetector(
          onTap: () => _selectOption(index),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: isSelected ? theme.colorScheme.primaryContainer : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
                width: 2.0,
              ),
            ),
            child: Text(
              text,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
            ),
          ),
        );
      }).toList(),
    );
  }
}
