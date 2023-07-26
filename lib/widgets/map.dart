import 'package:flutter/material.dart';

class Map extends StatelessWidget {
  const Map({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 283,
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.all(Radius.circular(25)),
        
      ),
    );
  }
}