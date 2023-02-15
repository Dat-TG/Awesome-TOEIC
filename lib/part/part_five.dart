import 'package:flutter/material.dart';
import './../constants.dart';

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
        appBar: AppBar(
          title: Transform.translate(
              offset: Offset(-25, 0),
              child: (Row(
                children: [
                  Text('Câu $_curr'),
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
            )
          ],
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
                  ans: _answer),
              PartFiveFrame(
                  number: 2,
                  question:
                      "Ms. Kim asks that the marketing team e-mail the final draft to _____ before 5 p.m.",
                  answers: ["her", "she", "hers", "herself"],
                  getAnswer: (number, value) => callbackAnswer(number, value),
                  ans: _answer),
              PartFiveFrame(
                  number: 3,
                  question:
                      "Ms. Kim asks that the marketing team e-mail the final draft to _____ before 5 p.m.",
                  answers: ["her", "she", "hers", "herself"],
                  getAnswer: (number, value) => callbackAnswer(number, value),
                  ans: _answer)
            ]));
  }
}

class PartFiveFrame extends StatefulWidget {
  final int number;
  final List<String> ans;
  final String question;
  final List<String> answers;
  final Function(int, String) getAnswer;
  // Note, reason

  const PartFiveFrame(
      {super.key,
      required this.number,
      required this.question,
      required this.answers,
      required this.getAnswer,
      required this.ans});

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
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                    color: colorApp,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: colorBoxShadow,
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints:
                            BoxConstraints(minHeight: 50, maxHeight: 130),
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: SingleChildScrollView(
                          child: Text(
                            '${widget.question}',
                            style: TextStyle(fontSize: 17, color: textColor),
                          ),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width - 50,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          child: Container(
                            constraints:
                                BoxConstraints(minHeight: 50, maxHeight: 200),
                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (int i = 0; i < 4; i++)
                                      Text(
                                        '${answersOption[i]}. ${widget.answers[i]}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                  ]),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: orange, width: 5))),
                child: Text(
                  'Câu ${widget.number}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: orange, fontWeight: FontWeight.bold, fontSize: 17),
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
          )
        ]);
  }
}
