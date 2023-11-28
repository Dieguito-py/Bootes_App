import 'package:bootes_app/widgets/appbar.dart';
import 'package:bootes_app/widgets/card.dart';
import 'package:bootes_app/widgets/connectbutton.dart';
import 'package:bootes_app/widgets/map.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
            Appbar(),
            Map(), 
            Cards(),
            // Connectbutton()
          ],),
      ),
      );
  }
}