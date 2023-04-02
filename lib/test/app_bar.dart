import 'dart:math';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:just_audio/just_audio.dart';
import 'package:toeic_app/data/data.dart';
import 'package:toeic_app/part/part_one.dart';
import 'certificate.dart';

import '../constants.dart';
import '../part/app_bar.dart';

PageController readOrListenController = PageController();
PageController filterController = PageController();
final curReadOrListen = ValueNotifier<int>(0);
final curAnswerPageReading = ValueNotifier<int>(0);
final curAnswerPageListening = ValueNotifier<int>(0);

class AppBarTesting extends StatefulWidget implements PreferredSizeWidget {
  final String numAnswers;
  final List<String> answer, answerSelect;
  final PageController pageController;

  const AppBarTesting(
      {super.key,
      required this.numAnswers,
      required this.answer,
      required this.answerSelect,
      required this.pageController});

  @override
  State<AppBarTesting> createState() => _AppBarTestingState();

  @override
  Size get preferredSize => Size(15, 60);
}

class _AppBarTestingState extends State<AppBarTesting> {
  CountdownTimerController timerController = CountdownTimerController(
      endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 120 * 60);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Transform.translate(
          offset: Offset(-25, 0),
          child: (Column(
            children: [
              if (widget.numAnswers != "")
                Row(
                  children: [
                    Text(
                      "Câu ${widget.numAnswers}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              Padding(padding: EdgeInsets.only(top: 4, bottom: 4)),
              if (widget.numAnswers != "")
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(Icons.info_outline),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 10),
                      child: Icon(Icons.settings_outlined),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 10),
                      child: InkWell(
                          onTap: () {
                            showStickyFlexibleBottomSheet<void>(
                              minHeight: 0,
                              initHeight: 0.5,
                              maxHeight: 1,
                              headerHeight: 150,
                              context: context,
                              bottomSheetColor: Colors.transparent,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                              ),
                              bodyBuilder: (context, offset) {
                                return SliverChildListDelegate([
                                  AnswerPageView(
                                    answer: widget.answer,
                                    answerSelect: widget.answerSelect,
                                    pageController: widget.pageController,
                                  )
                                ]);
                              },
                              headerBuilder: (context, offset) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: colorApp,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 50,
                                                child: ListTile(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  title: Transform.translate(
                                                    offset: Offset(20, 0),
                                                    child: Text(
                                                      'Tổng quan',
                                                      style: TextStyle(
                                                          color: white,
                                                          fontSize: 20),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  trailing: TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Icon(
                                                        Icons.cancel,
                                                        color: white,
                                                      )),
                                                ),
                                              ),
                                              ReadOrListenBar(),
                                              FilterBar()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              anchors: [.2, 0.5, .8],
                            );
                          },
                          child: Icon(Icons.view_carousel)),
                    ),
                    InkWell(
                        onTap: () async {
                          int? remainingTime = (timerController
                                          .currentRemainingTime!.hours ??
                                      0) *
                                  60 *
                                  60 *
                                  1000 +
                              (timerController.currentRemainingTime!.min ?? 0) *
                                  60 *
                                  1000 +
                              (timerController.currentRemainingTime!.sec ?? 0) *
                                  1000;
                          printWarning(
                              timerController.currentRemainingTime.toString());
                          timerController.disposeTimer();
                          for (AudioPlayer i in playingAudio) {
                            i.pause();
                          }
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6.0))),
                              icon: Row(
                                children: [
                                  Icon(
                                    Icons.pause_presentation,
                                    color: colorApp,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Tạm dừng bài thi.",
                                    style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              content: Text(
                                "Nhấn 'Tiếp tục' để tiếp tục làm bài hoặc 'Hủy bỏ' để hủy bài thi.",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                                textAlign: TextAlign.justify,
                              ),
                              actions: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: colorApp,
                                        padding: EdgeInsets.only(
                                            left: 25, right: 25)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      timerController.endTime = DateTime.now()
                                              .millisecondsSinceEpoch +
                                          remainingTime;
                                      timerController.start();
                                    },
                                    child: Text(
                                      "Tiếp tục",
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.center,
                                    )),
                                SizedBox(width: 2),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: white.withOpacity(0.6),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0)),
                                          side: BorderSide(color: black)),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(),
                                        width: 50,
                                        child: Center(
                                            child: Text(
                                          "Hủy bỏ",
                                          style: TextStyle(
                                              color: black, fontSize: 15),
                                          textAlign: TextAlign.center,
                                        )))),
                                SizedBox(width: 4),
                              ],
                            ),
                          );
                        },
                        child: Icon(Icons.pause_circle_outline)),
                  ],
                )
            ],
          ))),
      backgroundColor: colorApp,
      centerTitle: true,
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6.0))),
                                icon: Row(
                                  children: [
                                    Icon(
                                      Icons.assignment_turned_in,
                                      color: colorApp,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Nộp bài thi?",
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                content: Text(
                                  "Sau khi nộp bài thi bạn có thể xem kết quả và đáp án",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.justify,
                                ),
                                actions: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: colorApp,
                                          padding: EdgeInsets.only(
                                              left: 25, right: 25)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        //Bảng quy đổi điểm: https://www.anhngumshoa.com/tin-tuc/thang-diem-toeic-cach-tinh-diem-toeic-format-moi-chuan-nhat-34838.html
                                        int readingScore = 0,
                                            listeningScore = 0;
                                        for (int q = 0; q < 100; q++) {
                                          if (widget.answer[q] ==
                                              widget.answerSelect[q]) {
                                            listeningScore++;
                                          }
                                          if (widget.answer[q + 100] ==
                                              widget.answerSelect[q + 100]) {
                                            readingScore++;
                                          }
                                        }
                                        printError(
                                            "listening score: $listeningScore");
                                        printError(
                                            "reading score: $readingScore");
                                        if (listeningScore == 0) {
                                          listeningScore = 5;
                                        } else if (listeningScore <= 75) {
                                          listeningScore =
                                              15 + (listeningScore - 1) * 5;
                                        } else {
                                          listeningScore = min(495,
                                              395 + (listeningScore - 76) * 5);
                                        }
                                        if (readingScore <= 2) {
                                          readingScore = 5;
                                        } else {
                                          readingScore =
                                              10 + (readingScore - 3) * 5;
                                        }
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Scaffold(
                                                      appBar: AppBar(
                                                        title: Text("Kết quả"),
                                                        centerTitle: true,
                                                        backgroundColor:
                                                            colorApp,
                                                      ),
                                                      body: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 20,
                                                                    left: 8,
                                                                    right: 8),
                                                            child: Certificate(
                                                              listeningScore:
                                                                  listeningScore,
                                                              readingScore:
                                                                  readingScore,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child:
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                20)),
                                                                        backgroundColor:
                                                                            colorApp),
                                                                    onPressed:
                                                                        () {},
                                                                    child: Text(
                                                                      "Xem đáp án",
                                                                      style: TextStyle(
                                                                          color:
                                                                              white),
                                                                    )),
                                                          ),
                                                          TextButton.icon(
                                                              onPressed: () {},
                                                              icon: Icon(
                                                                Icons.share,
                                                                color: colorApp,
                                                              ),
                                                              label: Text(
                                                                "Chia sẻ kết quả với bạn bè",
                                                                style: TextStyle(
                                                                    color:
                                                                        black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ))
                                                        ],
                                                      ),
                                                    )));
                                      },
                                      child: Text(
                                        "Nộp",
                                        style: TextStyle(fontSize: 15),
                                        textAlign: TextAlign.center,
                                      )),
                                  SizedBox(width: 2),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: white.withOpacity(0.6),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6.0)),
                                            side: BorderSide(color: black)),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(),
                                          width: 50,
                                          child: Center(
                                              child: Text(
                                            "Hủy bỏ",
                                            style: TextStyle(
                                                color: black, fontSize: 15),
                                            textAlign: TextAlign.center,
                                          )))),
                                  SizedBox(width: 4),
                                ],
                              ));
                    },
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  CountdownTimer(
                    onEnd: () {},
                    controller: timerController,
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Enter a search term',
      ),
    );
  }
}

