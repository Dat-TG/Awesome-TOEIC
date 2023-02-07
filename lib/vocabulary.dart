import 'package:flutter/material.dart';
import 'constants.dart';

class Vocabulary extends StatelessWidget {
  const Vocabulary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Vocabulary"),
          backgroundColor: colorApp,
          centerTitle: true,
        ),
        body: Text("Vocabulary"));
  }
}
