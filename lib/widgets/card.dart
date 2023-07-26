import 'package:flutter/material.dart';

class card extends StatelessWidget {
  const card({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 283,
      decoration: const BoxDecoration(
        color: Color(0xFF319E3C),
      ),
    );
  }
}