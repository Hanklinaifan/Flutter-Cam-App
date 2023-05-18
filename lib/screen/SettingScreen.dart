import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterproject_second/custom/BorderBox.dart';
import 'package:flutterproject_second/custom/Showup.dart';
import 'package:flutterproject_second/utils/constants.dart';
import 'package:flutterproject_second/utils/sample_data.dart';
import 'package:flutterproject_second/utils/widget_functions.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          addVerticalSpace(padding + 10),
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                //返回建
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.keyboard_backspace,
                      color: Colors.brown,
                    ),
                  ),
                ),
                Text("編輯攝影機", style: themeData.textTheme.headline2),
              ],
            ),
          ),
          Padding(
            padding: sidePadding,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/AddCamScreen");
                },
                child: Text(
                  "新增攝影機",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: COLOR_GREEN,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: OverflowBox(
              maxWidth: size.width,
              child: ListView.builder(
                itemCount: (ROOM_DATA.length % 2 == 0)
                    ? (ROOM_DATA.length.toDouble() / 2).toInt()
                    : (ROOM_DATA.length.toDouble() / 2 + 1).toInt(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Item(itemData: ROOM_DATA, i: index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  final dynamic itemData;
  final int i;

  const Item({Key? key, required this.itemData, required this.i})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int a = i * 2;
    int b = a + 1;
    int Navint = 0;
    print(ROOM_DATA.length);
    print(b);

    double photosize = (MediaQuery.of(context).size.width - 50) / 2;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navint = a;
              Navigator.pushNamed(
                  context, "/CamScreen",
                  arguments: {'index': Navint,}
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: COLOR_GREY),
              ),
              margin: EdgeInsets.only(bottom: 10),
              width: photosize,
              height: photosize,
              child: Stack(
                children: [
                  Center(child: Text(ROOM_DATA[a]['room']!)),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (b <= ROOM_DATA.length - 1) {
                Navint = b;
              } else
                Navint = 0;

              Navigator.pushNamed(
                  context, "/CamScreen",
                  arguments: {'index': Navint,}
              );
            },
            child: (b <= ROOM_DATA.length - 1) ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: COLOR_GREY),
              ),
              margin: EdgeInsets.only(bottom: 10, left: 5),
              width: photosize,
              height: photosize,
              child:  Stack(
                children: [
                  Center(child: Text(ROOM_DATA[b]['room']!)),
                ],
              ),
            ):SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
