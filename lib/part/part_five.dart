import 'package:flutter/material.dart';
import 'package:toeic_app/part/app_bar.dart';
import 'package:toeic_app/part/result.dart';
import 'package:toeic_app/part/submit_dialog.dart';
import './../constants.dart';
import 'question_frame.dart';
import './../utils/convert_ans_text_to_choice.dart';

class PartFive extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const PartFive({super.key, required this.data});
  @override
  State<StatefulWidget> createState() => _PartFiveState();
}

class _PartFiveState extends State<PartFive> {
  int _curr = 1;
  List<String> _answers = [];
  List<List<String>> answersData = [];
  PageController controller = PageController();
  bool isShow = false;
  late List<String> rightAnsChoice, listQuestionsID;
  bool isDialog = true;

  void callbackAnswer(int number, String ans) {
    setState(() {
      if (_answers[number] == "") _answers[number] = ans;
    });
  }

  @override
  void initState() {
    setState(() {
      listQuestionsID = [];
      for (int i = 0; i < widget.data.length; i++) {
        listQuestionsID.add(widget.data[i]['id']);
        _answers.add("");
      }
      rightAnsChoice = convertAnsTextToChoice(widget.data);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                controller.page == widget.data.length - 1) {
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
                  pageBuilder: (context, anim1, anim2) => SubmitDialog(
                      listQuestionsID: listQuestionsID,
                      part: 5,
                      listAnswers: _answers,
                      direct: Result(
                          part: 4,
                          listAnswers: _answers,
                          listRightAnswers: rightAnsChoice)));
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
                for (int i = 0; i < widget.data.length; i++)
                  PartFiveFrame(
                      number: i,
                      question: widget.data[i]['list_question'][0],
                      answers: convertListDynamicToListString(
                          widget.data.elementAt(i)['list_answers'][0]),
                      getAnswer: (number, value) =>
                          callbackAnswer(number, value),
                      ans: _answers,
                      rightAnswers: rightAnsChoice,
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

// -------------------------------------------------------------

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
