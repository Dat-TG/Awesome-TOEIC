import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';

import 'app_bar.dart';

final PageController pageController = PageController();

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
              pageController: pageController,
            )
          ],
        ));
  }
}

class StaticAnswerPageView extends StatefulWidget {
  final List<String> answer, answerSelect;
  final PageController pageController;
  const StaticAnswerPageView(
      {super.key,
      required this.answer,
      required this.answerSelect,
      required this.pageController});

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
            pageController: widget.pageController,
          ),
          StaticReadingPage(
            answer: widget.answer,
            answerSelect: widget.answerSelect,
            pageController: widget.pageController,
          )
        ],
      ),
    );
  }
}

class StaticListeningPage extends StatefulWidget {
  final List<String> answer, answerSelect;
  final PageController pageController;
  const StaticListeningPage(
      {super.key,
      required this.answer,
      required this.answerSelect,
      required this.pageController});

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
                    widget.pageController.jumpToPage(i + 1);
                    Navigator.pop(context);
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
                    widget.pageController.jumpToPage(i + 2);
                    Navigator.pop(context);
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
                    widget.pageController.jumpToPage(31 + (i - 31) ~/ 3 + 3);
                    Navigator.pop(context);
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
                    widget.pageController.jumpToPage(44 + (i - 70) ~/ 3 + 4);
                    Navigator.pop(context);
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
  final PageController pageController;
  const StaticReadingPage(
      {super.key,
      required this.answer,
      required this.answerSelect,
      required this.pageController});

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
                    widget.pageController.jumpToPage(54 + i - 100 + 5);
                    Navigator.pop(context);
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
                    widget.pageController.jumpToPage(84 + (i - 130) ~/ 4 + 6);
                    Navigator.pop(context);
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
                    widget.pageController.jumpToPage(page);
                    Navigator.pop(context);
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
