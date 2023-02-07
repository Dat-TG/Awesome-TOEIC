import 'package:flutter/material.dart';
import 'main.dart';

class PartThree extends StatelessWidget {
  const PartThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Đoạn hội thoại"),
          backgroundColor: colorApp,
          centerTitle: true,
        ),
        body: Text("Part Three"));
  }
}
