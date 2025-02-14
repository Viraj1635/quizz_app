import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/screens/settings.dart';
import '../theme.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture with shadow effect
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/profile_pic.png"), // Replace with actual image
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                ),
              ),
              const SizedBox(height: 10),

              // Username
              Text(
                "John Doe",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),

              // XP Level
              Text(
                "XP: 1200",
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 20),

              // User Statistics (Refined)
              Card(
                color: theme.colorScheme.surfaceVariant,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
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
              ),

              const SizedBox(height: 20),

              // Settings & Logout Buttons (Updated Design)
              _profileOption(
                icon: Icons.settings,
                title: "Settings",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
                theme: theme,
              ),
              _profileOption(
                icon: Icons.logout,
                title: "Logout",
                onTap: () {},
                theme: theme,
                iconColor: Colors.red,
                textColor: Colors.red,
              ),
            ],
          ),
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
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: theme.colorScheme.onSurface),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
        ),
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
          color: theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? theme.colorScheme.primary),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: textColor ?? theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: theme.colorScheme.onSurface),
          ],
        ),
      ),
    );
  }
}
