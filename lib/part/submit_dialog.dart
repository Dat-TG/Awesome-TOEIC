import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';

class SubmitDialog extends StatefulWidget {
  final Widget direct;
  const SubmitDialog({super.key, required this.direct});

  @override
  State<SubmitDialog> createState() => _SubmitDialogState();
}

class _SubmitDialogState extends State<SubmitDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      icon: Row(
        children: [
          Icon(
            Icons.assignment_turned_in_rounded,
            color: colorApp,
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Nộp bài ?",
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          )
        ],
      ),
      content: Text(
        "Bạn có thể xem kết quả và đáp án, sau khi đã nộp bài.",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        textAlign: TextAlign.justify,
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: colorApp,
                padding: EdgeInsets.only(left: 25, right: 25)),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => widget.direct),
                  (Route<dynamic> route) => false);
            },
            child: Text(
              "Nộp",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            )),
        SizedBox(width: 2),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: white.withOpacity(0.6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  side: BorderSide(color: black)),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
                decoration: BoxDecoration(),
                width: 50,
                child: Center(
                    child: Text(
                  "Hủy bỏ",
                  style: TextStyle(color: black, fontSize: 15),
                  textAlign: TextAlign.center,
                )))),
        SizedBox(width: 4),
      ],
    );
  }
}

// Result(
//                                             part: 4,
//                                             listAnswers: _answers,
//                                             listRightAnswers: rightAnsChoice)