class _TestContainer extends StatelessWidget {
  final Color color;

  const _TestContainer({
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        color: color,
      ),
    );
  }
}

class AnswerPageView extends StatefulWidget {
  final List<String> answer, answerSelect;
  final PageController pageController;
  const AnswerPageView(
      {super.key,
      required this.answer,
      required this.answerSelect,
      required this.pageController});

  @override
  State<AnswerPageView> createState() => _AnswerPageViewState();
}

class _AnswerPageViewState extends State<AnswerPageView> {
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
      height: MediaQuery.of(context).size.height - 150,
      child: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: readOrListenController,
        children: [
          ListeningPage(
            answer: widget.answer,
            answerSelect: widget.answerSelect,
            pageController: widget.pageController,
          ),
          ReadingPage(
            answer: widget.answer,
            answerSelect: widget.answerSelect,
            pageController: widget.pageController,
          )
        ],
      ),
    );
  }
}

class ReadOrListenBar extends StatefulWidget {
  const ReadOrListenBar({super.key});

  @override
  State<ReadOrListenBar> createState() => _ReadOrListenBarState();
}

class _ReadOrListenBarState extends State<ReadOrListenBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
            color: white,
          ),
          width: double.infinity,
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        curReadOrListen.value = 0;
                        readOrListenController.jumpToPage(0);
                      });
                    },
                    child: Text(
                      'Nghe Hiểu',
                      style: TextStyle(
                          color: (curReadOrListen.value == 0)
                              ? Colors.black
                              : Colors.grey),
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        curReadOrListen.value = 1;
                        readOrListenController.jumpToPage(1);
                      });
                    },
                    child: Text('Đọc Hiểu',
                        style: TextStyle(
                            color: (curReadOrListen.value == 1)
                                ? Colors.black
                                : Colors.grey))),
              )
            ],
          ),
        ),
        if (curReadOrListen.value == 0)
          Positioned(
            left: 0,
            right: MediaQuery.of(context).size.width / 2,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2, color: green),
                ),
              ),
            ),
          ),
        if (curReadOrListen.value == 1)
          Positioned(
            left: MediaQuery.of(context).size.width / 2,
            right: 0,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2, color: green),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class FilterBarListening extends StatefulWidget {
  const FilterBarListening({super.key});

  @override
  State<FilterBarListening> createState() => _FilterBarListeningState();
}

