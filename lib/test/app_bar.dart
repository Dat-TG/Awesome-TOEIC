import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:just_audio/just_audio.dart';
import 'package:toeic_app/data/data.dart';
import 'package:toeic_app/part/part_one.dart';

import '../constants.dart';
import '../part/app_bar.dart';

class AppBarTesting extends StatefulWidget implements PreferredSizeWidget {
  final String numAnswers;

  const AppBarTesting({super.key, required this.numAnswers});

  @override
  State<AppBarTesting> createState() => _AppBarTestingState();

  @override
  Size get preferredSize => Size(15, 60);
}

class _AppBarTestingState extends State<AppBarTesting> {
  PageController controller = PageController();
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
                      child: Icon(Icons.view_carousel),
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
                    onTap: () {},
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
