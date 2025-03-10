import 'package:flutter/material.dart';
import 'package:quizz_app/screens/quiz_info.dart';

class CreateCustomQuizScreen extends StatefulWidget {
  const CreateCustomQuizScreen({super.key});

  @override
  State<CreateCustomQuizScreen> createState() => _CreateCustomQuizScreenState();
}

class _CreateCustomQuizScreenState extends State<CreateCustomQuizScreen> {
  final List<String> topics = ["Science", "History", "Math", "Geography"];
  final Map<String, List<String>> subtopics = {
    "Science": ["Physics", "Biology", "Chemistry"],
    "History": ["Ancient", "Medieval", "Modern"],
    "Math": ["Algebra", "Geometry", "Statistics"],
    "Geography": ["World Maps", "Climate", "Oceans"],
  };

  String? selectedTopic;
  String? selectedSubtopic;
  int numberOfQuestions = 10;
  String difficulty = "Medium";
  int selectedTime = 10;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color textColor = theme.colorScheme.onSurface;
    final Color buttonColor = theme.colorScheme.primary;
    final Color buttonTextColor = theme.colorScheme.onPrimary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Custom Quiz",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Topic", style: theme.textTheme.titleMedium?.copyWith(color: textColor)),
            _styledDropdown<String>(
              value: selectedTopic,
              hint: "Choose a topic",
              items: topics,
              onChanged: (value) {
                setState(() {
                  selectedTopic = value;
                  selectedSubtopic = null;
                });
              },
            ),
            const SizedBox(height: 16),
            Text("Select Subtopic", style: theme.textTheme.titleMedium?.copyWith(color: textColor)),
            _styledDropdown<String>(
              value: selectedSubtopic,
              hint: "Choose a subtopic",
              items: selectedTopic != null ? subtopics[selectedTopic]! : [],
              onChanged: (value) {
                setState(() {
                  selectedSubtopic = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Text("Number of Questions: $numberOfQuestions", style: theme.textTheme.titleMedium?.copyWith(color: textColor)),
            Slider(
              value: numberOfQuestions.toDouble(),
              min: 5,
              max: 50,
              divisions: 9,
              label: numberOfQuestions.toString(),
              activeColor: buttonColor,
              inactiveColor: buttonColor.withOpacity(0.3),
              onChanged: (value) {
                setState(() {
                  numberOfQuestions = value.toInt();
                });
              },
            ),
            const SizedBox(height: 16),
            Text("Select Difficulty", style: theme.textTheme.titleMedium?.copyWith(color: textColor)),
            Column(
              children: ["Easy", "Medium", "Hard"].map((level) {
                return _styledRadio(level);
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text("Select Time Limit", style: theme.textTheme.titleMedium?.copyWith(color: textColor)),
            _styledDropdown<int>(
              value: selectedTime,
              hint: "Choose time limit",
              items: [5, 10, 15, 20, 30],
              onChanged: (value) {
                setState(() {
                  selectedTime = value!;
                });
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: buttonColor,
                  foregroundColor: buttonTextColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  if (selectedTopic == null || selectedSubtopic == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please select a topic and subtopic.", style: theme.textTheme.bodyMedium),
                        backgroundColor: buttonColor,
                      ),
                    );
                  } else {
                    _createQuiz();
                  }
                },
                child: Text("Create Quiz", style: theme.textTheme.titleMedium?.copyWith(color: buttonTextColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _styledDropdown<T>({required T? value, required String hint, required List<T> items, required Function(T?) onChanged}) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<T>(
        value: value,
        decoration: const InputDecoration(border: InputBorder.none),
        dropdownColor: theme.colorScheme.surfaceVariant,
        hint: Text(hint, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6))),
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.toString(), style: theme.textTheme.bodyMedium),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _styledRadio(String level) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return RadioListTile<String>(
      title: Text(
        level,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      value: level,
      groupValue: difficulty,
      activeColor: theme.colorScheme.primary,
      onChanged: (value) {
        setState(() {
          difficulty = value!;
        });
      },
    );
  }

  void _createQuiz() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizInfoScreen(
          quizTitle: "Custom Quiz",
          quizCategory: selectedTopic!,
          quizDifficulty: difficulty,
          totalQuestions: numberOfQuestions,
        ),
      ),
    );
  }
}
