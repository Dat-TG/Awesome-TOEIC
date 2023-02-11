// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'constants.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class UpgradePage extends StatefulWidget {
  const UpgradePage({super.key});

  @override
  State<UpgradePage> createState() => _UpgradePageTestState();
}

class _UpgradePageTestState extends State<UpgradePage> {
  int currentPos = 0;

  @override
  Widget build(BuildContext context) {
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
                    color: Color.fromARGB(255, 252, 251, 251),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
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
                                '749.000 đ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: colorApp,
                                    fontSize: 16),
                              ),
                            ),
                            Text('1.498.000 đ',
                                style: TextStyle(
                                    color: colorApp5,
                                    decoration: TextDecoration.lineThrough,
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
            height: 180,
            autoPlay: true,
            enableInfiniteScroll: true,
            viewportFraction: 0.5,
            enlargeCenterPage: true,
          ),
          items: [
            for (int i = 0; i < listTitle.length; i++)
              SalesPackageContainer(listTitle[i], 397000, 397000, 397000, 30)
          ]),

      // Text
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Text(
              'Khôi phục thanh toán',
              style: TextStyle(
                  fontSize: 20,
                  color: colorApp,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
          )
        ],
      ),

      // Table: compare with normal and premium user
      DataTable(columns: [
        DataColumn(label: Text("")),
        DataColumn(label: Text("Miễn phí")),
        DataColumn(label: Text("Premium"))
      ], rows: [
        DataRow(cells: [
          DataCell(Text("Luyện tập part 1,2,5")),
          DataCell(Icon(Icons.check)),
          DataCell(Icon(Icons.check)),
        ]),
        DataRow(cells: [
          DataCell(Text("Luyện tập part 1,2,5")),
          DataCell(Icon(Icons.check)),
          DataCell(Icon(Icons.check)),
        ]),
        DataRow(cells: [
          DataCell(Text("Luyện tập part 1,2,5")),
          DataCell(Icon(Icons.check)),
          DataCell(Icon(Icons.check)),
        ])
      ]),

      // Respone to user
      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Phản hồi người dùng',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),

      // List: Respone to user
      // Package prices
      CarouselSlider(
          options: CarouselOptions(
              height: 250,
              autoPlay: true,
              enableInfiniteScroll: false,
              viewportFraction: 0.4,
              enlargeCenterPage: true),
          items: [for (var img in listImage) Image.asset(img)]),
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
                  style: TextStyle(color: Colors.black38),
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
        color: Color.fromARGB(255, 252, 251, 251),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
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
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Text("${'$oldPrice'.toVND()}/tháng",
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough)),
              Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 5),
                child: Divider(
                  height: 10,
                  color: Colors.black,
                ),
              ),
              Text("${'$newPrice'.toVND()}/tháng",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black45,
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
