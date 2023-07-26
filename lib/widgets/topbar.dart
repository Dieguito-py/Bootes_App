import 'package:flutter/material.dart';

class Topbar extends StatelessWidget {
  const Topbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      decoration: const BoxDecoration(
        color: Color(0xFF44454B)
      ),
      child: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(-0.88, 0.79),
            child: Image.asset(
              'assets/images/bootes.png',
              width: 55,
              height: 55,
              fit: BoxFit.contain,
            ),
          ),
          const Align( 
            alignment: AlignmentDirectional(-0.45, 0.50),
            child: Text('Bootes',
             style: TextStyle(
              fontSize: 28
             ),
            ),
          ),
          const Align(
            alignment: AlignmentDirectional(-0.47, 0.77),
            child: Text('CubeSat', style: TextStyle(fontSize: 18),),
          )
        ],
      ),
    );
  }
}