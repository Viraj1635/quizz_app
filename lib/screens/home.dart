import 'package:flutter/material.dart';
import 'package:quizz_app/screens/settings.dart';
import 'package:quizz_app/screens/subcategory.dart';

import 'category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    final Color backgroundColor = theme.colorScheme.surface;
    final Color textColor = theme.colorScheme.onSurface;
    final Color cardColor = theme.colorScheme.secondaryContainer;
    final Color iconColor = theme.colorScheme.primary;
    final Color buttonColor = theme.colorScheme.primary;
    final Color buttonTextColor = theme.colorScheme.onPrimary;

    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: theme.appBarTheme.backgroundColor),
              child: Text("Drawer Header", style: TextStyle(color: textColor)),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.settings, color: iconColor),
                  const SizedBox(width: 10),
                  Text("Settings", style: TextStyle(color: textColor)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Quiz App", style: TextStyle(color: textColor)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search_rounded, color: iconColor),
          ),
        ],
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Daily Challenge
                _dailyChallengeCard(cardColor, textColor, buttonColor, buttonTextColor),

                const SizedBox(height: 20),

                // Categories Section
                // Categories Section with "See All" Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CategoriesScreen()),
                        );
                      },
                      child: Text("See All", style: TextStyle(color: theme.colorScheme.primary)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _categoryCard(Icons.history, "History", Colors.red, theme, context),
                    _categoryCard(Icons.science, "Science", Colors.blue, theme, context),
                    _categoryCard(Icons.public, "Geography", Colors.green, theme, context),
                    _categoryCard(Icons.menu_book, "Literature", Colors.amber, theme, context),
                  ],
                ),

                SizedBox(height: 10), // Reduced space

                // Featured Quizzes
                Text("Featured Quizzes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
                const SizedBox(height: 10),
                _quizCard("World Capitals", "Geography", "Medium", theme),
                _quizCard("Famous Scientists", "Science", "Hard", theme),
                _quizCard("Ancient Civilizations", "History", "Easy", theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dailyChallengeCard(Color cardColor, Color textColor, Color buttonColor, Color buttonTextColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Daily Challenge",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
          const SizedBox(height: 5),
          Text("Complete today's quiz and earn bonus XP!", style: TextStyle(color: textColor)),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: buttonTextColor,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {},
              child: const Text("Start Daily Challenge"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryCard(IconData icon, String title, Color color, ThemeData theme, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to SubCategoryPage
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
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.colorScheme.onSecondaryContainer),
            ),
          ],
        ),
      ),
    );
  }


  Widget _quizCard(String title, String category, String difficulty, ThemeData theme) {
    return Card(
      color: theme.colorScheme.surfaceVariant,
      elevation: 2,
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface)),
        subtitle: Text(category, style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7))),
        trailing: Text(difficulty, style: TextStyle(color: theme.colorScheme.tertiary)),
      ),
    );
  }
}
