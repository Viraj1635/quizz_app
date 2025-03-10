import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme.dart'; // Your ThemeProvider file

class BottomNavbar extends StatefulWidget {
  final int index;
  final void Function(int)? onChange;

  const BottomNavbar({Key? key, required this.index, required this.onChange}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // 🎨 Get current theme
    final bool isDark = theme.brightness == Brightness.dark;

    final Color navBarColor = isDark
        ? theme.colorScheme.surfaceVariant.withOpacity(0.95) // Softer dark background
        : theme.colorScheme.primaryContainer; // Softer light background

    final Color buttonBackgroundColor = theme.colorScheme.primary; // Main theme color
    final Color activeIconColor = theme.colorScheme.onPrimary; // Best contrast color
    final Color inactiveIconColor = theme.colorScheme.onSurface.withOpacity(0.6); // Soft faded color

    // 🔢 Define icons in correct order: [Home, Create Quiz, Statistics, Profile]
    final List<IconData> icons = [
      Icons.home_rounded,
      Icons.create_rounded,
      Icons.bar_chart_rounded,
      Icons.person_rounded,
    ];

    return CurvedNavigationBar(
      height: 55,
      key: _bottomNavigationKey,
      index: widget.index,
      items: List.generate(
        icons.length,
            (i) => Icon(
          icons[i],
          size: 30,
          color: widget.index == i ? activeIconColor : inactiveIconColor, // Dynamic color change
        ),
      ),
      color: navBarColor,
      buttonBackgroundColor: buttonBackgroundColor,
      backgroundColor: Colors.transparent, // Keeps it blendable with screen background
      animationCurve: Curves.easeInOut,
      onTap: widget.onChange,
      letIndexChange: (index) => true,
      animationDuration: const Duration(milliseconds: 300),
    );
  }
}
