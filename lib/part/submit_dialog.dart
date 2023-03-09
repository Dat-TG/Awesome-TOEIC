import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';
import 'package:toeic_app/services/exercise_service.dart';

class SubmitDialog extends StatefulWidget {
  final Widget direct;
  final List<String> listQuestionsID, listAnswers;
  final int part;
  
  const SubmitDialog(
      {super.key, required this.direct, required this.listQuestionsID, required this.listAnswers, required this.part});

  @override
  State<SubmitDialog> createState() => _SubmitDialogState();
}

class _SubmitDialogState extends State<SubmitDialog> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String uid = "";

  @override
  void initState() {
    setState(() {
      uid = firebaseAuth.currentUser!.uid;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('listQuestionsID: ${widget.listQuestionsID}');
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
            onPressed: () async {
              if (uid != "") {
                await ExerciseService().insertDoneExercise(widget.listQuestionsID, uid, widget.listAnswers, widget.part);
              }
              await Navigator.of(context).pushAndRemoveUntil(
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
