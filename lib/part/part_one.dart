import 'package:flutter/material.dart';

import './../constants.dart';

class PartOne extends StatelessWidget {
  const PartOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mô tả ảnh"),
          backgroundColor: colorApp,
          centerTitle: true,
        ),
        body: Text("Part One"));
  }
}
