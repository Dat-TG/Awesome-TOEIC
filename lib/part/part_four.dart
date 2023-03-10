import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:toeic_app/part/cancel_dialog.dart';
import 'package:toeic_app/part/part_one.dart';
import 'package:toeic_app/part/result.dart';
import 'package:toeic_app/part/submit_dialog.dart';
import './../utils/convert_ans_text_to_choice.dart';
import 'package:toeic_app/utils/convert_dynamic.dart';

import './../constants.dart';
import 'app_bar.dart';
import 'question_frame.dart';

class PartFour extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const PartFour({super.key, required this.data});

  @override
  State<PartFour> createState() => _PartFourState();
}

class _PartFourState extends State<PartFour> {
  int _curr = 1;
  late int totalQues;
  List<String> _answers = [];
  PageController controllerFrame = PageController();
  bool isShow = false;
  String numAnswers = "1-3";
  late List<String> rightAnsChoice, listQuestionsID;
  bool isDialog = true;

  void callbackAnswer(int number, String value) {
    setState(() {
      if (_answers[number - 1] == "") _answers[number - 1] = value;
    });
  }

  @override
  void initState() {
    setState(() {
      rightAnsChoice = [];
      listQuestionsID = [];
      totalQues = widget.data.length * 3;
      for (int j = 0; j < widget.data.length; j++) {
        listQuestionsID.add(widget.data[j]['id']);
      }
      for (int i = 0; i < totalQues; i++) {
        _answers.add("");
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
                        position: Tween(begin: Offset(1, 0), end: Offset(0, 0))
                            .animate(anim1),
                        child: child,
                      );
                    },
                    pageBuilder: (context, anim1, anim2) => SubmitDialog(
                        listQuestionsID: listQuestionsID,
                        part: 4,
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
                    numAnswers = "${number * 3 + 1}-${number * 3 + 3}";
                  });
                },
                children: [
                  for (int i = 0; i < widget.data.length; i++)
                    PartFourFrame(
                      number: [
                        for (int j = 0;
                            j <
                                convertListDynamicToListListString(
                                        widget.data[i]['list_answers'])
                                    .length;
                            j++)
                          _curr++
                      ],
                      audioPath: widget.data[i]['audio'],
                      images:
                          List<String>.from(widget.data[i]['images'] as List),
                      question: List<String>.from(
                          widget.data[i]['list_question'] as List),
                      answers: convertListDynamicToListListString(
                          widget.data[i]['list_answers']),
                      getAnswer: (number, value) =>
                          callbackAnswer(number, value),
                      ans: _answers,
                      isShow: isShow,
                      cancelShowExplan: (s) {
                        setState(() {
                          isShow = s;
                        });
                      },
                      rightAnswers: rightAnsChoice,
                    ),
                ]))));
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
  final List<String> images;
  final List<String> rightAnswers;
  // Note, reason

  const PartFourFrame(
      {super.key,
      required this.number,
      required this.audioPath,
      required this.images,
      required this.question,
      required this.answers,
      required this.getAnswer,
      required this.ans,
      required this.cancelShowExplan,
      required this.isShow,
      required this.rightAnswers});

  @override
  State<PartFourFrame> createState() => _PartFourFrameState();
}

// --------------------------------------------------------------------
class _PartFourFrameState extends State<PartFourFrame> {
  PageController controllerAnswer = PageController();
  FirebaseStorage storage = FirebaseStorage.instance;
  late int _currAns;

  late AudioPlayer _player = AudioPlayer();
  String imageURL = "";

  Stream<PositionData> get _positionDataStream => Rx.combineLatest3(
      _player.positionStream,
      _player.bufferedPositionStream,
      _player.durationStream,
      (position, bufferedPosition, duration) =>
          PositionData(position, bufferedPosition, duration ?? Duration.zero));

  void init() async {
    Reference audioRef = storage.ref().child(widget.audioPath);
    String audioURL = await audioRef.getDownloadURL();
    String url = "";
    if (widget.images[0] != "") {
      url =
          await storage.ref().child('img/${widget.images[0]}').getDownloadURL();
    }

    setState(() {
      imageURL = url;
    });
    await _player.setAudioSource(ConcatenatingAudioSource(
        children: [AudioSource.uri(Uri.parse(audioURL))]));
  }

  @override
  void initState() {
    init();
    super.initState();
    _currAns = widget.number[0];
  }

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
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
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: imageURL != ""
                              ? const EdgeInsets.fromLTRB(15, 20, 15, 15)
                              : const EdgeInsets.all(0),
                          child: imageURL != ""
                              ? Image.network(imageURL,
                                  width: 340,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  fit: BoxFit.fill)
                              : SizedBox(),
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width * 2 / 3 > 500
                          ? 500
                          : MediaQuery.of(context).size.width * 0.9,
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
                      width: MediaQuery.of(context).size.width,
                      constraints: BoxConstraints(
                          minHeight: 50,
                          maxHeight: MediaQuery.of(context).size.height * 1),
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
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight: 50,
                              maxHeight: imageURL != ""
                                  ? MediaQuery.of(context).size.height * 0.25
                                  : MediaQuery.of(context).size.height * 0.4),
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
                            print(widget.number);
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
                                              color: widget.ans[widget.number[size] -
                                                              1] !=
                                                          "" &&
                                                      i ==
                                                          widget.rightAnswers[
                                                              widget.number[size] -
                                                                  1]
                                                  ? green
                                                  : (widget.ans[
                                                              widget.number[size] -
                                                                  1] !=
                                                          "")
                                                      ? (i ==
                                                              widget.ans[widget
                                                                      .number[size] -
                                                                  1]
                                                          ? red
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
