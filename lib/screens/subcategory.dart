import 'package:flutter/material.dart';
import 'package:quizz_app/screens/subtopic_details.dart';
import 'package:quizz_app/screens/test.dart';

class SubCategoryScreen extends StatelessWidget {
  final String category;

  const SubCategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Extended subcategories with more topics and new categories
    final Map<String, List<Map<String, dynamic>>> subcategories = {
      "History": [
        {"title": "World Wars", "description": "Explore the major events of world wars", "color": Colors.red},
        {"title": "Ancient Civilizations", "description": "Study ancient cultures and their history", "color": Colors.orange},
        {"title": "Modern History", "description": "Discover the events shaping the modern world", "color": Colors.blue},
        {"title": "Medieval Europe", "description": "Understand the feudal system and medieval life", "color": Colors.green},
        {"title": "Revolutions", "description": "Learn about major revolutions that changed history", "color": Colors.purple},
      ],
      "Science": [
        {"title": "Physics", "description": "Delve into the laws of physics and their applications", "color": Colors.green},
        {"title": "Chemistry", "description": "Learn about chemical reactions and elements", "color": Colors.purple},
        {"title": "Biology", "description": "Study the science of life and living organisms", "color": Colors.teal},
        {"title": "Astronomy", "description": "Explore the universe, stars, and planets", "color": Colors.blue},
        {"title": "Genetics", "description": "Understand DNA, genes, and hereditary traits", "color": Colors.red},
      ],
      "Geography": [
        {"title": "World Capitals", "description": "Learn about the capitals of different countries", "color": Colors.brown},
        {"title": "Landforms", "description": "Explore natural landforms across the globe", "color": Colors.green},
        {"title": "Oceans & Rivers", "description": "Understand the world's major oceans and rivers", "color": Colors.blue},
        {"title": "Climates & Biomes", "description": "Study different climates and ecosystems", "color": Colors.orange},
        {"title": "Human Geography", "description": "Discover how humans interact with their environment", "color": Colors.purple},
      ],
      "Literature": [
        {"title": "Classic Novels", "description": "Study classic works from famous authors", "color": Colors.red},
        {"title": "Poetry", "description": "Dive into the world of rhythm and verses", "color": Colors.purple},
        {"title": "Authors", "description": "Explore the lives and works of prominent writers", "color": Colors.orange},
        {"title": "Shakespeare", "description": "Analyze the plays and sonnets of Shakespeare", "color": Colors.blue},
        {"title": "Literary Movements", "description": "Learn about different literary periods and styles", "color": Colors.green},
      ],
      "Technology": [
        {"title": "Artificial Intelligence", "description": "Understand AI and machine learning concepts", "color": Colors.blueGrey},
        {"title": "Cybersecurity", "description": "Learn how to protect systems and data", "color": Colors.redAccent},
        {"title": "Blockchain", "description": "Explore cryptocurrency and decentralized networks", "color": Colors.deepPurple},
        {"title": "Software Development", "description": "Understand coding, programming languages, and development", "color": Colors.green},
        {"title": "Cloud Computing", "description": "Study cloud storage, services, and infrastructure", "color": Colors.orange},
      ],
      "Sports": [
        {"title": "Football", "description": "Learn about the history and rules of football", "color": Colors.brown},
        {"title": "Basketball", "description": "Explore the world of basketball and famous players", "color": Colors.orange},
        {"title": "Olympics", "description": "Understand the history and significance of the Olympics", "color": Colors.red},
        {"title": "Tennis", "description": "Study the rules, players, and tournaments of tennis", "color": Colors.green},
        {"title": "Cricket", "description": "Discover the rules and history of cricket", "color": Colors.blue},
      ],
      "Mathematics": [
        {"title": "Algebra", "description": "Solve equations and understand algebraic expressions", "color": Colors.purple},
        {"title": "Geometry", "description": "Learn about shapes, angles, and formulas", "color": Colors.blue},
        {"title": "Calculus", "description": "Understand derivatives, integrals, and limits", "color": Colors.green},
        {"title": "Probability & Statistics", "description": "Study data analysis and probability concepts", "color": Colors.orange},
        {"title": "Number Theory", "description": "Explore the properties of numbers and mathematical patterns", "color": Colors.red},
      ],
    };

    // Get the selected subcategories based on category
    List<Map<String, dynamic>> selectedSubcategories = subcategories[category] ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(theme.colorScheme.onPrimary),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          category,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0, // Optional: Removes shadow for a cleaner look
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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubtopicDetailsPage(subtopicName: title, subtopicDescription: description),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0), // Adds spacing between cards
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          // boxShadow: const [
          //   BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 2),
          // ],
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
                color: Colors.black,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Testscreen(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text("Start Quiz",style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
