import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/layout.dart';
import 'package:quizz_app/screens/home.dart';
import 'package:quizz_app/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData,
      home: Layout(),
    );
  }
}
