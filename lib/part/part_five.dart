import 'package:flutter/material.dart';
import 'package:toeic_app/part/app_bar.dart';
import './../constants.dart';
import 'question_frame.dart';

class PartFive extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final bool isExam;
  const PartFive({super.key, required this.data, required this.isExam});
  @override
  State<StatefulWidget> createState() => _PartFiveState();
}

class _PartFiveState extends State<PartFive> {
  int _curr = 1;
  int totalQues = 30;
  List<String> _answers = [];
  List<List<String>> answersData = [];
  PageController controller = PageController();
  bool isShow = false;
  late List<String> rightAnsText;

  void callbackAnswer(int number, String ans) {
    setState(() {
      if (_answers[number] == "" || widget.isExam) _answers[number] = ans;
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
        body: PageView(
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
                  getAnswer: (number, value) => callbackAnswer(number, value),
                  ans: _answers,
                  rightAnswers: rightAnsText,
                  isShow: isShow,
                  cancelShowExplan: (s) {
                    setState(() {
                      isShow = s;
                    });
                  },
                  isExam: widget.isExam,
                )
            ]));
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
  final bool isExam;
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
      required this.cancelShowExplan,
      required this.isExam});

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
                              setState(() {
                                widget.getAnswer(widget.number, i);
                                if (widget.isExam) {
                                  widget.ans[widget.number] = i;
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget.ans[widget.number] != "" &&
                                        i == widget.rightAnswers[widget.number]
                                    ? (widget.isExam)
                                        ? (i == widget.ans[widget.number])
                                            ? yellowBold
                                            : white
                                        : green
                                    : (widget.ans[widget.number] != "")
                                        ? (i == widget.ans[widget.number]
                                            ? (widget.isExam)
                                                ? yellowBold
                                                : red
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
