import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  final List<String> fonts = [
    'Roboto', 'Lobster', 'Open Sans', 'Poppins', 'Montserrat'
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children: [
          ListTile(
            title: Text("Dark Mode"),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) => themeProvider.toggleTheme(),
            ),
          ),
          ListTile(
            title: Text("Choose Font"),
            subtitle: DropdownButton<String>(
              value: themeProvider.fontFamily,
              onChanged: (font) => themeProvider.setFont(font!),
              items: fonts.map((font) {
                return DropdownMenuItem(
                  value: font,
                  child: Text(font, style: GoogleFonts.getFont(font)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
