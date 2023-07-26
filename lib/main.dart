import 'package:bootes_app/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bootes App',
      theme: ThemeData(
        fontFamily: 'Lalezar',
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF44454B),
        backgroundColor: const Color(0xFF44454B)
      ),
      home: const HomePage());
  }
}

