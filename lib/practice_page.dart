import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:screenshot/screenshot.dart';
import 'package:toeic_app/direction.dart';
import 'package:toeic_app/part/app_bar.dart';
import 'package:toeic_app/part/result.dart';
import 'package:toeic_app/question.dart';
import 'package:toeic_app/services/exam_service.dart';
import 'package:toeic_app/services/statistic_service.dart';
import 'package:toeic_app/test/certificate.dart';
import 'package:toeic_app/test/review.dart';
import 'package:toeic_app/utils/change_color_by_theme.dart';
import 'package:toeic_app/utils/convert_dynamic.dart';
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

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      statistic =
          statisticPraticeByUserID(FirebaseAuth.instance.currentUser!.uid);
    } else {
      List<double> progress = [for (int i = 0; i < 7; i++) 0];
      List<int> doneQuestionsForPart = [for (int i = 0; i < 7; i++) 0],
          correctQuestions = [for (int i = 0; i < 7; i++) 0];
      Map<String, dynamic> listHistory = {};
      statistic = Future(() => {
            'listHistory': listHistory,
            'listExam': [],
            'doneQuestion': doneQuestionsForPart,
            'correctQuestion': correctQuestions,
            'progress': progress,
          });
    }
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
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => Result(
                                                                            listQuestions:
                                                                                history.value['list_questions'],
                                                                            listAnswers: convertListDynamicToListString(history.value['list_answers']),
                                                                            listRightAnswers: convertListDynamicToListString(history.value['list_right_answers']),
                                                                            part: history.value['part'] - 1)));
                                                              },
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
                                          snapshot.connectionState ==
                                                  ConnectionState.waiting
                                              ? SizedBox.shrink()
                                              : snapshot.data!['listHistory']
                                                          .length <=
                                                      3
                                                  ? SizedBox.shrink()
                                                  : TextButton(
                                                      onPressed: () {
                                                        showModalBottomSheet<
                                                                void>(
                                                            context: context,
                                                            isScrollControlled:
                                                                true,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return DraggableScrollableSheet(
                                                                  expand: false,
                                                                  initialChildSize:
                                                                      .8,
                                                                  minChildSize:
                                                                      .8,
                                                                  maxChildSize:
                                                                      .8,
                                                                  builder: (BuildContext
                                                                          context,
                                                                      ScrollController
                                                                          scrollController) {
                                                                    return SeeMoreHistory(
                                                                        histories:
                                                                            snapshot.data![
                                                                                'listHistory'],
                                                                        correctQuestion:
                                                                            snapshot.data!['correctQuestion']);
                                                                  });
                                                            });
                                                      },
                                                      child: Text("Xem thêm"))
                                        ],
                                      ),
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
                                                                  'listExam']
                                                              as List<
                                                                  Map<String,
                                                                      dynamic>>)
                                                          .take(3)
                                                          .map(
                                                            (history) =>
                                                                ListTile(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            Scaffold(
                                                                              appBar: AppBar(
                                                                                title: Text("Kết quả"),
                                                                                centerTitle: true,
                                                                                backgroundColor: colorApp,
                                                                              ),
                                                                              body: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
                                                                                    child: Certificate(
                                                                                      listeningScore: history['listening_score'],
                                                                                      readingScore: history['reading_score'],
                                                                                      screenshotController: screenshotController,
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(10),
                                                                                    child: ElevatedButton(
                                                                                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), backgroundColor: colorApp),
                                                                                        onPressed: () async {
                                                                                          var data = await FirebaseFirestore.instance.collection("Examinations").doc(history['exam_id']).get();
                                                                                          if (!mounted) {
                                                                                            return;
                                                                                          }
                                                                                          Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                  builder: (context) => FutureBuilder(
                                                                                                      future: getAllQuestionSnapshot(data),
                                                                                                      builder: (context, snapshot) {
                                                                                                        List<Map<String, dynamic>> data = [];

                                                                                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                                          return Dialog.fullscreen(
                                                                                                            child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                                                                                                              const Text('Questions are loading, please wait...'),
                                                                                                              const SizedBox(height: 15),
                                                                                                              SizedBox(
                                                                                                                width: 200,
                                                                                                                height: 5,
                                                                                                                child: LinearProgressIndicator(),
                                                                                                              )
                                                                                                            ]),
                                                                                                          );
                                                                                                        }
                                                                                                        if (snapshot.connectionState == ConnectionState.done) {
                                                                                                          data = snapshot.data as List<Map<String, dynamic>>;
                                                                                                        }

                                                                                                        return ResultExam(testID: history['exam_id'], data: data, answer: convertListDynamicToListString(history['list_right_answers']), answerSelect: convertListDynamicToListString(history['list_answers']));
                                                                                                      })));
                                                                                        },
                                                                                        child: Text(
                                                                                          "Xem đáp án",
                                                                                          style: TextStyle(color: white),
                                                                                        )),
                                                                                  ),
                                                                                  TextButton.icon(
                                                                                      onPressed: () {
                                                                                        screenshotController.capture(delay: Duration(milliseconds: 10)).then((capturedImage) async {
                                                                                          //showCapturedWidget(
                                                                                          //  context,
                                                                                          //capturedImage!);
                                                                                          await Share.file('Toeic Certificate', 'certificate.png', capturedImage!, 'image/png', text: 'Awesome TOEIC Certificate');
                                                                                        }).catchError((onError) {
                                                                                          print(onError);
                                                                                        });
                                                                                      },
                                                                                      icon: Icon(
                                                                                        Icons.share,
                                                                                        color: colorApp,
                                                                                      ),
                                                                                      label: Text(
                                                                                        "Chia sẻ kết quả với bạn bè",
                                                                                        style: TextStyle(color: black, fontWeight: FontWeight.w400),
                                                                                      ))
                                                                                ],
                                                                              ),
                                                                            )));
                                                              },
                                                              trailing: Text(
                                                                  '${history['reading_score'] + history['listening_score']}/990',
                                                                  style: TextStyle(
                                                                      color: (history['reading_score'] + history['listening_score']) < 200
                                                                          ? red
                                                                          : (history['reading_score'] + history['listening_score']) < 500
                                                                              ? orange
                                                                              : green,
                                                                      fontSize: 17,
                                                                      fontWeight: FontWeight.w600)),
                                                              leading: Image.asset(
                                                                  "assets/img/test.png",
                                                                  width: 30,
                                                                  height: 30),
                                                              title: Text(
                                                                  "Test ${history['exam_id']}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16)),
                                                            ),
                                                          )).toList(),
                                            ),
                                          ),
                                          snapshot.connectionState ==
                                                  ConnectionState.waiting
                                              ? SizedBox.shrink()
                                              : snapshot.data!['listExam']
                                                          .length <=
                                                      3
                                                  ? SizedBox.shrink()
                                                  : TextButton(
                                                      onPressed: () {
                                                        showModalBottomSheet<
                                                                void>(
                                                            context: context,
                                                            isScrollControlled:
                                                                true,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return DraggableScrollableSheet(
                                                                  expand: false,
                                                                  initialChildSize:
                                                                      .8,
                                                                  minChildSize:
                                                                      .8,
                                                                  maxChildSize:
                                                                      .8,
                                                                  builder: (BuildContext
                                                                          context,
                                                                      ScrollController
                                                                          scrollController) {
                                                                    return SeeMoreExam(
                                                                        exam: snapshot
                                                                            .data!['listExam']);
                                                                  });
                                                            });
                                                      },
                                                      child: Text("Xem thêm"))
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

