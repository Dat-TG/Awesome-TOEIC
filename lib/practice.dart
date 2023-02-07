import "package:flutter/material.dart";

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  final List<String> lisTitle = [
    'Part 1',
    'Part 2',
    'Part 3',
    'Part 4',
    'Part 5',
    'Part 6',
    'Part 7'
  ];
  final List<String> lisDesc = [
    'Mô tả ảnh',
    'Hỏi & đáp',
    'Đoạn hội thoại',
    'Đoạn văn đơn',
    'Điền vào câu',
    'Điền vào đoạn',
    'Đọc hiểu đoạn văn'
  ];
  final List<String> lisImage = [
    './assets/img/1.jpg',
    './assets/img/2.jpg',
    './assets/img/3.jpg',
    './assets/img/4.jpg',
    './assets/img/5.jpg',
    './assets/img/6.jpg',
    './assets/img/7.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
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
            Expanded(
                flex: 1,
                child: BoxContainer(
                    title: lisTitle[0], img: lisImage[0], desc: lisDesc[0])),
            Expanded(
                flex: 1,
                child: BoxContainer(
                    title: lisTitle[1], img: lisImage[1], desc: lisDesc[1])),
            Expanded(
                flex: 1,
                child: BoxContainer(
                    title: lisTitle[2], img: lisImage[2], desc: lisDesc[2])),
            Expanded(
                flex: 1,
                child: BoxContainer(
                    title: lisTitle[3], img: lisImage[3], desc: lisDesc[3])),
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
            Expanded(
                flex: 1,
                child: BoxContainer(
                    title: lisTitle[4], img: lisImage[4], desc: lisDesc[4])),
            Expanded(
                flex: 1,
                child: BoxContainer(
                    title: lisTitle[5], img: lisImage[5], desc: lisDesc[5])),
            Expanded(
                flex: 1,
                child: BoxContainer(
                    title: lisTitle[6], img: lisImage[6], desc: lisDesc[6])),
            Expanded(flex: 1, child: SizedBox())
          ],
        ),
      ],
    );
  }
}

class BoxContainer extends StatelessWidget {
  final String title, img, desc;

  const BoxContainer(
      {super.key, required this.title, required this.img, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          img,
          width: 70,
          height: 70,
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
