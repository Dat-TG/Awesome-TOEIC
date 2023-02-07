
import 'package:flutter/material.dart';
import 'constants.dart';

class PartTwo extends StatelessWidget {
  const PartTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hỏi & đáp"),
          backgroundColor: colorApp,
          centerTitle: true,
        ),
        body: Text("Part Two"));
  }
}