class SeeMoreHistory extends StatefulWidget {
  final Map<String, dynamic> histories;
  final List<int> correctQuestion;
  const SeeMoreHistory(
      {super.key, required this.histories, required this.correctQuestion});

  @override
  State<SeeMoreHistory> createState() => _SeeMoreHistoryState();
}

class _SeeMoreHistoryState extends State<SeeMoreHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorAppBold,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Row(mainAxisSize: MainAxisSize.max, children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          'Lịch sử luyện tập',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ]),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.histories.entries
                          .map((history) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Result(
                                                listQuestions: history
                                                    .value['list_questions'],
                                                listAnswers:
                                                    convertListDynamicToListString(
                                                        history.value[
                                                            'list_answers']),
                                                listRightAnswers:
                                                    convertListDynamicToListString(
                                                        history.value[
                                                            'list_right_answers']),
                                                part: history.value['part'] -
                                                    1)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: black.withOpacity(0.2)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 20),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                              listImage[
                                                  history.value['part'] - 1],
                                              width: 45,
                                              height: 45),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                            history
                                                                .value['time'],
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: black
                                                                    .withOpacity(
                                                                        0.6))),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                            listDesc[history
                                                                        .value[
                                                                    'part'] -
                                                                1],
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: black)),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 6,
                                                              bottom: 8),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              'Số câu hỏi: ${history.value['list_answers'].length}',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: black
                                                                      .withOpacity(
                                                                          0.8))),
                                                          Text(
                                                              '${double.parse((history.value['correct'] / history.value['list_answers'].length * 100).toStringAsFixed(0))}%',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: history.value['correct'] / history.value['list_answers'].length <
                                                                          0.5
                                                                      ? red
                                                                      : history.value['correct'] / history.value['list_answers'].length >= 0.5 &&
                                                                              history.value['correct'] / history.value['list_answers'].length <
                                                                                  0.8
                                                                          ? orange
                                                                          : green),
                                                              textAlign:
                                                                  TextAlign
                                                                      .right),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                      child:
                                                          LinearProgressIndicator(
                                                        backgroundColor:
                                                            colorApp3,
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          history.value['correct'] /
                                                                      history
                                                                          .value[
                                                                              'list_answers']
                                                                          .length <
                                                                  0.5
                                                              ? orange
                                                              : history.value['correct'] / history.value['list_answers'].length >=
                                                                          0.5 &&
                                                                      history.value['correct'] /
                                                                              history.value['list_answers'].length <
                                                                          0.8
                                                                  ? orange
                                                                  : green,
                                                        ),
                                                        value: history.value[
                                                                'correct'] /
                                                            history
                                                                .value[
                                                                    'list_answers']
                                                                .length,
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  )),
                )
              ]),
        ));
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