class _FilterBarListeningState extends State<FilterBarListening> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    printError("listening ${curAnswerPageListening.value}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: (curAnswerPageListening.value == 0)
                    ? BorderRadius.all(Radius.circular(20))
                    : BorderRadius.zero,
                color: (curAnswerPageListening.value == 0)
                    ? Colors.white
                    : Colors.grey),
            height: 40,
            width: MediaQuery.of(context).size.width / 3 - 10,
            child: TextButton(
                onPressed: () {
                  setState(() {
                    curAnswerPageListening.value = 0;
                  });
                },
                child: Text(
                  'Tất cả',
                  style: TextStyle(color: Colors.black),
                )),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: (curAnswerPageListening.value == 1)
                    ? BorderRadius.all(Radius.circular(20))
                    : BorderRadius.zero,
                color: (curAnswerPageListening.value == 1)
                    ? Colors.white
                    : Colors.grey),
            height: 40,
            width: MediaQuery.of(context).size.width / 3 - 10,
            child: TextButton(
                onPressed: () {
                  setState(() {
                    curAnswerPageListening.value = 1;
                  });
                },
                child: Text(
                  'Chọn đúng',
                  style: TextStyle(color: Colors.black),
                )),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: (curAnswerPageListening.value == 2)
                    ? BorderRadius.all(Radius.circular(20))
                    : BorderRadius.zero,
                color: (curAnswerPageListening.value == 2)
                    ? Colors.white
                    : Colors.grey),
            height: 40,
            width: MediaQuery.of(context).size.width / 3 - 10,
            child: TextButton(
                onPressed: () {
                  setState(() {
                    curAnswerPageListening.value = 2;
                  });
                },
                child: Text(
                  'Chọn sai',
                  style: TextStyle(color: Colors.black),
                )),
          )
        ],
      ),
    );
  }
}

