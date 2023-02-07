import 'package:flutter/material.dart';
import 'main.dart';

class Question extends StatelessWidget {
  const Question({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Question"),
          backgroundColor: colorApp,
          centerTitle: true,
        ),
        body: Text("Question"));
  }
}
