import 'package:flutter/material.dart';
import 'package:toeic_app/part/app_bar.dart';
import 'package:toeic_app/part/result.dart';
import './../constants.dart';
import 'question_frame.dart';

class PartFive extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const PartFive({super.key, required this.data});
  @override
  State<StatefulWidget> createState() => _PartFiveState();
}

class _PartFiveState extends State<PartFive> {
  int _curr = 1;
  int totalQues = 30;
  List<String> _answers = [];
  List<List<String>> answersData = [];
  PageController controller = PageController(initialPage: 29);
  bool isShow = false;
  late List<String> rightAnsText;
  bool isDialog = true;

  void callbackAnswer(int number, String ans) {
    setState(() {
      if (_answers[number] == "") _answers[number] = ans;
      print(_answers);
    });
  }

  @override
  void initState() {
    setState(() {
      for (int i = 0; i < totalQues; i++) {
        _answers.add("");
      }
    });
    super.initState();

    rightAnsText = compareAnswersToRightAnswers();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<String> compareAnswersToRightAnswers() {
    List<String> rightAns = [];
    for (int i = 0; i < widget.data.length; i++) {
      for (int j = 0; j < 4; j++) {
        if (widget.data.elementAt(i)['list_right_answer'][0] ==
            widget.data.elementAt(i)['list_answers'][0][j]) {
          if (j == 0) {
            rightAns.add("A");
          } else if (j == 1) {
            rightAns.add("B");
          } else if (j == 2) {
            rightAns.add("C");
          } else {
            rightAns.add("D");
          }
        }
      }
    }
    return rightAns;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarPractice(
          numAnswers: '$_curr',
          answers: listDirectionEng,
          ansTrans: listDirectionVn,
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is OverscrollNotification &&
                controller.page == totalQues - 1) {
              showGeneralDialog(
                  context: context,
                  transitionDuration: Duration(milliseconds: 300),
                  transitionBuilder: (context, anim1, anim2, child) {
                    return SlideTransition(
                      position: Tween(begin: Offset(1, 0), end: Offset(0, 0))
                          .animate(anim1),
                      child: child,
                    );
                  },
                  pageBuilder: (context, anim1, anim2) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0))),
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
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        content: Text(
                          "Bạn có thể xem kết quả và đáp án, sau khi đã nộp bài.",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.justify,
                        ),
                        actions: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colorApp,
                                  padding:
                                      EdgeInsets.only(left: 25, right: 25)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Result()));
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6.0)),
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
                                    style:
                                        TextStyle(color: black, fontSize: 15),
                                    textAlign: TextAlign.center,
                                  )))),
                          SizedBox(width: 4),
                        ],
                      ));
            }
            return true;
          },
          child: PageView(
              scrollDirection: Axis.horizontal,
              controller: controller,
              onPageChanged: (number) {
                setState(() {
                  _curr = number + 1;
                });
              },
              children: [
                for (int i = 0; i < totalQues; i++)
                  PartFiveFrame(
                      number: i,
                      question: widget.data[i]['list_question'][0],
                      answers: convertListDynamicToListString(
                          widget.data.elementAt(i)['list_answers'][0]),
                      getAnswer: (number, value) =>
                          callbackAnswer(number, value),
                      ans: _answers,
                      rightAnswers: rightAnsText,
                      isShow: isShow,
                      cancelShowExplan: (s) {
                        setState(() {
                          isShow = s;
                        });
                      })
              ]),
        ));
  }
}

class PartFiveFrame extends StatefulWidget {
  final int number;
  final List<String> ans;
  final String question;
  final List<String> answers;
  final List<String> rightAnswers;
  final Function(int, String) getAnswer;
  final bool isShow;
  final Function(bool) cancelShowExplan;
  // Note, reason

  const PartFiveFrame(
      {super.key,
      required this.number,
      required this.question,
      required this.answers,
      required this.getAnswer,
      required this.rightAnswers,
      required this.ans,
      required this.isShow,
      required this.cancelShowExplan});

  @override
  State<PartFiveFrame> createState() => _PartFiveFrameState();
}

// --------------------------------------------------------------------
class _PartFiveFrameState extends State<PartFiveFrame> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: QuestionFrame(
                number: widget.number + 1,
                question: widget.question,
                answers: widget.answers),
          ),
          SizedBox(
            height: 120,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: orange, width: 5))),
                    child: Text(
                      'Q.${widget.number + 1}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: colorBox,
                      boxShadow: [
                        BoxShadow(
                          color: colorBoxShadow,
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (var i in answersOption)
                          InkWell(
                            onTap: () {
                              widget.getAnswer(widget.number, i);
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget.ans[widget.number] != "" &&
                                        i == widget.rightAnswers[widget.number]
                                    ? green
                                    : (widget.ans[widget.number] != "")
                                        ? (i == widget.ans[widget.number]
                                            ? red
                                            : white)
                                        : white,
                                border: Border.all(color: black, width: 1.3),
                                boxShadow: [
                                  BoxShadow(
                                    color: colorBoxShadow,
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 3),
                                  )
                                ],
                              ),
                              child: Text(
                                i,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]);
  }
}