class FilterBarReading extends StatefulWidget {
  const FilterBarReading({super.key});

  @override
  State<FilterBarReading> createState() => _FilterBarReadingState();
}

class _FilterBarReadingState extends State<FilterBarReading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    printError("listening ${curAnswerPageReading.value}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: (curAnswerPageReading.value == 0)
                    ? BorderRadius.all(Radius.circular(20))
                    : BorderRadius.zero,
                color: (curAnswerPageReading.value == 0)
                    ? Colors.white
                    : Colors.grey),
            height: 40,
            width: MediaQuery.of(context).size.width / 3 - 10,
            child: TextButton(
                onPressed: () {
                  setState(() {
                    curAnswerPageReading.value = 0;
                  });
                },
                child: Text(
                  'Tất cả',
                  style: TextStyle(color: Colors.black),
                )),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: (curAnswerPageReading.value == 1)
                    ? BorderRadius.all(Radius.circular(20))
                    : BorderRadius.zero,
                color: (curAnswerPageReading.value == 1)
                    ? Colors.white
                    : Colors.grey),
            height: 40,
            width: MediaQuery.of(context).size.width / 3 - 10,
            child: TextButton(
                onPressed: () {
                  setState(() {
                    curAnswerPageReading.value = 1;
                  });
                },
                child: Text(
                  'Chọn đúng',
                  style: TextStyle(color: Colors.black),
                )),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: (curAnswerPageReading.value == 2)
                    ? BorderRadius.all(Radius.circular(20))
                    : BorderRadius.zero,
                color: (curAnswerPageReading.value == 2)
                    ? Colors.white
                    : Colors.grey),
            height: 40,
            width: MediaQuery.of(context).size.width / 3 - 10,
            child: TextButton(
                onPressed: () {
                  setState(() {
                    curAnswerPageReading.value = 2;
                  });
                },
                child: Text(
                  'Chọn sai',
                  style: TextStyle(color: Colors.black),
                )),
          )
        ],
      ),
    );
  }
}

class FilterBar extends StatefulWidget {
  const FilterBar({super.key});

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: curReadOrListen,
      builder: (context, value, child) {
        if (curReadOrListen.value == 0) {
          return FilterBarListening();
        } else {
          return FilterBarReading();
        }
      },
    );
  }
}

class ListeningPage extends StatefulWidget {
  final List<String> answer, answerSelect;
  final PageController pageController;
  const ListeningPage(
      {super.key,
      required this.answer,
      required this.answerSelect,
      required this.pageController});

  @override
  State<ListeningPage> createState() => _ListeningPageState();
}

class _ListeningPageState extends State<ListeningPage> {
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
                      Text('Câu ${i + 1}'),
                      for (var j in answersOption)
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.answerSelect[i] != j
                                ? white
                                : yellowBold,
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
                      Text('Câu ${i + 1}'),
                      for (var j in answersOption)
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.answerSelect[i] != j
                                ? white
                                : yellowBold,
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
                      Text('Câu ${i + 1}'),
                      for (var j in answersOption)
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.answerSelect[i] != j
                                ? white
                                : yellowBold,
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
                      Text('Câu ${i + 1}'),
                      for (var j in answersOption)
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.answerSelect[i] != j
                                ? white
                                : yellowBold,
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

class ReadingPage extends StatefulWidget {
  final List<String> answer, answerSelect;
  final PageController pageController;
  const ReadingPage(
      {super.key,
      required this.answer,
      required this.answerSelect,
      required this.pageController});

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
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
                      Text('Câu ${i + 1}'),
                      for (var j in answersOption)
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.answerSelect[i] != j
                                ? white
                                : yellowBold,
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
                      Text('Câu ${i + 1}'),
                      for (var j in answersOption)
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.answerSelect[i] != j
                                ? white
                                : yellowBold,
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
                      Text('Câu ${i + 1}'),
                      for (var j in answersOption)
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.answerSelect[i] != j
                                ? white
                                : yellowBold,
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
