import 'package:flutter/material.dart';

import './../constants.dart';

class PartSix extends StatelessWidget {
  const PartSix({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Điền vào đoạn"),
          backgroundColor: colorApp,
          centerTitle: true,
        ),
        body: Text("Part Six"));
  }
}

