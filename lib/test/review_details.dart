import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';
import 'package:toeic_app/test/testing.dart';

import '../part/part_five.dart';
import '../part/part_four.dart';
import '../part/part_one.dart';
import '../part/part_seven.dart';
import '../part/part_six.dart';
import '../part/part_three.dart';
import '../part/part_two.dart';
import '../utils/convert_dynamic.dart';
import 'app_bar.dart';

class ReviewDetails extends StatelessWidget {
  final String testID;
  final List<Map<String, dynamic>>? data;
  final List<String> answer, answerSelect;
  const ReviewDetails(
      {super.key,
      required this.testID,
      required this.data,
      required this.answer,
      required this.answerSelect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Test $testID"),
          backgroundColor: colorApp,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [ReadOrListenBar(), FilterBar()],
              ),
            ),
            StaticAnswerPageView(
              answer: answer,
              answerSelect: answerSelect,
              data: data,
            )
          ],
        ));
  }
}

class StaticAnswerPageView extends StatefulWidget {
  final List<String> answer, answerSelect;
  final List<Map<String, dynamic>>? data;
  const StaticAnswerPageView(
      {super.key,
      required this.answer,
      required this.answerSelect,
      required this.data});

  @override
  State<StaticAnswerPageView> createState() => _StaticAnswerPageViewState();
}

class _StaticAnswerPageViewState extends State<StaticAnswerPageView> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (readOrListenController.hasClients) {
        readOrListenController.jumpToPage(curReadOrListen.value);
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 180,
      child: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: readOrListenController,
        children: [
          StaticListeningPage(
            answer: widget.answer,
            answerSelect: widget.answerSelect,
            data: widget.data,
          ),
          StaticReadingPage(
            answer: widget.answer,
            answerSelect: widget.answerSelect,
            data: widget.data,
          )
        ],
      ),
    );
  }
}

class StaticListeningPage extends StatefulWidget {
  final List<String> answer, answerSelect;
  final List<Map<String, dynamic>>? data;
  const StaticListeningPage(
      {super.key,
      required this.answer,
      required this.answerSelect,
      required this.data});

  @override
  State<StaticListeningPage> createState() => _StaticListeningPageState();
}

