import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';

class AppBarPractice extends StatefulWidget implements PreferredSizeWidget {
  final String numAnswers;
  final List<String> answers, ansTrans;

  const AppBarPractice(
      {super.key,
      required this.numAnswers,
      required this.ansTrans,
      required this.answers});

  @override
  State<AppBarPractice> createState() => _AppBarPracticeState();

  @override
  Size get preferredSize => Size(15, 60);
}

class _AppBarPracticeState extends State<AppBarPractice> {
  PageController controller = PageController();
  int _curr = 0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Transform.translate(
          offset: Offset(-25, 0),
          child: (Row(
            children: [
              Column(
                children: [
                  Text(
                    'Câu ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.numAnswers,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
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
          child: InkWell(
            onTap: () {
              showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return DraggableScrollableSheet(
                        expand: false,
                        initialChildSize: .4,
                        minChildSize: .4,
                        maxChildSize: .6,
                        builder: (BuildContext context,
                            ScrollController scrollController) {
                          return Explanation(
                              ansTrans: listDirectionVn,
                              answers: listDirectionEng);
                        });
                  });
            },
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
          ),
        )
      ],
    );
  }
}

// -------------------Explanation frame--------------------------------------
class Explanation extends StatefulWidget {
  final List<String> answers, ansTrans;

  const Explanation({
    super.key,
    required this.ansTrans,
    required this.answers,
  });

  @override
  State<Explanation> createState() => _ExplanationState();
}

class _ExplanationState extends State<Explanation> {
  PageController controller = PageController();
  int _curr = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: colorApp,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      height: 300,
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
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _curr = 0;
                        });
                        controller.jumpToPage(0);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 < 300
                            ? 100
                            : MediaQuery.of(context).size.width / 2 - 100,
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                        margin: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                            border: _curr == 0
                                ? Border(
                                    bottom: BorderSide(color: orange, width: 3))
                                : Border()),
                        child: Text(
                          'Giải thích',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _curr == 0 ? orange : white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print(1);
                        setState(() {
                          _curr = 1;
                        });
                        controller.jumpToPage(1);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 < 300
                            ? 100
                            : MediaQuery.of(context).size.width / 2 - 100,
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                        margin: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                            border: _curr == 1
                                ? Border(
                                    bottom: BorderSide(color: orange, width: 3))
                                : Border()),
                        child: Text(
                          'Lời dịch',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _curr == 1 ? orange : white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel,
                        color: white,
                      ),
                    )
                  ]),
            ),
            Container(
              height: 250,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: PageView(
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (number) {
                    setState(() {
                      _curr = number;
                    });
                  },
                  children: [
                    SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0;
                                i <
                                    (widget.answers.length > 4
                                        ? 4
                                        : widget.answers.length);
                                i++)
                              Text(
                                '${answersOption[i]}. ${widget.answers[i]}',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.justify,
                              ),
                          ]),
                    ),
                    SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0;
                                i <
                                    (widget.ansTrans.length > 4
                                        ? 4
                                        : widget.ansTrans.length);
                                i++)
                              Text(
                                '${answersOption[i]}. ${widget.ansTrans[i]}',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.justify,
                              ),
                          ]),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
