import 'package:flutter/material.dart';
import 'package:quizz_app/screens/subcategory.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Map<String, dynamic>> categories = [
      {"icon": Icons.history, "title": "History", "color": Colors.red},
      {"icon": Icons.science, "title": "Science", "color": Colors.blue},
      {"icon": Icons.public, "title": "Geography", "color": Colors.green},
      {"icon": Icons.menu_book, "title": "Literature", "color": Colors.amber},
      {"icon": Icons.computer, "title": "Technology", "color": Colors.blueGrey},  // New Category
      {"icon": Icons.sports_soccer, "title": "Sports", "color": Colors.orange},   // New Category
      {"icon": Icons.calculate, "title": "Mathematics", "color": Colors.purple},  // New Category
    ];

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
          "Categories",
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0, // Optional: Removes shadow for a cleaner look
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.3, // Adjusted for better spacing
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubCategoryScreen(category: categories[index]["title"]),
                  ),
                );
              },
              child: _categoryCard(
                categories[index]["icon"],
                categories[index]["title"],
                categories[index]["color"],
                theme,
                context,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _categoryCard(IconData icon, String title, Color color, ThemeData theme, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubCategoryScreen(category: title),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
