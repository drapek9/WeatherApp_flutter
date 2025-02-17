import 'package:flutter/material.dart';

class BottomInf extends StatefulWidget {
  // const BottomInf({super.key});
  final String topInf;
  final String bottomInf;
  final Color textColor;

  BottomInf({required this.topInf, required this.bottomInf, required this.textColor});

  @override
  State<BottomInf> createState() => _BottomInfState();
}

class _BottomInfState extends State<BottomInf> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.topInf,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: widget.textColor
          ),
        ),
        Text(
          widget.bottomInf,
          style: TextStyle(
            fontSize: 13,
            color: widget.textColor
          ),
        )
      ],
    );
  }
}