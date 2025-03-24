import 'package:flutter/material.dart';
import 'package:quizz_app/screens/quiz_info.dart';
import 'package:quizz_app/screens/settings.dart';
import 'package:quizz_app/screens/subcategory.dart';
import 'category.dart';
import 'login.dart';

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

    Widget _buildDrawerItem({
      required BuildContext context,
      required IconData icon,
      required String label,
      required VoidCallback onTap,
      Color? color,
    }) {
      final theme = Theme.of(context);
      return ListTile(
        leading: Icon(icon, color: color ?? theme.colorScheme.onSurface),
        title: Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: color ?? theme.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () {
          Navigator.pop(context); // Close drawer
          onTap();
        },
      );
    }


    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.primary, // Darker at top
            theme.colorScheme.background, // Lighter at bottom
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Makes Scaffold inherit gradient
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60), // ✅ Pushes content above the bottom navbar
            child: Column(
              children: [
                // 📌 User Profile Header
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: theme.colorScheme.primary),
                  accountName: Text(
                    "John Doe",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(
                    "john.doe@example.com",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimary.withOpacity(0.8),
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: theme.colorScheme.onPrimary,
                    child: Icon(Icons.person, size: 40, color: theme.colorScheme.primary),
                  ),
                ),

                // 📌 Drawer Items
                _buildDrawerItem(
                  context: context,
                  icon: Icons.home,
                  label: "Home",
                  onTap: () => Navigator.pushNamed(context, "/home"),
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.quiz,
                  label: "My Quizzes",
                  onTap: () => Navigator.pushNamed(context, "/my_quizzes"),
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.leaderboard,
                  label: "Leaderboard",
                  onTap: () => Navigator.pushNamed(context, "/leaderboard"),
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.settings,
                  label: "Settings",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.help,
                  label: "Help & Support",
                  onTap: () => Navigator.pushNamed(context, "/help"),
                ),

                const Spacer(),

                // 📌 Logout Button
                _buildDrawerItem(
                  context: context,
                  icon: Icons.logout,
                  label: "Logout",
                  color: Colors.redAccent,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: theme.colorScheme.surface,
                        title: Text(
                          "Logout",
                          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold,color: theme.colorScheme.onSurface),
                        ),
                        content: Text(
                          "Are you sure you want to log out?",
                          style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.onSurface),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancel", style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.primary)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                            child: Text("Logout", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.redAccent)),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16), // ✅ Ensures spacing at bottom
              ],
            ),
          ),
        ),


        appBar: AppBar(
          iconTheme: IconThemeData(
            color: theme.colorScheme.onPrimary
          ),
          title: Text(
            "Quiz App",
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )
          ),
          actions: [
            Container(
              height: 40,
              margin: const EdgeInsets.only(right: 12), // Adds spacing
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Light Mode
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.search_rounded, color: iconColor),
                splashRadius: 24, // Ensures ripple effect stays within circle
              ),
            ),
          ],
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
                  _dailyChallengeCard(theme), // 🔥 Updated Daily Challenge Card
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.colorScheme.onPrimary),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CategoriesScreen()),
                          );
                        },
                        child: Text("See All", style: TextStyle(color: theme.colorScheme.onPrimary)),
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
                      _categoryCard(Icons.history, "History", Color(0xFFD76D77), theme, context),   // Muted Deep Blue
                      _categoryCard(Icons.science, "Science", Color(0xFF4A90E2), theme, context),   // Cool Slate Blue
                      _categoryCard(Icons.public, "Geography", Color(0xFF70A288), theme, context),  // Soft Forest Green
                      _categoryCard(Icons.menu_book, "Literature", Color(0xFFEE964B), theme, context), // Warm Muted Amber
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("Featured Quizzes",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.colorScheme.onPrimary)),
                  const SizedBox(height: 10),
                  _quizCard("World Capitals", "Geography", "Medium", 10, theme),
                  _quizCard("Famous Scientists", "Science", "Hard", 18, theme),
                  _quizCard("Ancient Civilizations", "History", "Easy", 25, theme),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔥 **Updated Daily Challenge Card**
  Widget _dailyChallengeCard(ThemeData theme) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizInfoScreen(
              quizTitle: "Daily Challenge",
              quizCategory: "Mixed Topics",
              quizDifficulty: "Medium",
              totalQuestions: 10, // 🔥 Added number of questions
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface)),
            const SizedBox(height: 5),
            Text("Complete today's quiz and earn bonus XP!",
                style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.8))),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizInfoScreen(
                        quizTitle: "Daily Challenge",
                        quizCategory: "Mixed Topics",
                        quizDifficulty: "Medium",
                        totalQuestions: 10, // 🔥 Added question count
                      ),
                    ),
                  );
                },
                child: const Text("Start Daily Challenge"),
              ),
            ),
          ],
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
          color: theme.colorScheme.surface,
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

  Widget _quizCard(String title, String category, String difficulty, int questions, ThemeData theme) {
    return Card(
      color: theme.colorScheme.surface,
      elevation: 2,
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface)),
        subtitle: Text(category, style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7))),
        trailing: Text(difficulty, style: TextStyle(color: theme.colorScheme.tertiary)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizInfoScreen(
                quizTitle: title,
                quizCategory: category,
                quizDifficulty: difficulty,
                totalQuestions: questions, // Pass question count
              ),
            ),
          );
        },
      ),
    );
  }

}
