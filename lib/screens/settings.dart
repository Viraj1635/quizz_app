import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class SettingsScreen extends StatelessWidget {
  final List<String> fonts = [
    'Roboto', 'Lobster', 'Open Sans', 'Poppins', 'Montserrat'
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Dark Mode Toggle
          ListTile(
            title: const Text("Dark Mode"),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) => themeProvider.toggleTheme(),
            ),
          ),

          const Divider(), // Adds separation for better UI

          // Font Selection Dropdown
          ListTile(
            title: const Text("Choose Font"),
            subtitle: DropdownButtonHideUnderline(
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface, // Adapts to light/dark mode
                  border: Border.all(color: theme.colorScheme.outline),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    if (!isDarkMode) // Light mode shadow effect
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                  ],
                ),
                child: DropdownButton<String>(
                  value: fonts.contains(themeProvider.fontFamily)
                      ? themeProvider.fontFamily
                      : fonts.first, // Ensure a valid font is selected
                  dropdownColor: theme.colorScheme.surfaceVariant, // Themed dropdown
                  icon: Icon(Icons.arrow_drop_down, color: theme.colorScheme.onSurface),
                  style: TextStyle(color: theme.colorScheme.onSurface), // Themed text
                  onChanged: (font) {
                    if (font != null) {
                      themeProvider.setFont(font);
                    }
                  },
                  items: fonts.map((font) {
                    return DropdownMenuItem(
                      value: font,
                      child: Text(font, style: GoogleFonts.getFont(font).copyWith(color: theme.colorScheme.onSurface)),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
