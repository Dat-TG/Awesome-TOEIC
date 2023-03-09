import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:toeic_app/part/result.dart';
import 'package:toeic_app/part/submit_dialog.dart';

import './../constants.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

class PartTwo extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const PartTwo({super.key, required this.data});

  @override
  State<PartTwo> createState() => _PartTwoState();
}

class _PartTwoState extends State<PartTwo> {
  int _curr = 1;
  int totalQues = 4; // Example
  List<String> _answers = [];
  PageController controller = PageController();
  late List<String> rightAnsChoice, listQuestionsID;
  bool isDialog = true;

  @override
  void initState() {
    setState(() {
      totalQues = widget.data.length;
      _answers = [];
      rightAnsChoice = [];
      listQuestionsID = [];
      for (int i = 0; i < widget.data.length; i++) {
        listQuestionsID.add(widget.data[i]['id']);
        _answers.add("");
        rightAnsChoice.add(widget.data[i]['list_right_answer'][0]);
      }
    });
    super.initState();
  }

  void callbackAnswer(int number, String ans) {
    setState(() {
      _answers[number - 1] = ans;
    });
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
        body: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is OverscrollNotification &&
                  controller.page == totalQues - 1) {
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
                        part: 2,
                        listAnswers: _answers,
                        direct: Result(
                            part: 1,
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
                    PartTwoFrame(
                      audioPath: widget.data[i]['audio'],
                      number: i + 1,
                      getAnswer: (numb, value) => callbackAnswer(numb, value),
                      ans: _answers,
                      rightAnswers: convertListDynamicToListString(
                          widget.data[i]['list_right_answer']),
                    ),
                ])));
  }
}

// -----------------------------------------

class PartTwoFrame extends StatefulWidget {
  final int number;
  final String audioPath;
  final List<String> ans, rightAnswers;
  final Function(int, String) getAnswer;
  // Note, reason

  const PartTwoFrame(
      {super.key,
      required this.number,
      required this.audioPath,
      required this.getAnswer,
      required this.ans,
      required this.rightAnswers});

  @override
  State<PartTwoFrame> createState() => _PartTwoFrameState();
}

// --------------------------------------------------------------------
class _PartTwoFrameState extends State<PartTwoFrame> {
  late AudioPlayer _player = AudioPlayer();
  FirebaseStorage storage = FirebaseStorage.instance;

  Stream<PositionData> get _positionDataStream => Rx.combineLatest3(
      _player.positionStream,
      _player.bufferedPositionStream,
      _player.durationStream,
      (position, bufferedPosition, duration) =>
          PositionData(position, bufferedPosition, duration ?? Duration.zero));

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    Reference audioRef = storage.ref().child(widget.audioPath);
    String audioURL = await audioRef.getDownloadURL();
    await _player.setAudioSource(ConcatenatingAudioSource(
        children: [AudioSource.uri(Uri.parse(audioURL))]));
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Nghe và chọn câu trả lời phù hợp",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              Padding(
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
                            color: colorApp, fontWeight: FontWeight.w600),
                        progress: positionData?.position ?? Duration.zero,
                        buffered:
                            positionData?.bufferedPosition ?? Duration.zero,
                        total: positionData?.duration ?? Duration.zero,
                        onSeek: _player.seek,
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Controls(
                    player: _player,
                  ),
                ],
              ),
            ],
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
                  'Q.${widget.number}',
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
                            color: widget.ans[widget.number - 1] != "" &&
                                    i == widget.rightAnswers[0]
                                ? green
                                : (widget.ans[widget.number - 1] != "")
                                    ? (i == widget.ans[widget.number - 1]
                                        ? red
                                        : white)
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

class Controls extends StatelessWidget {
  const Controls({super.key, required this.player});
  final AudioPlayer player;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (playing != true) {
          return IconButton(
            icon: const Icon(Icons.play_arrow),
            iconSize: 32.0,
            onPressed: player.play,
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: const Icon(Icons.pause),
            iconSize: 32.0,
            onPressed: player.pause,
          );
        }
        return IconButton(
          icon: const Icon(Icons.replay),
          iconSize: 32.0,
          onPressed: () => player.seek(Duration.zero),
        );
      },
    );
  }
}

class PositionData {
  const PositionData(this.position, this.bufferedPosition, this.duration);
  final Duration position, bufferedPosition, duration;
}
