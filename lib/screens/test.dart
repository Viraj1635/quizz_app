import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String? _textAnswer;

  final List<Map<String, dynamic>> _questions = [
    {
      'type': 'multiple',
      'question': 'If it takes 5 hours for 5 men to dig 5 holes, how long does it take for 100 men to dig 100 holes?',
      'options': ['1 Hour', '2 Hours', '5 Hours', '10 Hours'],
      'correctAnswer': 2
    },
    {
      'type': 'text',
      'question': 'Explain the theory of relativity in brief.',
      'correctAnswer': 'Explanation should be correct'
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
    int score = 0;
    if (_questions[_questionIndex]['type'] == 'multiple' &&
        _selectedOption == _questions[_questionIndex]['correctAnswer']) {
      score++;
    } else if (_questions[_questionIndex]['type'] == 'text' &&
        _textAnswer != null &&
        _textAnswer!.isNotEmpty) {
      score++;
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 36),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Aptitude Test',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                const Icon(CupertinoIcons.clock, color: Colors.white, size: 18),
                const SizedBox(width: 6),
                Text(
                  _formattedTime,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
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
          children: [
            Text(
              "Question ${_questionIndex + 1} of ${_questions.length}",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _questions[_questionIndex]['question'],
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            if (_questions[_questionIndex]['type'] == 'multiple')
              ..._buildMultipleChoiceOptions(_questions[_questionIndex]['options']),
            if (_questions[_questionIndex]['type'] == 'text')
              _buildTextAnswerField(),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_questionIndex < _questions.length - 1) {
                    _questionIndex++;
                    _selectedOption = null;
                    _textAnswer = null;
                  } else {
                    _endQuiz();
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _questionIndex < _questions.length - 1 ? 'Next' : 'Finish',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(CupertinoIcons.arrow_right, color: Colors.white, size: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMultipleChoiceOptions(List<String> options) {
    return options.asMap().entries.map((entry) {
      int index = entry.key;
      String text = entry.value;
      final isSelected = _selectedOption == index;
      return GestureDetector(
        onTap: () => _selectOption(index),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: isSelected ? Colors.purple[50] : Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: isSelected ? Colors.purple : Colors.grey[300]!,
              width: 2.0,
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.purple : Colors.black,
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildTextAnswerField() {
    return TextField(
      onChanged: (value) => setState(() => _textAnswer = value),
      decoration: InputDecoration(
        hintText: 'Type your answer here...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
    );
  }
}
