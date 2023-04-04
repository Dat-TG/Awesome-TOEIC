import 'package:flutter/material.dart';
import 'package:toeic_app/part/cancel_dialog.dart';
import 'package:toeic_app/part/result.dart';
import 'package:toeic_app/part/submit_dialog.dart';
import 'package:toeic_app/utils/convert_dynamic.dart';

import './../constants.dart';
import 'app_bar.dart';
import 'question_frame.dart';
import './../utils/convert_ans_text_to_choice.dart';

class PartSix extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final bool isExam;
  const PartSix({super.key, required this.data, required this.isExam});

  @override
  State<PartSix> createState() => _PartSixState();
}

class _PartSixState extends State<PartSix> {
  int _curr = 1;
  int totalQues = 1;
  List<String> _answers = [];
  PageController controllerFrame = PageController();
  String numAnswers = "1-4";
  late List<String> rightAnsChoice, listQuestionsID;
  bool isDialog = true;

  void callbackAnswer(int number, String value) {
    setState(() {
      if (_answers[number - 1] == "" || widget.isExam)
        _answers[number - 1] = value;
      print(_answers);
    });
  }

  @override
  void initState() {
    setState(() {
      rightAnsChoice = [];
      listQuestionsID = [];
      totalQues = widget.data.length * 4;
      for (int i = 0; i < totalQues; i++) {
        _answers.add("");
      }
      for (int i = 0; i < widget.data.length; i++) {
        listQuestionsID.add(widget.data[i]['id']);
      }
      rightAnsChoice = convertListAnsTextToListChoice(widget.data);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _curr = 1;
    return WillPopScope(
        onWillPop: () async {
          bool confirm = await cancelDialog(context);
          if (confirm) {
            return true;
          } else {
            return false;
          }
        },
        child: Scaffold(
            appBar: AppBarPractice(
              numAnswers: numAnswers,
              answers: listDirectionEng,
              ansTrans: listDirectionVn,
            ),
            body: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is OverscrollNotification &&
                      controllerFrame.page == widget.data.length - 1) {
                    showGeneralDialog(
                        context: context,
                        transitionDuration: Duration(milliseconds: 300),
                        transitionBuilder: (context, anim1, anim2, child) {
                          return SlideTransition(
                            position:
                                Tween(begin: Offset(1, 0), end: Offset(0, 0))
                                    .animate(anim1),
                            child: child,
                          );
                        },
                        pageBuilder: (context, anim1, anim2) => SubmitDialog(
                              listQuestions: widget.data,
                              listQuestionsID: listQuestionsID,
                              part: 6,
                              listRightAnswers: rightAnsChoice,
                              listUserChoice: _answers,
                            ));
                  }
                  return true;
                },
                child: PageView(
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
                          getAnswer: (number, value) =>
                              callbackAnswer(number, value),
                          ans: _answers,
                          rightAnswers: rightAnsChoice,
                          isExam: widget.isExam,
                        ),
                    ]))));
  }
}

class PartSixFrame extends StatefulWidget {
  final List<int> number;
  final String paragraph;
  final List<String> question, ans;
  final List<List<String>> answers;
  final Function(int, String) getAnswer;
  final List<String> rightAnswers;
  final bool isExam;
  // Note, reason

  const PartSixFrame(
      {super.key,
      required this.number,
      required this.paragraph,
      required this.question,
      required this.answers,
      required this.getAnswer,
      required this.ans,
      required this.rightAnswers,
      required this.isExam});

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
                          maxHeight:
                              MediaQuery.of(context).size.height * 0.365),
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
                                            setState(() {
                                              widget.getAnswer(
                                                  widget.number[size], i);
                                              if (widget.isExam) {
                                                widget.ans[widget.number[size] -
                                                    1] = i;
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: widget.ans[widget.number[size] - 1] !=
                                                          "" &&
                                                      i ==
                                                          widget.rightAnswers[
                                                              widget.number[size] -
                                                                  1]
                                                  ? (widget.isExam)
                                                      ? (i ==
                                                              widget.ans[
                                                                  widget.number[
                                                                          size] -
                                                                      1])
                                                          ? yellowBold
                                                          : white
                                                      : green
                                                  : (widget.ans[widget
                                                                  .number[size] -
                                                              1] !=
                                                          "")
                                                      ? (i == widget.ans[widget.number[size] - 1]
                                                          ? (widget.isExam)
                                                              ? yellowBold
                                                              : red
                                                          : white)
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
