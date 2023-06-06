import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterproject_second/custom/BorderBox.dart';
import 'package:flutterproject_second/custom/Showup.dart';
import 'package:flutterproject_second/utils/SusData.Dart.dart';
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
              child:FutureBuilder(
                future: getAllSus(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  var SUS_DATA = snapshot.data;
                  //print(getSusPic(SUS_DATA[0]["videopath"]));
                  SUS_DATA.sort((a,b){
                    var adate = a['appear_time'].toString();
                    var bdate = b['appear_time'].toString();
                    return bdate.compareTo(adate);
                  });
                  if(SUS_DATA == null){
                    return Center(child: Text('尚無可疑人士'));
                  }
                  return ListView.builder(
                    itemCount: (SUS_DATA.length % 3 == 0)?(SUS_DATA.length.toDouble() / 3).toInt()
                        :(SUS_DATA.length.toDouble() / 3 + 1).toInt(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Item(itemData: SUS_DATA, i: index);
                    },
                  );
                }
              }),

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


    double photosize = (MediaQuery.of(context).size.width - 50) / 3;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navint = a;
              var itemimage = getSusPic(itemData[Navint]["imagepath"]);
              var itemtime = itemData[Navint]["appear_time"];
              // var itemplace = itemData[Navint]["place"];
              var itemplace = itemData[Navint]["place"];
              var itemvid = getSusVid(itemData[Navint]["videopath"]);
              // print(Navint);
              Navigator.pushNamed(context, '/SusScreen',
                  arguments: {'image': itemimage,'time': itemtime,'place': itemplace,'index': Navint, 'video': itemvid});
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              width: photosize,
              height: photosize,
              child: Image.network(
                getSusPic(itemData[a]["imagepath"]),
                fit: BoxFit.cover,
              ),
            ),
          ),


          GestureDetector(
            onTap: () {

              if(b <= itemData.length-1){Navint = b;}

              else Navint = 0;
              var itemimage = getSusPic(itemData[b]["imagepath"]);
              var itemtime = itemData[Navint]["appear_time"];
              var itemplace = itemData[Navint]["place"];
              // print(Navint);
              var itemvid = getSusVid(itemData[b]["videopath"]);
              Navigator.pushNamed(context, '/SusScreen',
                  arguments: {'image': itemimage,'time': itemtime,'place': itemplace,'index': Navint,'video': itemvid});
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10, left: 5),
              width: photosize,
              height: photosize,
              child: (b <= itemData.length-1) ? Image.network(
    getSusPic(itemData[b]["imagepath"]),
    fit: BoxFit.cover,
    ):SizedBox.shrink(),
            ),
          ),
          GestureDetector(
            onTap: () {

              if(c <= itemData.length-1){Navint = c;}
              else Navint =0;
              var itemimage = getSusPic(itemData[c]["imagepath"]);
              var itemtime = itemData[Navint]["appear_time"];
              var itemplace = itemData[Navint]["place"];
              var itemvid = getSusVid(itemData[c]["videopath"]);

              Navigator.pushNamed(context, '/SusScreen',
                  arguments: {'image': itemimage,'time': itemtime,'place': itemplace,'index':Navint,'video': itemvid});
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10, left: 5),
              width: photosize,
              height: photosize,
              child: (c<=itemData.length-1)?Image.network(
    getSusPic(itemData[c]["imagepath"]),
    fit: BoxFit.cover,
    ):SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
