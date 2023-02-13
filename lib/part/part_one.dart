import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:rxdart/rxdart.dart';

import './../constants.dart';
// import 'package:flutter/services.dart';
// import 'dart:typed_data';
// import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

class PartOne extends StatefulWidget {
  const PartOne({super.key});

  @override
  State<PartOne> createState() => _PartOneState();
}

class _PartOneState extends State<PartOne> {
  late AudioPlayer _player = AudioPlayer()..setAsset(audioasset);
  List<String> answers = ["A", "B", "C", "D"];

  Stream<PositionData> get _positionDataStream => Rx.combineLatest3(
      _player.positionStream,
      _player.bufferedPositionStream,
      _player.durationStream,
      (a, b, c) => PositionData(a, b, c ?? Duration.zero));

  String audioasset = "assets/audio/10.mp3";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Transform.translate(
            offset: Offset(-25, 0),
            child: (Row(
              children: [
                Text("Câu 1"),
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
      body: Column(
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
                        padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
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
                            child: Image.asset('assets/img/test_1.jpg'),
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
                        progressBarColor: Colors.red,
                        thumbColor: Colors.red,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: orange, width: 5))),
                child: Text(
                  'Câu 1',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: orange, fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: colorBox,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
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
                    for (var i in answers)
                      InkWell(
                        onTap: () {
                          print(i);
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: white,
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
        ],
      ),
    );
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
