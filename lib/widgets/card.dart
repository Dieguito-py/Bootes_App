import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 310,
      decoration: const BoxDecoration(
        // color: Color(0xFF319E3C),
      ),
      child: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(-0.80, -0.85),
            child: Container(
              width: 198,
              height: 138,
              decoration: BoxDecoration(
                color: const Color(0xFF1E9A2B),
                borderRadius: BorderRadius.circular(25),
              ),
              child:  Stack(
                children: [
                  const Align(
                    alignment: AlignmentDirectional(-0.65, -0.89),
                    child: Text('Temperatura',
                    style: TextStyle(
                      color: Color(0xFFE7E6D5),
                      fontSize: 23,
                    ),
                    ),
                  ),
                  const Align(
                    alignment: AlignmentDirectional(-0.69, 1.4),
                    child: Text('26°',
                    style: TextStyle(
                      fontSize: 80,
                      color: Color(0xFFE7E6D5)
                    ),),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(3.4, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: Image.asset(
                          'assets/images/ternometro.png',
                          fit: BoxFit.cover,
                          width: 163,
                          height:501,
                          ),
                        ),
                      ),
                  // )
                ],
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0.84, -0.85),
            child: Container(
              width: 140,
              height: 138,
              decoration: BoxDecoration(
                color: const Color(0xFF1F8529),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(-0.65, -0.89),
                    child: Text('Umidade',
                    style: TextStyle(
                      color: Color(0xFFE7E6D5),
                      fontSize: 23,
                    ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.45, 1),
                    child: Text('70%',
                    style: TextStyle(
                      fontSize: 70,
                      color: Color(0xFFE7E6D5)
                    ),),
                  ),
                  // )
                ],
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0.80, 0.94),
            child: Container(
              width: 198,
              height: 138,
              decoration: BoxDecoration(
                color: const Color(0xFF1DA42B),
                borderRadius: BorderRadius.circular(25),
              ),
              child:  Stack(
                children: [
                  const Align(
                    alignment: AlignmentDirectional(-0.40, -0.89),
                    child: Text('Pressão atmosférica',
                    style: TextStyle(
                      color: Color(0xFFE7E6D5),
                      fontSize: 23,
                    ),
                    ),
                  ),
                  const Align(
                    alignment: AlignmentDirectional(-0.45, 1),
                    child: Text('2 atm',
                    style: TextStyle(
                      fontSize: 70,
                      color: Color(0xFFE7E6D5)
                    ),),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(1, 0),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          child: Image.asset(
                          'assets/images/gauge.png',
                          fit: BoxFit.contain,
                          width: 113,
                          height:401,
                          ),
                        ),
                      ),
                  // )
                ],
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-0.85, 0.94),
            child: Container(
              width: 140,
              height: 138,
              decoration: BoxDecoration(
                color: const Color(0xFF1F7A28),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(-0.65, -0.89),
                    child: Text('Altitude',
                    style: TextStyle(
                      color: Color(0xFFE7E6D5),
                      fontSize: 23,
                    ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.45, 0.60),
                    child: Text('450m',
                    style: TextStyle(
                      fontSize: 60,
                      color: Color(0xFFE7E6D5)
                    ),),
                  ),
                  // )
                ],
              ),
            ),
          ),
        ],
      )
,
    );
  }
}