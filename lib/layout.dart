import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/screens/home.dart';
import 'package:quizz_app/screens/profile.dart';
import 'package:quizz_app/theme.dart';
import 'package:quizz_app/widgets/bottom_nav_bar.dart';

class Layout extends StatefulWidget {
  final int index;

  Layout({super.key, this.index = 0});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.index;
  }

  final List<Widget> _pages = [
    HomeScreen(),
    Center(child: Container()),
    Center(child: Text('Statistics Page', style: TextStyle(fontSize: 24))),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Color mainColor = themeProvider.isDarkMode ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: mainColor,
      extendBody: true,
      body: _pages[_index],
      bottomNavigationBar: BottomNavbar(
        index: _index,
        onChange: (idx) {
          setState(() {
            _index = idx;
          });
        },
      ),
    );
  }
}