class _StaticListeningPageState extends State<StaticListeningPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.answer);
    print(widget.answerSelect);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: curAnswerPageListening,
      builder: (context, value, child) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: Text(
                'Part 1: Mô Tả Hình Ảnh',
                style: TextStyle(
                    color: colorApp, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            for (int i = 0; i < 6; i++)
              if (curAnswerPageListening.value == 0 ||
                  (curAnswerPageListening.value == 1 &&
                      widget.answer[i] == widget.answerSelect[i]) ||
                  (curAnswerPageListening.value == 2 &&
                      widget.answer[i] != widget.answerSelect[i]))
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReviewTest(
                                  data: widget.data,
                                  intialPage: i + 1,
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      (widget.answerSelect[i] == "")
                          ? Icon(Icons.warning,
                              color: Color.fromARGB(255, 211, 211, 21),
                              size: 32)
                          : (widget.answerSelect[i] == widget.answer[i])
                              ? Icon(Icons.check, color: Colors.green, size: 32)
                              : Icon(Icons.close, color: Colors.red, size: 32),
                      Text(
                        'Câu ${i + 1}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      for (var j in answersOption)
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.answer[i] == j
                                ? green
                                : widget.answerSelect[i] != j
                                    ? white
                                    : red,
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
                            j,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                    ],
                  ),
                ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: Text(
                'Part 2: Hỏi & Đáp',
                style: TextStyle(
                    color: colorApp, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            for (int i = 6; i < 31; i++)
              if (curAnswerPageListening.value == 0 ||
                  (curAnswerPageListening.value == 1 &&
                      widget.answer[i] == widget.answerSelect[i]) ||
                  (curAnswerPageListening.value == 2 &&
                      widget.answer[i] != widget.answerSelect[i]))
                InkWell(
                  onTap: () {
                    //widget.pageController.jumpToPage(i + 2);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReviewTest(
                                  data: widget.data,
                                  intialPage: i + 2,
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      (widget.answerSelect[i] == "")
                          ? Icon(Icons.warning,
                              color: Color.fromARGB(255, 211, 211, 21),
                              size: 32)
                          : (widget.answerSelect[i] == widget.answer[i])
                              ? Icon(Icons.check, color: Colors.green, size: 32)
                              : Icon(Icons.close, color: Colors.red, size: 32),
                      Text('Câu ${i + 1}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      for (var j in answersOption)
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.answer[i] == j
                                ? green
                                : widget.answerSelect[i] != j
                                    ? white
                                    : red,
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
                            j,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                    ],
                  ),
                ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: Text(
                'Part 3: Đoạn hội thoại',
                style: TextStyle(
                    color: colorApp, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            for (int i = 31; i < 70; i++)
              if (curAnswerPageListening.value == 0 ||
                  (curAnswerPageListening.value == 1 &&
                      widget.answer[i] == widget.answerSelect[i]) ||
                  (curAnswerPageListening.value == 2 &&
                      widget.answer[i] != widget.answerSelect[i]))
                InkWell(
                  onTap: () {
                    //widget.pageController.jumpToPage(31 + (i - 31) ~/ 3 + 3);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReviewTest(
                                  data: widget.data,
                                  intialPage: 31 + (i - 31) ~/ 3 + 3,
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      (widget.answerSelect[i] == "")
                          ? Icon(Icons.warning,
                              color: Color.fromARGB(255, 211, 211, 21),
                              size: 32)
                          : (widget.answerSelect[i] == widget.answer[i])
                              ? Icon(Icons.check, color: Colors.green, size: 32)
                              : Icon(Icons.close, color: Colors.red, size: 32),
                      Text('Câu ${i + 1}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      for (var j in answersOption)
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.answer[i] == j
                                ? green
                                : widget.answerSelect[i] != j
                                    ? white
                                    : red,
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
                            j,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                    ],
                  ),
                ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: Text(
                'Part 4: Bài nói chuyện ngắn',
                style: TextStyle(
                    color: colorApp, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            for (int i = 70; i < 100; i++)
              if (curAnswerPageListening.value == 0 ||
                  (curAnswerPageListening.value == 1 &&
                      widget.answer[i] == widget.answerSelect[i]) ||
                  (curAnswerPageListening.value == 2 &&
                      widget.answer[i] != widget.answerSelect[i]))
                InkWell(
                  onTap: () {
                    //widget.pageController.jumpToPage(44 + (i - 70) ~/ 3 + 4);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReviewTest(
                                  data: widget.data,
                                  intialPage: 44 + (i - 70) ~/ 3 + 4,
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      (widget.answerSelect[i] == "")
                          ? Icon(Icons.warning,
                              color: Color.fromARGB(255, 211, 211, 21),
                              size: 32)
                          : (widget.answerSelect[i] == widget.answer[i])
                              ? Icon(Icons.check, color: Colors.green, size: 32)
                              : Icon(Icons.close, color: Colors.red, size: 32),
                      Text('Câu ${i + 1}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      for (var j in answersOption)
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.answer[i] == j
                                ? green
                                : widget.answerSelect[i] != j
                                    ? white
                                    : red,
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
                            j,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class StaticReadingPage extends StatefulWidget {
  final List<String> answer, answerSelect;
  final List<Map<String, dynamic>>? data;
  const StaticReadingPage(
      {super.key,
      required this.answer,
      required this.answerSelect,
      required this.data});

  @override
  State<StaticReadingPage> createState() => _StaticReadingPageState();
}

class _StaticReadingPageState extends State<StaticReadingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.answer);
    print(widget.answerSelect);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: curAnswerPageReading,
      builder: (context, value, child) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: Text(
                'Part 5: Điền vào câu',
                style: TextStyle(
                    color: colorApp, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            for (int i = 100; i < 130; i++)
              if (curAnswerPageReading.value == 0 ||
                  (curAnswerPageReading.value == 1 &&
                      widget.answer[i] == widget.answerSelect[i]) ||
                  (curAnswerPageReading.value == 2 &&
                      widget.answer[i] != widget.answerSelect[i]))
                InkWell(
                  onTap: () {
                    //widget.pageController.jumpToPage(54 + i - 100 + 5);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReviewTest(
                                  data: widget.data,
                                  intialPage: 54 + i - 100 + 5,
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      (widget.answerSelect[i] == "")
                          ? Icon(Icons.warning,
                              color: Color.fromARGB(255, 211, 211, 21),
                              size: 32)
                          : (widget.answerSelect[i] == widget.answer[i])
                              ? Icon(Icons.check, color: Colors.green, size: 32)
                              : Icon(Icons.close, color: Colors.red, size: 32),
                      Text('Câu ${i + 1}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      for (var j in answersOption)
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.answer[i] == j
                                ? green
                                : widget.answerSelect[i] != j
                                    ? white
                                    : red,
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
                            j,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                    ],
                  ),
                ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: Text(
                'Part 6: Điền vào đoạn văn',
                style: TextStyle(
                    color: colorApp, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            for (int i = 130; i < 146; i++)
              if (curAnswerPageReading.value == 0 ||
                  (curAnswerPageReading.value == 1 &&
                      widget.answer[i] == widget.answerSelect[i]) ||
                  (curAnswerPageReading.value == 2 &&
                      widget.answer[i] != widget.answerSelect[i]))
                InkWell(
                  onTap: () {
                    //widget.pageController.jumpToPage(84 + (i - 130) ~/ 4 + 6);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReviewTest(
                                  data: widget.data,
                                  intialPage: 84 + (i - 130) ~/ 4 + 6,
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      (widget.answerSelect[i] == "")
                          ? Icon(Icons.warning,
                              color: Color.fromARGB(255, 211, 211, 21),
                              size: 32)
                          : (widget.answerSelect[i] == widget.answer[i])
                              ? Icon(Icons.check, color: Colors.green, size: 32)
                              : Icon(Icons.close, color: Colors.red, size: 32),
                      Text('Câu ${i + 1}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      for (var j in answersOption)
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.answer[i] == j
                                ? green
                                : widget.answerSelect[i] != j
                                    ? white
                                    : red,
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
                            j,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                    ],
                  ),
                ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: Text(
                'Part 7: Đọc hiểu đoạn văn',
                style: TextStyle(
                    color: colorApp, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            for (int i = 146; i < 200; i++)
              if (curAnswerPageReading.value == 0 ||
                  (curAnswerPageReading.value == 1 &&
                      widget.answer[i] == widget.answerSelect[i]) ||
                  (curAnswerPageReading.value == 2 &&
                      widget.answer[i] != widget.answerSelect[i]))
                InkWell(
                  onTap: () {
                    int page;
                    page = 88 + 7;
                    if (i >= 146) {
                      page += (min(i, 153) - 146) ~/ 2;
                    }
                    if (i >= 154) {
                      page += (min(i, 162) - 154) ~/ 3 + 1;
                    }
                    if (i >= 163) {
                      page += (min(i, 174) - 163) ~/ 4 + 1;
                    }
                    if (i >= 175) {
                      page += (i - 175) ~/ 5 + 1;
                    }
                    //widget.pageController.jumpToPage(page);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReviewTest(
                                  data: widget.data,
                                  intialPage: page,
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      (widget.answerSelect[i] == "")
                          ? Icon(Icons.warning,
                              color: Color.fromARGB(255, 211, 211, 21),
                              size: 32)
                          : (widget.answerSelect[i] == widget.answer[i])
                              ? Icon(Icons.check, color: Colors.green, size: 32)
                              : Icon(Icons.close, color: Colors.red, size: 32),
                      Text('Câu ${i + 1}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      for (var j in answersOption)
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.answer[i] == j
                                ? green
                                : widget.answerSelect[i] != j
                                    ? white
                                    : red,
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
                            j,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class ReviewTest extends StatefulWidget {
  final List<Map<String, dynamic>>? data;
  final int intialPage;
  const ReviewTest({super.key, required this.data, required this.intialPage});

  @override
  State<ReviewTest> createState() => _ReviewTestState();
}

class _ReviewTestState extends State<ReviewTest> {
  List<String> numAnswers = [];
  List<List<Map<String, dynamic>>> listQuestion = [[], [], [], [], [], [], []];
  int _curr = 0;
  int _number = 0;
  List<String> _answer = [], rightAnswerSelect = [];
  bool isShow = false;
  var pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.intialPage);
    _curr = widget.intialPage;
    for (int i = 0; i < widget.data!.length; i++) {
      int j = widget.data![i]['part_id'];
      listQuestion[j - 1].add(widget.data![i]);
    }
    int temp = 1;
    for (int i = 0; i < 7; i++) {
      numAnswers.add("");
      for (int j = 0; j < listQuestion[i].length; j++) {
        if (i < 2 || i == 4) {
          numAnswers.add(temp.toString());
          temp++;
        } else {
          numAnswers.add(
              "$temp - ${temp += convertListDynamicToListString(listQuestion[i][j]['list_question']).length - 1}");
          temp++;
        }
      }
    }
    for (int i = 0; i < 200; i++) {
      _answer.add("");
    }
    for (int i = 0; i < listQuestion[0].length; i++) {
      rightAnswerSelect.add(listQuestion[0][i]['list_right_answer'][0]);
    }
    for (int i = 0; i < listQuestion[1].length; i++) {
      rightAnswerSelect.add(listQuestion[1][i]['list_right_answer'][0]);
    }
    for (int i = 1; i <= 7; i++) {
      rightAnswerSelect.addAll(compareAnswersToRightAnswers(i));
    }
    print(rightAnswerSelect);
  }

  void callbackAnswer(int number, String ans) {
    setState(() {
      if (_answer[number] == "") _answer[number] = ans;
    });
  }

  List<String> compareAnswersToRightAnswers(int part) {
    List<String> rightAns = [];
    for (int i = 0; i < listQuestion[part - 1].length; i++) {
      for (int k = 0;
          k < listQuestion[part - 1].elementAt(i)['list_answers'].length;
          k++) {
        for (int j = 0; j < 4; j++) {
          if (answersOption
              .contains(listQuestion[part - 1][i]['list_right_answer'][k])) {}
          if (listQuestion[part - 1].elementAt(i)['list_right_answer'][k] ==
              listQuestion[part - 1].elementAt(i)['list_answers'][k][j]) {
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
    }
    return rightAns;
  }

  @override
  Widget build(BuildContext context) {
    int startPart3 = 32;
    int startPart4 = 71;
    int startPart6 = 131;
    int startPart5 = 100;
    int startPart7 = 146;
    return Scaffold(
      appBar: AppBar(
        title: (numAnswers[_curr] != "")
            ? Text("Câu ${numAnswers[_curr]}")
            : Text(""),
        centerTitle: true,
        backgroundColor: colorApp,
      ),
      body: PageView(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        controller: pageController,
        children: [
          PartIntro(part: 1, controller: pageController),
          for (int i = 0; i < listQuestion[0].length; i++)
            PartOneFrame(
              number: i,
              getAnswer: (numb, value) => callbackAnswer(numb, value),
              ans: _answer,
              rightAnswers: convertListDynamicToListString(
                  listQuestion[0][i]['list_right_answer']),
              listNameImages:
                  convertListDynamicToListString(listQuestion[0][i]['images']),
              audio: listQuestion[0][i]['audio'],
              isExam: false,
            ),
          PartIntro(
            part: 2,
            controller: pageController,
          ),
          for (int i = listQuestion[0].length;
              i < listQuestion[0].length + listQuestion[1].length;
              i++)
            PartTwoFrame(
              audioPath: listQuestion[1][i - listQuestion[0].length]['audio'],
              number: i + 1,
              getAnswer: (numb, value) => callbackAnswer(numb - 1, value),
              ans: _answer,
              rightAnswers: convertListDynamicToListString(listQuestion[1]
                  [i - listQuestion[0].length]['list_right_answer']),
              isExam: false,
            ),
          PartIntro(
            part: 3,
            controller: pageController,
          ),
          for (int i = listQuestion[0].length + listQuestion[1].length;
              i <
                  listQuestion[0].length +
                      listQuestion[1].length +
                      listQuestion[2].length;
              i++)
            PartThreeFrame(
              number: [
                for (int j = 0;
                    j <
                        convertListDynamicToListListString(listQuestion[2][i -
                                listQuestion[0].length -
                                listQuestion[1].length]['list_answers'])
                            .length;
                    j++)
                  startPart3++
              ],
              audioPath: listQuestion[2]
                      [i - listQuestion[0].length - listQuestion[1].length]
                  ['audio'],
              images: List<String>.from(listQuestion[2]
                      [i - listQuestion[0].length - listQuestion[1].length]
                  ['images'] as List),
              question: List<String>.from(listQuestion[2]
                      [i - listQuestion[0].length - listQuestion[1].length]
                  ['list_question'] as List),
              answers: convertListDynamicToListListString(listQuestion[2]
                      [i - listQuestion[0].length - listQuestion[1].length]
                  ['list_answers']),
              getAnswer: (number, value) => callbackAnswer(number - 1, value),
              ans: _answer,
              rightAnswers: rightAnswerSelect,
              isExam: false,
            ),
          PartIntro(
            part: 4,
            controller: pageController,
          ),
          for (int i = listQuestion[0].length +
                  listQuestion[1].length +
                  listQuestion[2].length;
              i <
                  listQuestion[0].length +
                      listQuestion[1].length +
                      listQuestion[2].length +
                      listQuestion[3].length;
              i++)
            PartFourFrame(
              number: [
                for (int j = 0;
                    j <
                        convertListDynamicToListListString(listQuestion[3][i -
                                listQuestion[0].length -
                                listQuestion[1].length -
                                listQuestion[2].length]['list_answers'])
                            .length;
                    j++)
                  startPart4++
              ],
              audioPath: listQuestion[3][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length]['audio'],
              images: List<String>.from(listQuestion[3][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length]['images'] as List),
              question: List<String>.from(listQuestion[3][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length]['list_question'] as List),
              answers: convertListDynamicToListListString(listQuestion[3][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length]['list_answers']),
              getAnswer: (number, value) => callbackAnswer(number - 1, value),
              ans: _answer,
              rightAnswers: rightAnswerSelect,
              isExam: false,
            ),
          PartIntro(
            part: 5,
            controller: pageController,
          ),
          for (int i = listQuestion[0].length +
                  listQuestion[1].length +
                  listQuestion[2].length +
                  listQuestion[3].length;
              i <
                  listQuestion[0].length +
                      listQuestion[1].length +
                      listQuestion[2].length +
                      listQuestion[3].length +
                      listQuestion[4].length;
              i++)
            PartFiveFrame(
              number: startPart5++,
              question: listQuestion[4][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length -
                  listQuestion[3].length]['list_question'][0],
              answers: convertListDynamicToListString(listQuestion[4].elementAt(
                  i -
                      listQuestion[0].length -
                      listQuestion[1].length -
                      listQuestion[2].length -
                      listQuestion[3].length)['list_answers'][0]),
              getAnswer: (number, value) => callbackAnswer(number, value),
              ans: _answer,
              rightAnswers: rightAnswerSelect,
              isExam: false,
            ),
          PartIntro(
            part: 6,
            controller: pageController,
          ),
          for (int i = listQuestion[0].length +
                  listQuestion[1].length +
                  listQuestion[2].length +
                  listQuestion[3].length +
                  listQuestion[4].length;
              i <
                  listQuestion[0].length +
                      listQuestion[1].length +
                      listQuestion[2].length +
                      listQuestion[3].length +
                      listQuestion[4].length +
                      listQuestion[5].length;
              i++)
            PartSixFrame(
              number: [
                for (int j = 0;
                    j <
                        convertListDynamicToListListString(listQuestion[5][i -
                                listQuestion[0].length -
                                listQuestion[1].length -
                                listQuestion[2].length -
                                listQuestion[3].length -
                                listQuestion[4].length]['list_answers'])
                            .length;
                    j++)
                  startPart6++
              ],
              paragraph: listQuestion[5][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length -
                  listQuestion[3].length -
                  listQuestion[4].length]['content'],
              question: List<String>.from(listQuestion[5][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length -
                  listQuestion[3].length -
                  listQuestion[4].length]['list_question'] as List),
              answers: convertListDynamicToListListString(listQuestion[5][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length -
                  listQuestion[3].length -
                  listQuestion[4].length]['list_answers']),
              getAnswer: (number, value) => callbackAnswer(number - 1, value),
              ans: _answer,
              rightAnswers: rightAnswerSelect,
              isExam: false,
            ),
          PartIntro(
            part: 7,
            controller: pageController,
          ),
          for (int i = listQuestion[0].length +
                  listQuestion[1].length +
                  listQuestion[2].length +
                  listQuestion[3].length +
                  listQuestion[4].length +
                  listQuestion[5].length;
              i <
                  listQuestion[0].length +
                      listQuestion[1].length +
                      listQuestion[2].length +
                      listQuestion[3].length +
                      listQuestion[4].length +
                      listQuestion[5].length +
                      listQuestion[6].length;
              i++)
            PartSevenFrame(
              number: [
                for (int j = 0;
                    j <
                        convertListDynamicToListListString(listQuestion[6][i -
                                listQuestion[0].length -
                                listQuestion[1].length -
                                listQuestion[2].length -
                                listQuestion[3].length -
                                listQuestion[4].length -
                                listQuestion[5].length]['list_answers'])
                            .length;
                    j++)
                  startPart7++
              ],
              question: convertListDynamicToListString(listQuestion[6][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length -
                  listQuestion[3].length -
                  listQuestion[4].length -
                  listQuestion[5].length]['list_question']),
              answers: convertListDynamicToListListString(listQuestion[6][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length -
                  listQuestion[3].length -
                  listQuestion[4].length -
                  listQuestion[5].length]['list_answers']),
              rightAnswersSelect: rightAnswerSelect,
              getAnswer: (number, value) => callbackAnswer(number, value),
              ans: _answer,
              listNameImages: convertListDynamicToListString(listQuestion[6][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length -
                  listQuestion[3].length -
                  listQuestion[4].length -
                  listQuestion[5].length]['images']),
              isExam: false,
            ),
        ],
        onPageChanged: (value) {
          setState(() {
            _curr = value;
          });
          printError('page $_curr');
          printError(numAnswers[_curr]);
          printError(_number.toString());
        },
      ),
    );
  }
}
