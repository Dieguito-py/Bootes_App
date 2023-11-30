import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 66 ,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Stack(
        children: [
          Image.asset(
            'assets/images/booteslogo.png',
            width: 155,
            fit: BoxFit.contain,
          ),
        ],
      )
    );
  }
}