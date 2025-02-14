import 'package:flutter/material.dart';
import 'package:quizz_app/screens/test.dart';

class SubCategoryScreen extends StatelessWidget {
  final String category;

  const SubCategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Sample subcategories data
    final Map<String, List<Map<String, dynamic>>> subcategories = {
      "History": [
        {"title": "World Wars", "description": "Explore the major events of world wars", "color": Colors.red},
        {"title": "Ancient Civilizations", "description": "Study the ancient cultures and their history", "color": Colors.orange},
        {"title": "Modern History", "description": "Discover the events shaping the modern world", "color": Colors.blue},
      ],
      "Science": [
        {"title": "Physics", "description": "Delve into the laws of physics and their applications", "color": Colors.green},
        {"title": "Chemistry", "description": "Learn about chemical reactions and elements", "color": Colors.purple},
        {"title": "Biology", "description": "Study the science of life and living organisms", "color": Colors.teal},
      ],
      "Geography": [
        {"title": "World Capitals", "description": "Learn about the capitals of different countries", "color": Colors.brown},
        {"title": "Landforms", "description": "Explore natural landforms across the globe", "color": Colors.green},
        {"title": "Oceans & Rivers", "description": "Understand the world's major oceans and rivers", "color": Colors.blue},
      ],
      "Literature": [
        {"title": "Classic Novels", "description": "Study classic works from famous authors", "color": Colors.red},
        {"title": "Poetry", "description": "Dive into the world of rhythm and verses", "color": Colors.purple},
        {"title": "Authors", "description": "Explore the lives and works of prominent writers", "color": Colors.orange},
      ],
    };

    // Get the selected subcategories based on category
    List<Map<String, dynamic>> selectedSubcategories = subcategories[category] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: selectedSubcategories.length,
          itemBuilder: (context, index) {
            return _subTopicCard(
              selectedSubcategories[index]["title"],
              selectedSubcategories[index]["description"],
              selectedSubcategories[index]["color"],
              theme,
              context,
            );
          },
        ),
      ),
    );
  }

  // This method builds the card for each subtopic
  Widget _subTopicCard(String title, String description, Color color, ThemeData theme, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0), // Adds spacing between cards
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1), // Subtle background color
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            onPressed: () {
              // Navigate to the Test screen or Quiz related to this subtopic
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Testscreen(), // Pass subcategory name
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: const Text("Start Quiz"),
            ),
          ),
        ],
      ),
    );
  }
}
