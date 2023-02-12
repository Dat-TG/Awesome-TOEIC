import 'package:flutter/material.dart';

import './../constants.dart';

class PartFour extends StatelessWidget {
  const PartFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Đoạn văn đơn"),
          backgroundColor: colorApp,
          centerTitle: true,
        ),
        body: Text("Part Four"));
  }
}

