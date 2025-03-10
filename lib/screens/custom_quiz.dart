import 'package:flutter/material.dart';
import 'package:quizz_app/screens/quiz_info.dart';
import 'create_quiz.dart';

class CustomQuizzesScreen extends StatefulWidget {
  const CustomQuizzesScreen({super.key});

  @override
  State<CustomQuizzesScreen> createState() => _CustomQuizzesScreenState();
}

class _CustomQuizzesScreenState extends State<CustomQuizzesScreen> {
  List<Map<String, dynamic>> userQuizzes = [
    {"title": "Space Exploration", "questions": 10, "difficulty": "Medium"},
    {"title": "Programming Basics", "questions": 15, "difficulty": "Hard"},
    {"title": "Famous Scientists", "questions": 8, "difficulty": "Easy"},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color textColor = theme.colorScheme.onSurface;
    final Color cardColor = theme.colorScheme.secondaryContainer;
    final Color buttonColor = theme.colorScheme.primary;
    final Color buttonTextColor = theme.colorScheme.onPrimary;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.background,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("My Custom Quizzes", style: theme.textTheme.titleLarge?.copyWith(color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 📌 Create Quiz Card
                  _createQuizCard(
                    theme.colorScheme.surface,   // Background color (matches list items)
                    theme.colorScheme.onSurface, // Text color
                    theme.colorScheme.primary,   // Button color
                    theme.colorScheme.onPrimary, // Button text color
                  ),

                  const SizedBox(height: 20),

                  // 📜 Title for My Quizzes Section
                  Text(
                    "My Quizzes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.colorScheme.onPrimary),
                  ),
                  const SizedBox(height: 10),

                  // 📜 List of Created Quizzes or Empty State
                  userQuizzes.isEmpty
                      ? _emptyState(textColor, buttonColor, buttonTextColor)
                      : Column(
                    children: userQuizzes.map((quiz) => _quizCard(quiz, theme)).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createQuizCard(Color surfaceColor, Color textColor, Color buttonColor, Color buttonTextColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: surfaceColor, // Matches quiz list items
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          // 📌 Circular Plus Icon
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: buttonColor.withOpacity(0.15), // Subtle color
            ),
            child: Icon(Icons.add, size: 28, color: buttonColor),
          ),
          const SizedBox(width: 16),

          // 📌 Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create a New Quiz",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textColor),
                ),
                const SizedBox(height: 4),
                Text(
                  "Build your quiz and challenge your knowledge!",
                  style: TextStyle(fontSize: 14, color: textColor.withOpacity(0.7)),
                ),
              ],
            ),
          ),

          // 📌 Create Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: buttonTextColor,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateCustomQuizScreen()),
              );
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }



  Widget _quizCard(Map<String, dynamic> quiz, ThemeData theme) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: theme.colorScheme.surface,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
          child: Icon(Icons.quiz, color: theme.colorScheme.primary),
        ),
        title: Text(
          quiz["title"],
          style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
        ),
        subtitle: Text(
          "${quiz["questions"]} Questions • ${quiz["difficulty"]} Difficulty",
          style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.6)),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: theme.colorScheme.onSurface.withOpacity(0.7)),
        onTap: () {
          // 📌 Navigate to the existing Quiz Info screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizInfoScreen(
                quizTitle: quiz["title"],      // Pass title dynamically
                quizCategory: "Custom Quiz",   // Set as "Custom Quiz"
                quizDifficulty: quiz["difficulty"],
                totalQuestions: quiz["questions"],
              ),
            ),
          );
        },
      ),
    );
  }


  // 📌 Empty State Widget
  Widget _emptyState(Color textColor, Color buttonColor, Color buttonTextColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/empty_quiz.png", width: 180),
          const SizedBox(height: 20),
          Text(
            "No quizzes created yet!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor.withOpacity(0.8)),
          ),
          const SizedBox(height: 10),
          Text(
            "Tap the button below to create your first quiz.",
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor.withOpacity(0.6)),
          ),
          const SizedBox(height: 20),

          // Extra Create Button for Empty State
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: buttonTextColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateCustomQuizScreen()),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("Create Quiz"),
          ),
        ],
      ),
    );
  }
}
