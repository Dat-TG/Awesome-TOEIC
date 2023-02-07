import 'package:flutter/material.dart';
import 'homePage.dart';

const Color colorApp = Color.fromRGBO(0, 181, 204, 1);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'TOEIC APP';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
