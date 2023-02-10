import "package:flutter/material.dart";
import 'package:toeic_app/question.dart';
import 'package:toeic_app/vocabulary.dart';
import './part/part_one.dart';
import './part/part_two.dart';
import './part/part_three.dart';
import './part/part_four.dart';
import './part/part_five.dart';
import './part/part_six.dart';
import './part/part_seven.dart';
import 'constants.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  final List<String> listTitle = [
    'Part 1',
    'Part 2',
    'Part 3',
    'Part 4',
    'Part 5',
    'Part 6',
    'Part 7'
  ];
  final List<Widget> listTapWidget = [
    PartOne(),
    PartTwo(),
    PartThree(),
    PartFour(),
    PartFive(),
    PartSix(),
    PartSeven()
  ];

  final List<String> listDesc = [
    'Mô tả ảnh',
    'Hỏi & đáp',
    'Đoạn hội thoại',
    'Đoạn văn đơn',
    'Điền vào câu',
    'Điền vào đoạn',
    'Đọc hiểu đoạn văn'
  ];
  final List<String> listImage = [
    'assets/img/image_icon.png',
    'assets/img/qa.png',
    'assets/img/chat.png',
    'assets/img/headphones.png',
    'assets/img/vocabulary.png',
    'assets/img/form.png',
    'assets/img/book.png',
  ];
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
                Expanded(
                    flex: 1,
                    child: BoxContainer(
                        title: listTitle[i],
                        img: listImage[i],
                        desc: listDesc[i],
                        navTap: listTapWidget[i],
                        progress: 0.4)),
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
                Expanded(
                    flex: 1,
                    child: BoxContainer(
                      title: listTitle[i],
                      img: listImage[i],
                      desc: listDesc[i],
                      navTap: listTapWidget[i],
                      progress: 0.4,
                    )),
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
                color: Color.fromARGB(255, 252, 251, 251),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10)),
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
  final String title, img, desc;
  final double progress;
  final Widget navTap;

  const BoxContainer(
      {super.key,
      required this.title,
      required this.img,
      required this.desc,
      required this.navTap,
      required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => navTap));
            },
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 252, 251, 251),
                border: Border.symmetric(),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
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
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Image.asset(
                      img,
                      width: 55,
                      height: 55,
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
                      value: progress,
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
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        SizedBox(
          height: 50,
          width: 80,
          child: Text(
            desc,
            style: TextStyle(fontSize: 17),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
