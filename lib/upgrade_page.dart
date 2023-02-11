import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'constants.dart';

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
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      // Carousel slider auto
      CarouselSlider.builder(
        itemCount: listImage.length,
        options: CarouselOptions(
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                currentPos = index;
              });
            }),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return Image.asset(listImage[index],
              height: 150, width: 150, fit: BoxFit.fill);
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
              color: currentPos == index
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4),
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
                        padding: const EdgeInsets.fromLTRB(0, 20, 40, 0),
                        child: Column(
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
              height: 250,
              autoPlay: true,
              enableInfiniteScroll: true,
              viewportFraction: 0.4,
              enlargeCenterPage: true),
          items: [for (var img in listImage) Image.asset(img)]),

      // Text
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Khôi phục thanh toán',
            style: TextStyle(
                fontSize: 20,
                color: colorApp,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
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

class MyImageView extends StatelessWidget {
  String imgPath;

  MyImageView(this.imgPath);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset(imgPath),
        ));
  }
}
