import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:toeic_app/part/app_bar.dart';
import 'package:toeic_app/part/cancel_dialog.dart';
import 'package:toeic_app/part/result.dart';
import 'package:toeic_app/part/submit_dialog.dart';
import './../utils/convert_ans_text_to_choice.dart';
import 'package:toeic_app/utils/convert_dynamic.dart';

import './../constants.dart';
import 'question_frame.dart';

class PartSeven extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final bool isExam;
  const PartSeven({super.key, required this.data, required this.isExam});

  @override
  State<PartSeven> createState() => _PartSevenState();
}

class _PartSevenState extends State<PartSeven> {
  int _curr = 1;
  String numAnswers = '1-2';
  List<String> _answers = [];
  PageController controllerFrame = PageController();
  late List<String> rightAnsChoice, listQuestionsID;
  bool isDialog = true;

  void callbackAnswer(int number, String ans) {
    setState(() {
      if (_answers[number] == "" || widget.isExam) _answers[number] = ans;
      print(_answers);
    });
  }

  @override
  void initState() {
    setState(() {
      listQuestionsID = [];
      for (int i = 0; i < widget.data.length; i++) {
        listQuestionsID.add(widget.data[i]['id']);
        for (int j = 0;
            j <
                convertListDynamicToListString(widget.data[i]['list_question'])
                    .length;
            j++) {
          _answers.add("");
        }
      }
    });

    rightAnsChoice = convertListAnsTextToListChoice(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _curr = 0;
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
                              part: 7,
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
                        int numAnswerCurrent = 1;
                        for (int i = 0; i < number; i++) {
                          numAnswerCurrent +=
                              convertListDynamicToListListString(
                                      widget.data[i]['list_answers'])
                                  .length;
                        }
                        numAnswers =
                            '$numAnswerCurrent - ${numAnswerCurrent + convertListDynamicToListListString(widget.data[number]['list_answers']).length - 1}';
                      });
                    },
                    children: [
                      for (int i = 0; i < widget.data.length; i++)
                        PartSevenFrame(
                          number: [
                            for (int j = 0;
                                j <
                                    convertListDynamicToListListString(
                                            widget.data[i]['list_answers'])
                                        .length;
                                j++)
                              _curr++
                          ],
                          question: convertListDynamicToListString(
                              widget.data[i]['list_question']),
                          answers: convertListDynamicToListListString(
                              widget.data[i]['list_answers']),
                          rightAnswersSelect: rightAnsChoice,
                          getAnswer: (number, value) =>
                              callbackAnswer(number, value),
                          ans: _answers,
                          listNameImages: convertListDynamicToListString(
                              widget.data[i]['images']),
                          isExam: widget.isExam,
                        ),
                    ]))));
  }
}

class PartSevenFrame extends StatefulWidget {
  final List<int> number;
  final List<String> question, ans, rightAnswersSelect, listNameImages;
  final List<List<String>> answers;
  final Function(int, String) getAnswer;
  final bool isExam;
  // Note, reason

  const PartSevenFrame(
      {super.key,
      required this.number,
      required this.question,
      required this.answers,
      required this.listNameImages,
      required this.getAnswer,
      required this.rightAnswersSelect,
      required this.ans,
      required this.isExam});

  @override
  State<PartSevenFrame> createState() => _PartSevenFrameState();
}

// --------------------------------------------------------------------
class _PartSevenFrameState extends State<PartSevenFrame> {
  PageController controllerAnswer = PageController();
  late int _currAns;
  FirebaseStorage storage = FirebaseStorage.instance;
  List<String> imageURLs = [];
  Future<List<String>> imageURL = Future(() => []);
  @override
  void initState() {
    super.initState();
    _currAns = widget.number[0];
    imageURL = _getImageURLs();
  }

  Future<List<String>> _getImageURLs() async {
    List<String> imgURL = [];
    for (int i = 0; i < widget.listNameImages.length; i++) {
      String url = await storage
          .ref()
          .child('img/${widget.listNameImages[i]}')
          .getDownloadURL();
      imgURL.add(url);
    }
    return imgURL;
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
                      width: MediaQuery.of(context).size.width,
                      constraints: BoxConstraints(
                          minHeight: 50,
                          maxHeight:
                              MediaQuery.of(context).size.height * 0.365),
                      padding: const EdgeInsets.fromLTRB(5, 5, 0, 10),
                      child: FutureBuilder<List<String>>(
                          future: imageURL,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return (Center(
                                child: Text("404: Error"),
                              ));
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              final data = snapshot.data;
                              return SingleChildScrollView(
                                  child: Center(
                                child: Column(
                                  children: [
                                    for (int i = 0; i < data!.length; i++)
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: data[i] != ""
                                            ? Image.network(data[i],
                                                width: 340,
                                                height: 300,
                                                fit: BoxFit.fill)
                                            : SizedBox(
                                                width: 340,
                                                height: 300,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                  ),
                                                )),
                                      )
                                  ],
                                ),
                              ));
                            }
                          }),
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
                                children: [
                                  for (int i = 0;
                                      i < widget.question.length;
                                      i++)
                                    QuestionFrame(
                                      number: widget.number[i] + 1,
                                      question: widget.question[i],
                                      answers: widget.answers[i],
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
                                  'Q.${index + 1}',
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
                                                widget.ans[
                                                    widget.number[size]] = i;
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: widget.ans[widget.number[size]] !=
                                                          "" &&
                                                      i ==
                                                          widget.rightAnswersSelect[
                                                              widget
                                                                  .number[size]]
                                                  ? (widget.isExam)
                                                      ? (i ==
                                                              widget.ans[
                                                                  widget.number[
                                                                      size]])
                                                          ? yellowBold
                                                          : white
                                                      : green
                                                  : (widget.ans[widget
                                                              .number[size]] !=
                                                          "")
                                                      ? (i ==
                                                              widget.ans[widget
                                                                  .number[size]]
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
