import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final Function resetQuestion;

  Result(this.resetQuestion);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text("No more question!"),
            RaisedButton(
              child: Text("Tap to go again"),
              onPressed: resetQuestion,
            ),
          ],
        ),
      ),
    );
  }
}
