import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:toeic_app/direction.dart';
import 'package:toeic_app/question.dart';
import 'package:toeic_app/services/statistic_service.dart';
import 'package:toeic_app/utils/change_color_by_theme.dart';
import 'package:toeic_app/vocabulary.dart';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/get_It.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  Future<Map<String, dynamic>> statistic = Future(() => {});
  PageController historyController = PageController();
  int currentHistoryPage = 0;

  @override
  void initState() {
    statistic =
        statisticPraticeByUserID(FirebaseAuth.instance.currentUser!.uid);
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
    return FutureBuilder(
        future: statistic,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasError) {
            return (Center(
              child: Text("404: Error"),
            ));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  //   ------------------------------      Listening     ------------------------------
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
                                part: i,
                                doneQuestion: snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? 0
                                    : snapshot.data!['doneQuestion'][i],
                                correctQuestion: snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? 0
                                    : snapshot.data!['correctQuestion'][i],
                                progress: snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? 0
                                    : snapshot.data!['progress'][i])),
                    ],
                  ),

                  //   ------------------------------      Reading     ------------------------------
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
                                part: i,
                                doneQuestion: snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? 0
                                    : snapshot.data!['doneQuestion'][i],
                                correctQuestion: snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? 0
                                    : snapshot.data!['correctQuestion'][i],
                                progress: snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? 0
                                    : snapshot.data!['progress'][i])),
                      Expanded(flex: 1, child: SizedBox())
                    ],
                  ),

                  //   ------------------------------      Notebook     ------------------------------
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 12, 0, 12),
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
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(color: black),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 12, 0, 12),
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
                                                        Question()));
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromRGBO(
                                                  0, 204, 143, 1),
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

                  //   ------------------------------      History     ------------------------------
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Lịch sử',
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
                        padding: const EdgeInsets.fromLTRB(15, 8, 15, 0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            currentHistoryPage = 0;
                                          });
                                          historyController
                                              .jumpToPage(currentHistoryPage);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: 10, top: 5),
                                          decoration: BoxDecoration(
                                              border: currentHistoryPage == 0
                                                  ? Border(
                                                      bottom: BorderSide(
                                                          color: colorApp,
                                                          width: 3))
                                                  : Border()),
                                          child: Text('Luyện tập',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: currentHistoryPage == 0
                                                      ? colorApp
                                                      : black),
                                              textAlign: TextAlign.center),
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  height: 30,
                                  width: 1,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(color: black),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            currentHistoryPage = 1;
                                          });
                                          historyController
                                              .jumpToPage(currentHistoryPage);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: 10, top: 5),
                                          decoration: BoxDecoration(
                                              border: currentHistoryPage == 1
                                                  ? Border(
                                                      bottom: BorderSide(
                                                          color: colorApp,
                                                          width: 3))
                                                  : Border()),
                                          child: Text('Thi',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: currentHistoryPage == 1
                                                      ? colorApp
                                                      : black),
                                              textAlign: TextAlign.center),
                                        ),
                                      )),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                                height: 220,
                                child: PageView(
                                    scrollDirection: Axis.horizontal,
                                    controller: historyController,
                                    onPageChanged: (value) {
                                      setState(() {
                                        currentHistoryPage = value;
                                      });
                                    },
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 170,
                                            child: Column(
                                              children: snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting
                                                  ? []
                                                  : ListTile.divideTiles(
                                                      context: context,
                                                      tiles: (snapshot.data![
                                                                  'listHistory']
                                                              as Map<String,
                                                                  dynamic>)
                                                          .entries
                                                          .take(3)
                                                          .map(
                                                            (history) =>
                                                                ListTile(
                                                              trailing: Text(
                                                                  '${double.parse((history.value['correct'] / history.value['list_answers'].length * 100).toStringAsFixed(0))}%',
                                                                  style: TextStyle(
                                                                      color: history.value['correct'] / history.value['list_answers'].length < 0.5
                                                                          ? red
                                                                          : history.value['correct'] / history.value['list_answers'].length >= 0.5 && history.value['correct'] / history.value['list_answers'].length < 0.8
                                                                              ? orange
                                                                              : green,
                                                                      fontSize: 17,
                                                                      fontWeight: FontWeight.w600)),
                                                              leading: Image.asset(
                                                                  listImage[
                                                                      history.value[
                                                                              'part'] -
                                                                          1],
                                                                  width: 30,
                                                                  height: 30),
                                                              title: Text(
                                                                  listDesc[history
                                                                              .value[
                                                                          'part'] -
                                                                      1],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16)),
                                                            ),
                                                          )).toList(),
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {},
                                              child: Text("Xem thêm"))
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                              height: 150,
                                              child: Center(
                                                child: Text(
                                                    "Bạn chưa thi thử lần nào",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              )),
                                        ],
                                      ),
                                    ]))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}

class BoxContainer extends StatelessWidget {
  final int part, doneQuestion, correctQuestion;
  final double progress;

  const BoxContainer(
      {super.key,
      required this.part,
      required this.doneQuestion,
      required this.correctQuestion,
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
                  context,
                  MaterialPageRoute(
                      builder: (context) => Direction(
                          part: part,
                          doneQuestion: doneQuestion,
                          correctQuestion: correctQuestion,
                          progress: progress)));
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
