import 'package:flutter/material.dart';
import 'package:toeic_app/part/app_bar.dart';
import './../constants.dart';
import 'question_frame.dart';

class PartFive extends StatefulWidget {
  const PartFive({super.key});
  @override
  State<StatefulWidget> createState() => _PartFiveState();
}

class _PartFiveState extends State<PartFive> {
  int _curr = 1;
  int totalQues = 4;
  List<String> _answer = [];
  PageController controller = PageController();
  bool isShow = false;

  void callbackAnswer(int number, String ans) {
    setState(() {
      _answer[number - 1] = ans;
    });
    print(_answer);
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < totalQues; i++) {
      _answer.add("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarPractice(
          numAnswers: '$_curr',
          answers: listDirectionEng,
          ansTrans: listDirectionVn,
        ),
        body: PageView(
            scrollDirection: Axis.horizontal,
            controller: controller,
            onPageChanged: (number) {
              setState(() {
                _curr = number + 1;
              });
            },
            children: [
              PartFiveFrame(
                  number: 1,
                  question:
                      "Ms. Kim asks that the marketing team e-mail the final draft to _____ before 5 p.m.",
                  answers: ["her", "she", "hers", "herself"],
                  getAnswer: (number, value) => callbackAnswer(number, value),
                  ans: _answer,
                  isShow: isShow,
                  cancelShowExplan: (s) {
                    setState(() {
                      isShow = s;
                    });
                  }),
              PartFiveFrame(
                  number: 2,
                  question:
                      "Ms. Kim asks that the marketing team e-mail the final draft to _____ before 5 p.m.",
                  answers: ["her", "she", "hers", "herself"],
                  getAnswer: (number, value) => callbackAnswer(number, value),
                  ans: _answer,
                  isShow: isShow,
                  cancelShowExplan: (s) {
                    setState(() {
                      isShow = s;
                    });
                  }),
              PartFiveFrame(
                  number: 3,
                  question:
                      "Ms. Kim asks that the marketing team e-mail the final draft to _____ before 5 p.m.",
                  answers: ["her", "she", "hers", "herself"],
                  getAnswer: (number, value) => callbackAnswer(number, value),
                  ans: _answer,
                  isShow: isShow,
                  cancelShowExplan: (s) {
                    setState(() {
                      isShow = s;
                    });
                  })
            ]));
  }
}

class PartFiveFrame extends StatefulWidget {
  final int number;
  final List<String> ans;
  final String question;
  final List<String> answers;
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
      required this.ans,
      required this.isShow,
      required this.cancelShowExplan});

  @override
  State<PartFiveFrame> createState() => _PartFiveFrameState();
}

// --------------------------------------------------------------------
class _PartFiveFrameState extends State<PartFiveFrame> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: QuestionFrame(
                number: widget.number,
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
                      'Câu ${widget.number}',
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
                                color: i == widget.ans[widget.number - 1]
                                    ? orange
                                    : white,
                                border: Border.all(color: black, width: 1.3),
                                boxShadow: [
                                  BoxShadow(
                                    color: colorBoxShadow,
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(
                                        0, 3),
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
