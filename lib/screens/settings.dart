import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class SettingsScreen extends StatelessWidget {
  final List<String> fonts = [
    'Roboto',
    'Pacifico',
    'Bebas Neue',
    'Dancing Script',
    'Raleway',
    'Playfair Display'
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

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
          "Settings",
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 🌙 Dark Mode Toggle
          ListTile(
            title: const Text("Dark Mode"),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) => themeProvider.toggleTheme(),
            ),
          ),

          const Divider(),

          // 🔠 Font Selection Dropdown
          ListTile(
            title: const Text("Choose Font"),
            subtitle: DropdownButtonHideUnderline(
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  border: Border.all(color: theme.colorScheme.outline),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    if (!isDarkMode)
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
                      : fonts.first,
                  dropdownColor: theme.colorScheme.surfaceVariant,
                  icon: Icon(Icons.arrow_drop_down, color: theme.colorScheme.onSurface),
                  style: TextStyle(color: theme.colorScheme.onSurface),
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
