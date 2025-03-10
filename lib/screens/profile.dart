import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_app/screens/settings.dart';

import 'login.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true, // Extends gradient behind AppBar
      appBar: AppBar(
        title: Text(
          "Profile",
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
            )
        ),
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0,
      ),
      body: Container(
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Picture
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/img/img.jpg"),
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                  ),
                ),
                const SizedBox(height: 10),

                // Username
                Text(
                  "John Doe",
                    style: theme.textTheme.titleLarge?.copyWith(
                      color:theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    )
                ),

                // XP Level
                Text(
                  "XP: 1200",
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 20),

                // User Statistics
                _statsCard(theme),

                const SizedBox(height: 20),

                // Settings & Logout Buttons
                _profileOption(
                  icon: Icons.settings,
                  title: "Settings",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                  },
                  theme: theme,
                ),
                _profileOption(
                  icon: Icons.logout,
                  title: "Logout",
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
                  theme: theme,
                  iconColor: Colors.red,
                  textColor: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // User Stats Card
  Widget _statsCard(ThemeData theme) {
    return Card(
      color: theme.colorScheme.surface.withOpacity(0.9),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _statRow(Icons.quiz, "Quizzes Played", "45", theme),
            _divider(),
            _statRow(Icons.emoji_events, "Highest Score", "98%", theme),
            _divider(),
            _statRow(Icons.trending_up, "Streak", "10 days", theme),
          ],
        ),
      ),
    );
  }

  // Stat Row Widget
  Widget _statRow(IconData icon, String label, String value, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(width: 10),
            Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: theme.colorScheme.onSurface)),
          ],
        ),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface)),
      ],
    );
  }

  // Divider Widget
  Widget _divider() {
    return Divider(color: Colors.grey.withOpacity(0.3), thickness: 1, height: 20);
  }

  // Profile Option for Settings/Logout
  Widget _profileOption({
    required IconData icon,
    required String title,
    required Function() onTap,
    required ThemeData theme,
    Color? iconColor,
    Color? textColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, spreadRadius: 2),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? theme.colorScheme.primary),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(fontSize: 16, color: textColor ?? theme.colorScheme.onSurface, fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: theme.colorScheme.onSurface),
          ],
        ),
      ),
    );
  }
}
