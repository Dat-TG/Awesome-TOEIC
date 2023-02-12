import 'package:flutter/material.dart';

import './../constants.dart';

class PartOne extends StatefulWidget {
  const PartOne({super.key});

  @override
  State<PartOne> createState() => _PartOneState();
}

class _PartOneState extends State<PartOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Đoạn văn đơn"),
          backgroundColor: colorApp,
          centerTitle: true,
        ),
        body: Text("Part One"));
  }
}
