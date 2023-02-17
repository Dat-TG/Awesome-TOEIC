// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class UpgradePage extends StatefulWidget {
  const UpgradePage({super.key});

  @override
  State<UpgradePage> createState() => _UpgradePageTestState();
}

class _UpgradePageTestState extends State<UpgradePage> {
  int currentPos = 0;
  List<int> sales = [10, 20, 30, 50];
  // Data compare normal and premium user
  List<String> attributes = [
    "Luyện tập part 1, 2, 5",
    "Học lý thuyết TOEIC",
    "Luyện tập FULL 7 dạng bài",
    "Sử dụng ngoại tuyến",
    "Loại bỏ quảng cáo",
    "Mở khóa để thi thử"
  ];
  List<int> normalUser = [1, 1, 0, 0, 0, 4];
  List<int> premiumUser = [1, 1, 1, 1, 1, 30];

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = (prefs.getBool('DarkMode') ?? false);
      changeColorByTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
        child: Column(children: [
      // Carousel slider auto
      CarouselSlider.builder(
        itemCount: listImage.length,
        options: CarouselOptions(
          height: 250,
          autoPlay: true,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            setState(() {
              currentPos = index;
            });
          },
        ),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return AdsContainer(
              listImage[index], listTitle[index], listDirectionEng[index]);
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: listImage.map((url) {
          int index = listImage.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentPos == index ? colorApp : colorApp3,
            ),
          );
        }).toList(),
      ),

      // Best sale prices
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorBox,
                    boxShadow: [
                      BoxShadow(
                        color: colorBoxShadow,
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 8, 10, 8),
                            decoration: BoxDecoration(
                                color: colorApp,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: Text('Best Choice',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 20, 0, 0),
                            child: Text(
                              'Trọn đời',
                              style: TextStyle(
                                  color: colorApp,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(
                                    color: colorApp,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  '-50%',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: Text(
                                '749000'.toVND(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: colorApp,
                                    fontSize: 16),
                              ),
                            ),
                            Text('1498000'.toVND(),
                                style: TextStyle(
                                    color: colorApp5,
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),

      // Package prices
      CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enableInfiniteScroll: false,
            viewportFraction: 0.5,
            enlargeCenterPage: true,
          ),
          items: [
            for (int i = 0; i < listTitle.length; i++)
              SalesPackageContainer(listTitle[i], 397000, 397000, 397000, 50)
          ]),

      // Text
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: Text(
              'Khôi phục thanh toán',
              style: TextStyle(
                  fontSize: 19,
                  color: colorApp,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
          )
        ],
      ),

      // Table: compare with normal and premium user
      Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: DataTable(
            columnSpacing: 0,
            horizontalMargin: 0,
            dividerThickness: 0.0,
            showBottomBorder: false,
            columns: [
              DataColumn(
                  label: SizedBox(
                      width: width * .5,
                      child: Text(
                        "",
                        textAlign: TextAlign.center,
                      ))),
              DataColumn(
                  label: SizedBox(
                      width: width * .2,
                      child: Text(
                        "Miễn phí",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ))),
              DataColumn(
                  label: SizedBox(
                      width: width * .2,
                      child: Text(
                        "Premium",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )))
            ],
            rows: [
              for (int i = 0; i < attributes.length; i++)
                DataRow(cells: [
                  DataCell(Text(
                    attributes[i],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
                  normalUser[i] == 1
                      ? DataCell(Center(
                          child: Icon(
                          Icons.check,
                          color: colorApp,
                          size: 27,
                        )))
                      : (normalUser[i] == 0
                          ? DataCell(Center(
                              child: Icon(
                              Icons.lock,
                              color: colorApp,
                              size: 23,
                            )))
                          : DataCell(Center(
                              child: Text(
                                "${normalUser[i]}",
                                style: TextStyle(
                                    color: colorApp,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))),
                  premiumUser[i] == 1
                      ? DataCell(Center(
                          child: Icon(
                          Icons.check,
                          color: colorApp,
                          size: 27,
                        )))
                      : (premiumUser[i] == 0
                          ? DataCell(Center(
                              child: Icon(
                              Icons.lock,
                              color: colorApp,
                              size: 23,
                            )))
                          : DataCell(Center(
                              child: Text(
                                "${premiumUser[i]}",
                                style: TextStyle(
                                    color: colorApp,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))),
                ]),
            ]),
      ),

      // Respone to user
      Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Phản hồi người dùng',
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            )
          ],
        ),
      ),

      // List: Respone to user
      // Package prices
      CarouselSlider(
          options: CarouselOptions(
              height: 190,
              enableInfiniteScroll: false,
              viewportFraction: 0.7,
              enlargeCenterPage: true),
          items: [
            for (int i = 0; i < listTitle.length; i++)
              ReviewUserContainer(listTitle[i], listDirectionEng[i], i % 5 + 1)
          ]),
      SizedBox(
        height: 10,
      )
    ]));
  }
}

class AdsContainer extends StatelessWidget {
  String imgPath, title, desc;

  AdsContainer(this.imgPath, this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: colorBox,
          boxShadow: [
            BoxShadow(
              color: colorBoxShadow,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
          child: Column(
            children: [
              Image.asset(
                imgPath,
                fit: BoxFit.cover,
                width: 130,
                height: 130,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 40,
                child: Text(
                  desc,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SalesPackageContainer extends StatelessWidget {
  String title;
  int total, oldPrice, newPrice, percent;

  SalesPackageContainer(
      this.title, this.total, this.oldPrice, this.newPrice, this.percent);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 6, bottom: 6),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: colorBox,
        boxShadow: [
          BoxShadow(
            color: colorBoxShadow,
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
        child: Stack(children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 21,
                  color: colorApp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text('$total'.toVND(),
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Text("${'$oldPrice'.toVND()}/tháng",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough)),
              Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 5),
                child: Divider(
                  height: 10,
                  thickness: 2,
                ),
              ),
              Text("${'$newPrice'.toVND()}/tháng",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/img/${percent}p.png',
              width: 50,
              height: 50,
            ),
          )
        ]),
      ),
    );
  }
}

class ReviewUserContainer extends StatelessWidget {
  String title, comment;
  int vote;

  ReviewUserContainer(this.title, this.comment, this.vote);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 6, bottom: 6),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: colorBox,
        boxShadow: [
          BoxShadow(
            color: colorBoxShadow,
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person_pin,
                  color: colorApp,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                for (int i = 0; i < vote; i++)
                  Icon(Icons.star, color: yellowBold, size: 16),
                for (int i = 0; i < 5 - vote; i++)
                  Icon(Icons.star_border, color: yellowBold, size: 16)
              ],
            ),
            Text(
              comment,
              style: TextStyle(
                fontSize: 14,
                overflow: TextOverflow.ellipsis,
              ),
              textAlign: TextAlign.justify,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
