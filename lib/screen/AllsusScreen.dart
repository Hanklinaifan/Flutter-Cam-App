import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterproject_second/custom/BorderBox.dart';
import 'package:flutterproject_second/custom/Showup.dart';
import 'package:flutterproject_second/utils/constants.dart';
import 'package:flutterproject_second/utils/sample_data.dart';
import 'package:flutterproject_second/utils/widget_functions.dart';

class AllsusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addVerticalSpace(padding),
          Row(
            children: [
              //返回建
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
              Text("可疑人士總覽", style: themeData.textTheme.headline3),
            ],
          ),
          Expanded(
            child: OverflowBox(
              maxWidth: size.width,
              child: ListView.builder(
                itemCount: (IMG_DATA.length % 3 == 0)?(IMG_DATA.length.toDouble() / 3).toInt()
                    :(IMG_DATA.length.toDouble() / 3 + 1).toInt(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Item(itemData: IMG_DATA, i: index);
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
    int a = i * 3;
    int b = a + 1;
    int c = b + 1;
    int Navint = 0;
print(IMG_DATA.length);

    double photosize = (MediaQuery.of(context).size.width - 50) / 3;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navint = a;
              var itemimage = itemData[Navint]["image"];
              var itemtime = itemData[Navint]["time"];
              var itemplace = itemData[Navint]["place"];
              // print(Navint);
              Navigator.pushNamed(context, '/SusScreen',
                  arguments: {'image': itemimage,'time': itemtime,'place': itemplace,'index': Navint});
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              width: photosize,
              child: Image.asset(
                itemData[a]["image"],
                fit: BoxFit.cover,
              ),
            ),
          ),


          GestureDetector(
            onTap: () {

              if(b <= IMG_DATA.length-1){Navint = b;}

              else Navint = 0;
              var itemimage = itemData[Navint]["image"];
              var itemtime = itemData[Navint]["time"];
              var itemplace = itemData[Navint]["place"];
              // print(Navint);
              Navigator.pushNamed(context, '/SusScreen',
                  arguments: {'image': itemimage,'time': itemtime,'place': itemplace,'index': Navint});
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10, left: 5),
              width: photosize,
              child: (b <= IMG_DATA.length-1) ? Image.asset(
                itemData[b]["image"],
                fit: BoxFit.cover,
              ):SizedBox.shrink(),
            ),
          ),
          GestureDetector(
            onTap: () {

              if(c <= IMG_DATA.length-1){Navint = c;}
              else Navint =0;
              var itemimage = itemData[Navint]["image"];
              var itemtime = itemData[Navint]["time"];
              var itemplace = itemData[Navint]["place"];
              Navigator.pushNamed(context, '/SusScreen',
                  arguments: {'image': itemimage,'time': itemtime,'place': itemplace,'index':Navint});
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10, left: 5),
              width: photosize,
              child: (c<=IMG_DATA.length-1)?Image.asset(
                itemData[c]["image"],
                fit: BoxFit.cover,
              ):SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
