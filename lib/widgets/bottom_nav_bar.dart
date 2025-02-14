import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme.dart'; // This file should provide ThemeProvider with the isDarkMode flag.

class BottomNavbar extends StatefulWidget {
  final int index;
  final void Function(int)? onChange;

  const BottomNavbar({Key? key, required this.index, required this.onChange})
      : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDark = themeProvider.isDarkMode;

    // Inverse color scheme:
    // - For Light Theme (app is light), use dark colors for the nav bar.
    // - For Dark Theme (app is dark), use light colors for the nav bar.
    final Color navBarColor = isDark
        ? Colors.white.withOpacity(0.9)
        : Colors.black.withOpacity(0.9);
    final Color buttonBackgroundColor = isDark ? Colors.white : Colors.black;
    final Color activeIconColor = isDark ? Colors.white : Colors.black;
    final Color inactiveIconColor = isDark ? Colors.black : Colors.white;

    return CurvedNavigationBar(
      height: 55,
      key: _bottomNavigationKey,
      index: widget.index,
      items: <Widget>[
        Icon(
          Icons.home_rounded,
          size: 30,
          color: widget.index == 0 ? inactiveIconColor : inactiveIconColor,
        ),
        Icon(
          Icons.list_alt_rounded,
          size: 30,
          color: widget.index == 1 ? inactiveIconColor : inactiveIconColor,
        ),
        Icon(
          Icons.photo_outlined,
          size: 30,
          color: widget.index == 2 ? inactiveIconColor : inactiveIconColor,
        ),
        Icon(
          Icons.chat_outlined,
          size: 30,
          color: widget.index == 3 ? inactiveIconColor : inactiveIconColor,
        ),
      ],
      color: navBarColor,
      buttonBackgroundColor: buttonBackgroundColor,
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeInOut,
      onTap: widget.onChange,
      letIndexChange: (index) => true,
      animationDuration: Duration(milliseconds: 300),
    );
  }
}
