import 'package:flutter/material.dart';

import './../constants.dart';
import 'app_bar.dart';
import 'question_frame.dart';

class PartSix extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const PartSix({super.key, required this.data});

  @override
  State<PartSix> createState() => _PartSixState();
}

class _PartSixState extends State<PartSix> {
  int _curr = 1;
  int totalQues = 1;
  List<String> _answer = [];
  PageController controllerFrame = PageController();
  bool isShow = false;
  String numAnswers = "1-4";

  void callbackAnswer(int number, String value) {
    setState(() {
      _answer[number - 1] = value;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      totalQues = widget.data.length * 4;
      for (int i = 0; i < totalQues; i++) {
        _answer.add("");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _curr = 1;
    return Scaffold(
        appBar: AppBarPractice(
          numAnswers: numAnswers,
          answers: listDirectionEng,
          ansTrans: listDirectionVn,
        ),
        body: PageView(
            scrollDirection: Axis.horizontal,
            controller: controllerFrame,
            onPageChanged: (number) {
              setState(() {
                numAnswers = "${number * 4 + 1}-${number * 4 + 4}";
              });
            },
            children: [
              for (int i = 0; i < widget.data.length; i++)
                PartSixFrame(
                  number: [
                    for (int j = 0;
                        j <
                            convertListDynamicToListListString(
                                    widget.data[i]['list_answers'])
                                .length;
                        j++)
                      _curr++
                  ],
                  paragraph: widget.data[i]['content'],
                  question: List<String>.from(
                      widget.data[i]['list_question'] as List),
                  answers: convertListDynamicToListListString(
                      widget.data[i]['list_answers']),
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

class PartSixFrame extends StatefulWidget {
  final List<int> number;
  final String paragraph;
  final List<String> question, ans;
  final List<List<String>> answers;
  final Function(int, String) getAnswer;
  final Function(bool) cancelShowExplan;
  final bool isShow;
  // Note, reason

  const PartSixFrame(
      {super.key,
      required this.number,
      required this.paragraph,
      required this.question,
      required this.answers,
      required this.getAnswer,
      required this.ans,
      required this.cancelShowExplan,
      required this.isShow});

  @override
  State<PartSixFrame> createState() => _PartSixFrameState();
}

// --------------------------------------------------------------------
class _PartSixFrameState extends State<PartSixFrame>
    with AutomaticKeepAliveClientMixin<PartSixFrame> {
  PageController controllerAnswer = PageController();
  late int _currAns;

  @override
  void initState() {
    super.initState();
    _currAns = widget.number[0];
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 2 / 3 > 500
                          ? 500
                          : MediaQuery.of(context).size.width * 2 / 3,
                      constraints: BoxConstraints(
                          minHeight: 50,
                          maxHeight: MediaQuery.of(context).size.height * 0.4),
                      padding: const EdgeInsets.fromLTRB(5, 5, 0, 10),
                      child: SingleChildScrollView(
                          child: Center(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(widget.paragraph),
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
                        width: MediaQuery.of(context).size.width,
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
                                children: <Widget>[
                                  for (int j = 0; j < widget.number.length; j++)
                                    QuestionFrame(
                                      number: widget.number[j],
                                      question: widget.question[j] == ""
                                          ? "(${j + 1})"
                                          : widget.question[j],
                                      answers: widget.answers[j],
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
          SizedBox(
            height: 120,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      for (int index in widget.number)
                        InkWell(
                          onTap: () {
                            setState(() {
                              _currAns = index;
                            });
                            controllerAnswer
                                .jumpToPage(_currAns - widget.number[0]);
                            print(
                                'jump to page ${_currAns - widget.number[0]}');
                            print('on tap $_currAns $index');
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            margin: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                                border: (_currAns == index)
                                    ? Border(
                                        bottom:
                                            BorderSide(color: orange, width: 5))
                                    : Border.symmetric()),
                            child: Row(
                              children: [
                                Text(
                                  'Q.$index',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color:
                                          (_currAns == index) ? orange : black,
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
                            _currAns = widget.number[number];
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
                                            print(
                                                'Question ${widget.number[size]} - answer $i');
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: i ==
                                                      widget.ans[
                                                          widget.number[size] -
                                                              1]
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

List<List<String>> convertListDynamicToListListString(List<dynamic> data) {
  List<List<String>> newList = [];
  for (int i = 0; i < data.length; i++) {
    newList.add(List<String>.from(data[i] as List));
  }
  return newList;
}
