import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        "data",
        style: TextStyle(color: Colors.green, letterSpacing: -1, fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