class SeeMoreExam extends StatefulWidget {
  final List<Map<String, dynamic>> exam;
  const SeeMoreExam({super.key, required this.exam});

  @override
  State<SeeMoreExam> createState() => _SeeMoreExamState();
}

class _SeeMoreExamState extends State<SeeMoreExam> {
  final ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorAppBold,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Row(mainAxisSize: MainAxisSize.max, children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          'Lịch sử thi',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ]),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.exam
                          .map((history) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Scaffold(
                                                  appBar: AppBar(
                                                    title: Text("Kết quả"),
                                                    centerTitle: true,
                                                    backgroundColor: colorApp,
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
                                                          listeningScore: history[
                                                              'listening_score'],
                                                          readingScore: history[
                                                              'reading_score'],
                                                          screenshotController:
                                                              screenshotController,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                backgroundColor:
                                                                    colorApp),
                                                            onPressed:
                                                                () async {
                                                              var data = await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "Examinations")
                                                                  .doc(history[
                                                                      'exam_id'])
                                                                  .get();
                                                              if (!mounted) {
                                                                return;
                                                              }
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => FutureBuilder(
                                                                          future: getAllQuestionSnapshot(data),
                                                                          builder: (context, snapshot) {
                                                                            List<Map<String, dynamic>>
                                                                                data =
                                                                                [];

                                                                            if (snapshot.connectionState ==
                                                                                ConnectionState.waiting) {
                                                                              return Dialog.fullscreen(
                                                                                child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                                                                                  const Text('Questions are loading, please wait...'),
                                                                                  const SizedBox(height: 15),
                                                                                  SizedBox(
                                                                                    width: 200,
                                                                                    height: 5,
                                                                                    child: LinearProgressIndicator(),
                                                                                  )
                                                                                ]),
                                                                              );
                                                                            }
                                                                            if (snapshot.connectionState ==
                                                                                ConnectionState.done) {
                                                                              data = snapshot.data as List<Map<String, dynamic>>;
                                                                            }

                                                                            return ResultExam(
                                                                                testID: history['exam_id'],
                                                                                data: data,
                                                                                answer: convertListDynamicToListString(history['list_right_answers']),
                                                                                answerSelect: convertListDynamicToListString(history['list_answers']));
                                                                          })));
                                                            },
                                                            child: Text(
                                                              "Xem đáp án",
                                                              style: TextStyle(
                                                                  color: white),
                                                            )),
                                                      ),
                                                      TextButton.icon(
                                                          onPressed: () {
                                                            screenshotController
                                                                .capture(
                                                                    delay: Duration(
                                                                        milliseconds:
                                                                            10))
                                                                .then(
                                                                    (capturedImage) async {
                                                              //showCapturedWidget(
                                                              //  context,
                                                              //capturedImage!);
                                                              await Share.file(
                                                                  'Toeic Certificate',
                                                                  'certificate.png',
                                                                  capturedImage!,
                                                                  'image/png',
                                                                  text:
                                                                      'Awesome TOEIC Certificate');
                                                            }).catchError(
                                                                    (onError) {
                                                              print(onError);
                                                            });
                                                          },
                                                          icon: Icon(
                                                            Icons.share,
                                                            color: colorApp,
                                                          ),
                                                          label: Text(
                                                            "Chia sẻ kết quả với bạn bè",
                                                            style: TextStyle(
                                                                color: black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ))
                                                    ],
                                                  ),
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: black.withOpacity(0.2)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 20),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Image.asset(
                                                "assets/img/test.png",
                                                width: 45,
                                                height: 45),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(history['time'],
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: black
                                                                    .withOpacity(
                                                                        0.6))),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                                "Test ${history['exam_id']}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        black)),
                                                            Text(
                                                                'Số câu hỏi: ${history['list_answers'].length}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: black
                                                                        .withOpacity(
                                                                            0.8))),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                'Reading: ${history['reading_score']}/495',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: black
                                                                        .withOpacity(
                                                                            0.8)),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right),
                                                            Text(
                                                                'Listening: ${history['listening_score']}/495',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: black
                                                                        .withOpacity(
                                                                            0.8)),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right),
                                                            Text(
                                                                'Overall: ${history['listening_score'] + history['reading_score']}/990',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: black
                                                                        .withOpacity(
                                                                            0.8)),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                      child:
                                                          LinearProgressIndicator(
                                                        backgroundColor:
                                                            colorApp3,
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          (history['reading_score'] +
                                                                      history[
                                                                          'listening_score']) <
                                                                  200
                                                              ? red
                                                              : (history['reading_score'] +
                                                                          history[
                                                                              'listening_score']) <
                                                                      500
                                                                  ? orange
                                                                  : green,
                                                        ),
                                                        value: (history[
                                                                    'reading_score'] +
                                                                history[
                                                                    'listening_score']) /
                                                            990,
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  )),
                )
              ]),
        ));
  }
}
