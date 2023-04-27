import 'package:flutter/material.dart';
import 'package:toeic_app/test/app_bar.dart';
import 'package:toeic_app/test/review_details.dart';

import '../constants.dart';

class Result extends StatelessWidget {
  final String testID;
  final List<Map<String, dynamic>>? data;
  final List<String> answer, answerSelect;
  const Result(
      {super.key,
      required this.testID,
      required this.data,
      required this.answer,
      required this.answerSelect});

  @override
  Widget build(BuildContext context) {
    int listeningRate = 0,
        readingRate = 0,
        part1 = 0,
        part2 = 0,
        part3 = 0,
        part4 = 0,
        part5 = 0,
        part6 = 0,
        part7 = 0;
    for (int i = 0; i < 100; i++) {
      if (answer[i] == answerSelect[i]) {
        listeningRate++;
        if (i < 6) {
          part1++;
        } else if (i < 31) {
          part2++;
        } else if (i < 70) {
          part3++;
        } else {
          part4++;
        }
      }
      if (answer[i + 100] == answerSelect[i + 100]) {
        readingRate++;
        if (i < 30) {
          part5++;
        } else if (i < 46) {
          part6++;
        } else {
          part7++;
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Kết quả"),
        centerTitle: true,
        backgroundColor: colorApp,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
                child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Stack(
                      children: <Widget>[
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            value: listeningRate / 100,
                            backgroundColor: Colors.black26,
                            color: colorApp,
                          ),
                        ),
                        SizedBox(
                            width: 50,
                            height: 50,
                            child: Center(child: Text("$listeningRate%"))),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nghe hiểu",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Trả lời đúng: $listeningRate/100")
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: TextButton(
                                onPressed: () {
                                  curReadOrListen = ValueNotifier<int>(0);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReviewDetails(
                                              testID: testID,
                                              data: data,
                                              answer: answer,
                                              answerSelect: answerSelect)));
                                },
                                child: Text(
                                  "Chi tiết",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: colorApp,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                  color: colorApp,
                  thickness: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 100,
                      child: Text("Mô tả hình ảnh"),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 120,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.blue.shade100,
                        color: colorApp,
                        value: part1 / 6,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: Text("${(part1 / 6 * 100).round()}%"),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text("$part1/6"),
                        ),
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 100,
                      child: Text("Hỏi và đáp"),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 120,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.blue.shade100,
                        color: colorApp,
                        value: part2 / 25,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: Text("${(part2 / 25 * 100).round()}%"),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text("$part2/25"),
                        ),
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 100,
                      child: Text("Đoạn hội thoại"),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 120,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.blue.shade100,
                        color: colorApp,
                        value: part3 / 39,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: Text("${(part3 / 39 * 100).round()}%"),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text("$part3/39"),
                        ),
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 100,
                      child: Text("Bài nói chuyện ngắn"),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 120,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.blue.shade100,
                        color: colorApp,
                        value: part4 / 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: Text("${(part4 / 30 * 100).round()}%"),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text("$part4/30"),
                        ),
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
                child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Stack(
                      children: <Widget>[
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            value: readingRate / 100,
                            backgroundColor: Colors.black26,
                            color: colorApp,
                          ),
                        ),
                        SizedBox(
                            width: 50,
                            height: 50,
                            child: Center(child: Text("$readingRate%"))),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Đọc hiểu",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Trả lời đúng: $readingRate/100")
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: TextButton(
                                onPressed: () {
                                  curReadOrListen = ValueNotifier<int>(1);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReviewDetails(
                                              testID: testID,
                                              data: data,
                                              answer: answer,
                                              answerSelect: answerSelect)));
                                },
                                child: Text(
                                  "Chi tiết",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: colorApp,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                  color: colorApp,
                  thickness: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 100,
                      child: Text("Điền vào câu"),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 120,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.blue.shade100,
                        color: colorApp,
                        value: part5 / 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: Text("${(part5 / 30 * 100).round()}%"),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text("$part5/30"),
                        ),
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 100,
                      child: Text("Điền vào đoạn văn"),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 120,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.blue.shade100,
                        color: colorApp,
                        value: part6 / 16,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: Text("${(part6 / 16 * 100).round()}%"),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text("$part6/16"),
                        ),
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 100,
                      child: Text("Đọc hiểu đoạn văn"),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 120,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.blue.shade100,
                        color: colorApp,
                        value: part7 / 54,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: Text("${(part7 / 54 * 100).round()}%"),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text("$part7/54"),
                        ),
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                )
              ],
            )),
          )
        ],
      ),
    );
  }
}
