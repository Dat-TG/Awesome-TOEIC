import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:toeic_app/part/app_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import './../constants.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

class PartOne extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const PartOne({super.key, required this.data});

  @override
  State<PartOne> createState() => _PartOneState();
}

class _PartOneState extends State<PartOne> {
  int _curr = 1;
  int totalQues = 6;
  List<String> _answer = [];
  PageController controller = PageController();
  bool isShow = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < totalQues; i++) {
      _answer.add("");
    }
  }

  void callbackAnswer(int number, String ans) {
    setState(() {
      if (_answer[number] == "") _answer[number] = ans;
      print(_answer);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarPractice(
          numAnswers: '$_curr',
          answers: listDirectionEng,
          ansTrans: listDirectionVn,
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
              for (int i = 0; i < totalQues; i++)
                PartOneFrame(
                    number: i,
                    getAnswer: (numb, value) => callbackAnswer(numb, value),
                    ans: _answer,
                    isShow: isShow,
                    rightAnswers: convertListDynamicToListString(
                        widget.data[i]['list_right_answer']),
                    listNameImages: convertListDynamicToListString(
                        widget.data[i]['images']),
                    audio: widget.data[i]['audio'],
                    cancelShowExplan: (s) {
                      setState(() {
                        isShow = s;
                      });
                    })
            ]));
  }
}

class PartOneFrame extends StatefulWidget {
  final int number;
  final List<String> ans;
  final Function(int, String) getAnswer;
  final bool isShow;
  final Function(bool) cancelShowExplan;
  final List<String> rightAnswers, listNameImages;
  final String audio;
  // Note, reason

  const PartOneFrame(
      {super.key,
      required this.number,
      required this.getAnswer,
      required this.ans,
      required this.rightAnswers,
      required this.listNameImages,
      required this.audio,
      required this.isShow,
      required this.cancelShowExplan});

  @override
  State<PartOneFrame> createState() => _PartOneFrameState();
}

// --------------------------------------------------------------------
class _PartOneFrameState extends State<PartOneFrame> {
  AudioPlayer _player = AudioPlayer();
  FirebaseStorage storage = FirebaseStorage.instance;

  Stream<PositionData> get _positionDataStream => Rx.combineLatest3(
      _player.positionStream,
      _player.bufferedPositionStream,
      _player.durationStream,
      (position, bufferedPosition, duration) =>
          PositionData(position, bufferedPosition, duration ?? Duration.zero));
  String imageURL = "";
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    Reference audioRef = storage.ref().child(widget.audio);
    String audioURL = await audioRef.getDownloadURL();
    String url = await storage
        .ref()
        .child('img/${widget.listNameImages[0]}')
        .getDownloadURL();

    setState(() {
      imageURL = url;
    });
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
    playingAudio.add(_player);
    _player.play();

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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 15),
                        child: RichText(
                            text: TextSpan(
                                text: "Select the ",
                                style:
                                    TextStyle(fontSize: 16, color: textColor),
                                children: [
                              TextSpan(
                                  text: "answer",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: orange,
                                  )),
                            ])),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                            child: imageURL != ""
                                ? Image.network(imageURL,
                                    width: 340, height: 300, fit: BoxFit.fill)
                                : SizedBox(
                                    width: 340,
                                    height: 300,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
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
              Controls(
                player: _player,
              ),
            ],
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
                                        i == widget.rightAnswers[0]
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
                                    offset: Offset(
                                        0, 3), // changes position of shadow
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
