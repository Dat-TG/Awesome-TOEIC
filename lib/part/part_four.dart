import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:toeic_app/part/part_one.dart';

import './../constants.dart';
import 'question_frame.dart';

class PartFour extends StatefulWidget {
  const PartFour({super.key});

  @override
  State<PartFour> createState() => _PartFourState();
}

class _PartFourState extends State<PartFour> {
  int _curr = 1;
  int totalQues = listQuestionPart4.length * 3; //Example
  List<String> _answer = [];
  PageController controllerFrame = PageController();
  bool isShow = false;

  void callbackAnswer(int number, String value) {
    setState(() {
      _answer[number - 1] = value;
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
                        "Câu ${_curr}-${_curr + 2}",
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
                _curr = number * 3 + 1;
              });
            },
            children: [
              for (int i = 0; i < listQuestionPart4.length; i++)
                PartFourFrame(
                  number: [_curr, _curr + 1, _curr + 2],
                  audioPath: 'assets/audio/10.mp3',
                  question: listQuestionPart4[i]['listQuestion'],
                  answers: listQuestionPart4[i]['listAnswer'],
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

class PartFourFrame extends StatefulWidget {
  final List<int> number;
  final String audioPath;
  final List<String> question, ans;
  final List<List<String>> answers;
  final Function(int, String) getAnswer;
  final Function(bool) cancelShowExplan;
  final bool isShow;
  // Note, reason

  const PartFourFrame(
      {super.key,
      required this.number,
      required this.audioPath,
      required this.question,
      required this.answers,
      required this.getAnswer,
      required this.ans,
      required this.cancelShowExplan,
      required this.isShow});

  @override
  State<PartFourFrame> createState() => _PartFourFrameState();
}

// --------------------------------------------------------------------
class _PartFourFrameState extends State<PartFourFrame> {
  PageController controllerAnswer = PageController();
  late int _currAns;

  late AudioPlayer _player = AudioPlayer()..setAsset(widget.audioPath);

  Stream<PositionData> get _positionDataStream => Rx.combineLatest3(
      _player.positionStream,
      _player.bufferedPositionStream,
      _player.durationStream,
      (position, bufferedPosition, duration) =>
          PositionData(position, bufferedPosition, duration ?? Duration.zero));

  @override
  void initState() {
    super.initState();
    _currAns = widget.number[0];
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _player.play();
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
                          maxHeight: MediaQuery.of(context).size.height * 0.1),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20, left: 20, top: 20, bottom: 20),
                        child: StreamBuilder(
                            stream: _positionDataStream,
                            builder: (context, snapshot) {
                              final positionData = snapshot.data;
                              return ProgressBar(
                                barHeight: 8,
                                baseBarColor: Colors.grey[600],
                                bufferedBarColor: Colors.grey,
                                progressBarColor: colorApp,
                                thumbColor: colorApp,
                                timeLabelTextStyle: TextStyle(
                                    color: colorApp,
                                    fontWeight: FontWeight.w600),
                                progress:
                                    positionData?.position ?? Duration.zero,
                                buffered: positionData?.bufferedPosition ??
                                    Duration.zero,
                                total: positionData?.duration ?? Duration.zero,
                                onSeek: _player.seek,
                              );
                            }),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 < 380
                          ? 380
                          : MediaQuery.of(context).size.width / 2,
                      constraints: BoxConstraints(
                          minHeight: 50,
                          maxHeight: MediaQuery.of(context).size.height * 0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Controls(
                            player: _player,
                          ),
                        ],
                      ),
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
                                  MediaQuery.of(context).size.height * 0.4),
                          padding: const EdgeInsets.fromLTRB(5, 5, 0, 10),
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  for (int j = 0; j < widget.number.length; j++)
                                    QuestionFrame(
                                      number: widget.number[j],
                                      question: widget.question[j],
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
                                  'Câu $index',
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
