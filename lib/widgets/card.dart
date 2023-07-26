import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 283,
      decoration: const BoxDecoration(
        // color: Color(0xFF319E3C),
      ),
      child: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(-0.81, -0.93),
            child: Container(
              width: 187,
              height: 107,
              decoration: BoxDecoration(
                color: const Color(0xFF1E9A2B),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0.84, -0.93),
            child: Container(
              width: 137,
              height: 107,
              decoration: BoxDecoration(
                color: const Color(0xFF1F8529),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0.80, 0.60),
            child: Container(
              width: 187,
              height: 107,
              decoration: BoxDecoration(
                color: const Color(0xFF1DA42B),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-0.85, 0.60),
            child: Container(
              width: 137,
              height: 107,
              decoration: BoxDecoration(
                color: const Color(0xFF1F7A28),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      )
,
    );
  }
}