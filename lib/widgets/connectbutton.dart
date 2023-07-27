import 'package:flutter/material.dart';

class Connectbutton extends StatelessWidget {
  const Connectbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(60, 40, 60, 0),
      width: MediaQuery.of(context).size.width,
      height: 130,
      // color: Colors.amber,
      child: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(1, -1),
            child: Container(
              width: 168,
              height: 60,
              decoration:  BoxDecoration(
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                border: Border.all(
                  color: const Color(0xFFE7E6D5),
                  width: 5
                )
              ),
              child: const Align(
                alignment: AlignmentDirectional(0.66, 0),
                child: Text('Reconectar',
                style: TextStyle(
                  color: Color(0xFFE7E6D5),
                  fontSize: 22
                ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-1, -1),
            child: Container(
              width: 150,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFFE7E6D5),
                borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: const Align(
                // alignment: AlignmentDirectional(0, 0),
                child: Text('Conectar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0xFF44454B)
                ),
                )
              ),
            ),
          ),
        ],
      )
    );
  }
}