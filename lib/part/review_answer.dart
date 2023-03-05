import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';

class ReviewAnswers extends StatefulWidget {
  const ReviewAnswers({super.key});

  @override
  State<ReviewAnswers> createState() => ReviewAnswersState();
}

class ReviewAnswersState extends State<ReviewAnswers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hiển thị đáp án'),
          centerTitle: true,
          backgroundColor: colorApp,
        ),
        body: Column(
          children: [
            Row(
              children: [],
            )
          ],
        ));
  }
}
