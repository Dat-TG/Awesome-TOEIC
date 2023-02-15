import 'package:flutter/material.dart';
import 'package:toeic_app/part/explanation.dart';

import './../constants.dart';
import 'question_frame.dart';

class PartSeven extends StatefulWidget {
  const PartSeven({super.key});

  @override
  State<PartSeven> createState() => _PartSevenState();
}

class _PartSevenState extends State<PartSeven> {
  int _curr = 1;
  String numAnswers = '178-185';
  int totalQues = 9; //Example
  List<String> _answer = [];
  PageController controllerFrame = PageController();
  bool isShow = false;

  void callbackAnswer(int number, String ans) {
    setState(() {
      _answer[number - 1] = ans;
    });
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
        appBar: AppBar(
          title: Transform.translate(
              offset: Offset(-25, 0),
              child: (Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Câu ',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        numAnswers,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 8),
                    child: Icon(Icons.info_outline),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 13),
                    child: Icon(Icons.settings_outlined),
                  ),
                  Icon(Icons.favorite_outline)
                ],
              ))),
          backgroundColor: colorApp,
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isShow = !isShow;
                  });
                },
                child: Center(
                  child: Text(
                    'Giải thích',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
        body: PageView(
            scrollDirection: Axis.horizontal,
            controller: controllerFrame,
            onPageChanged: (number) {
              setState(() {
                _curr = number + 1;
              });
            },
            children: [
              PartSevenFrame(
                number: [1, 2, 3],
                img: [
                  "assets/img/test_1.jpg",
                  "assets/img/test_1.jpg",
                  "assets/img/test_1.jpg"
                ],
                question: ["her", "she", "hers", "herself"],
                answers: [
                  ["her", "she", "hers", "herself"],
                  ["her", "she", "hers", "herself"],
                  ["her", "she", "hers", "herself"]
                ],
                getAnswer: (number, value) => callbackAnswer(number, value),
                ans: _answer,
                isShow: isShow,
                cancelShowExplan: (s) {
                  setState(() {
                    isShow = s;
                  });
                },
              ),
            ]));
  }
}

class PartSevenFrame extends StatefulWidget {
  final List<int> number;
  final List<String> question, img, ans;
  final List<List<String>> answers;
  final Function(int, String) getAnswer;
  final Function(bool) cancelShowExplan;
  final bool isShow;
  // Note, reason

  const PartSevenFrame(
      {super.key,
      required this.number,
      required this.question,
      required this.answers,
      required this.getAnswer,
      required this.img,
      required this.ans,
      required this.cancelShowExplan,
      required this.isShow});

  @override
  State<PartSevenFrame> createState() => _PartSevenFrameState();
}

// --------------------------------------------------------------------
class _PartSevenFrameState extends State<PartSevenFrame> {
  PageController controllerAnswer = PageController();
  late int _currAns;

  @override
  void initState() {
    super.initState();
    _currAns = widget.number[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2 < 380
                          ? 380
                          : MediaQuery.of(context).size.width / 2,
                      constraints: BoxConstraints(
                          minHeight: 50,
                          maxHeight: MediaQuery.of(context).size.height * 0.4),
                      padding: const EdgeInsets.fromLTRB(5, 5, 0, 10),
                      child: SingleChildScrollView(
                          child: Center(
                        child: Column(
                          children: [
                            for (int i = 0; i < widget.img.length; i++)
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: Image.asset(
                                  widget.img[i],
                                  width: 320,
                                ),
                              )
                          ],
                        ),
                      )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      decoration: BoxDecoration(color: colorApp),
                      child: Text(""),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 2 < 380
                            ? 380
                            : MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight: 50,
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.28),
                          padding: const EdgeInsets.fromLTRB(5, 5, 0, 10),
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  QuestionFrame(
                                    number: 2,
                                    question:
                                        "Ms. Kim asks that the marketing team e-mail the final draft to _____ before 5 p.m.",
                                    answers: ["her", "she", "hers", "herself"],
                                  ),
                                  QuestionFrame(
                                    number: 2,
                                    question:
                                        "Ms. Kim asks that the marketing team e-mail the final draft to _____ before 5 p.m.",
                                    answers: ["her", "she", "hers", "herself"],
                                  ),
                                  QuestionFrame(
                                    number: 2,
                                    question:
                                        "Ms. Kim asks that the marketing team e-mail the final draft to _____ before 5 p.m.",
                                    answers: ["her", "she", "hers", "herself"],
                                  ),
                                ]),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),

          // --------- Answer ---------
          Container(
            height: 120,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Explanation(
                    answers: listDirectionEng,
                    ansTrans: listDirectionVn,
                    isShow: widget.isShow,
                    cancelShow: (s) {
                      setState(() {
                        widget.cancelShowExplan(s);
                      });
                    },
                  ),
                  Row(
                    children: [
                      for (var index in widget.number)
                        InkWell(
                          onTap: () {
                            setState(() {
                              _currAns = index;
                            });
                            controllerAnswer
                                .jumpToPage(_currAns - widget.number[0]);
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            margin: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                                border: _currAns == index
                                    ? Border(
                                        bottom:
                                            BorderSide(color: orange, width: 5))
                                    : Border.symmetric()),
                            child: Row(
                              children: [
                                Text(
                                  'Câu $index',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: _currAns == index ? orange : black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    height: 73.6,
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
                    child: PageView(
                        controller: controllerAnswer,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (number) {
                          setState(() {
                            _currAns = number + 1;
                          });
                        },
                        children: [
                          for (int size = 0;
                              size < widget.number.length;
                              size++)
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  for (var i in answersOption)
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            widget.getAnswer(
                                                widget.number[size], i);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: i == widget.ans[size]
                                                  ? orange
                                                  : white,
                                              border: Border.all(
                                                  color: black, width: 1.3),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: colorBoxShadow,
                                                  spreadRadius: 2,
                                                  blurRadius: 3,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                    )
                                ]),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ]);
  }
}
