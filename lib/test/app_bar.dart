import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Transform.translate(
          offset: Offset(-25, 0),
          child: (Row(
            children: [
              if (widget.numAnswers != "")
                Column(
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
              if (widget.numAnswers != "")
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5),
                  child: Icon(Icons.info_outline),
                ),
              if (widget.numAnswers != "")
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  child: Icon(Icons.settings_outlined),
                ),
              if (widget.numAnswers != "")
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  child: Icon(Icons.view_carousel),
                ),
              if (widget.numAnswers != "") Icon(Icons.pause_circle_outline),
            ],
          ))),
      backgroundColor: colorApp,
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: InkWell(
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
        )
      ],
    );
  }
}
