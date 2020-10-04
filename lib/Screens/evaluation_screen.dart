import 'package:flutter/material.dart';

class EvaluationScreen extends StatefulWidget {
  @override
  _EvaluationScreenState createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Evaluation Report: 87% Accuracy\n\n\n Mistakes at 00:07 and 00:13\nMove your hands upwards",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: size.height * 0.035),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
