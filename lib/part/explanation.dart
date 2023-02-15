import "package:flutter/material.dart";
import "package:toeic_app/constants.dart";

class Explanation extends StatefulWidget {
  final List<String> answers, ansTrans;
  final bool isShow;
  final Function(bool) cancelShow;
  const Explanation(
      {super.key,
      required this.ansTrans,
      required this.answers,
      required this.cancelShow,
      required this.isShow});

  @override
  State<Explanation> createState() => _ExplanationState();
}

class _ExplanationState extends State<Explanation> {
  PageController controller = PageController();
  int _curr = 0;
  late bool show;

  @override
  void initState() {
    super.initState();
    show = false;
  }

  @override
  void didUpdateWidget(covariant Explanation oldWidget) {
    super.didUpdateWidget(oldWidget);
    show = widget.isShow;
  }

  @override
  Widget build(BuildContext context) {
    return show
        ? Container(
            height: 200,
            decoration: BoxDecoration(
                color: colorApp,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorAppBold,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
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
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            margin: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                                border: _curr == 0
                                    ? Border(
                                        bottom:
                                            BorderSide(color: orange, width: 5))
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
                            setState(() {
                              _curr = 1;
                            });
                            controller.jumpToPage(1);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 < 300
                                ? 100
                                : MediaQuery.of(context).size.width / 2 - 100,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            margin: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                                border: _curr == 1
                                    ? Border(
                                        bottom:
                                            BorderSide(color: orange, width: 5))
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
                            widget.cancelShow(false);
                          },
                          child: Icon(
                            Icons.cancel,
                            color: white,
                          ),
                        )
                      ]),
                ),
                Container(
                  constraints: BoxConstraints(minHeight: 50, maxHeight: 150),
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
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
                                    style: TextStyle(fontSize: 18),
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
                                    style: TextStyle(fontSize: 18),
                                  ),
                              ]),
                        ),
                      ]),
                )
              ],
            ),
          )
        : SizedBox.shrink();
  }
}
