import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:toeic_app/direction.dart';
import 'package:toeic_app/question.dart';
import 'package:toeic_app/vocabulary.dart';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'others/get_It.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = locator<SharedPreferences>();
    setState(() {
      isDarkMode = (prefs.getBool('DarkMode') ?? false);
      changeColorByTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Listening
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Nghe hiểu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ]),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              for (int i = 0; i < 4; i++)
                Expanded(flex: 1, child: BoxContainer(part: i)),
            ],
          ),

          // Reading
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Đọc hiểu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ]),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              for (int i = 4; i < 7; i++)
                Expanded(flex: 1, child: BoxContainer(part: i)),
              Expanded(flex: 1, child: SizedBox())
            ],
          ),

          // Notebook
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Sổ tay',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ]),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: colorBox,
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
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    './assets/img/voca_icon.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 6),
                                  Text('Từ vựng',
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                child: Text(
                                  '0',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Vocabulary()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: colorApp,
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                  child: Text('Ôn tập'))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 1,
                          child: const DecoratedBox(
                            decoration: BoxDecoration(color: Colors.black),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    './assets/img/ques_icon.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 6),
                                  Text('Câu hỏi',
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                child: Text(
                                  '0',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Question()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromRGBO(0, 204, 143, 1),
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                  child: Text('Ôn tập'))
                            ],
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BoxContainer extends StatelessWidget {
  final int part; // Part 1-7 --> [0..6]

  const BoxContainer({super.key, required this.part});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Direction(part: part)));
            },
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: colorBox,
                border: Border.symmetric(),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: colorBoxShadow,
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12, top: 5),
                    child: Image.asset(
                      listImage[part],
                      width: 50,
                      height: 50,
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 6,
                    child: LinearProgressIndicator(
                      backgroundColor: colorApp3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        colorApp,
                      ),
                      value: listProgress[part],
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            listTitle[part],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        SizedBox(
          height: 50,
          width: 100,
          child: Text(
            listDesc[part],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
