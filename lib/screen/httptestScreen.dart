import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutterproject_second/custom/BorderBox.dart';
import 'package:flutterproject_second/utils/constants.dart';
import 'package:flutterproject_second/utils/http.dart';
import 'package:flutterproject_second/utils/sample_data.dart';
import 'package:flutterproject_second/utils/widget_functions.dart';
import 'package:flutterproject_second/screen/ModeScreen.dart';
import 'package:http/http.dart' as http;

class httptestScreen extends StatefulWidget {
  @override
  _httptestScreen createState() => _httptestScreen();
}

class _httptestScreen extends State<httptestScreen> {
  @override
  var ximage;
  var yimage;
  var txt;
  var isclick = false;
  Widget build(BuildContext context) {
    final Size mediasize = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);

    var control = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: ListView(
          children: [
            addVerticalSpace(padding),

            //設定以及選單鍵
            Padding(
              padding: sidePadding,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: BorderBox(
                  height: 50,
                  width: 50,
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: COLOR_GREEN,
                  ),
                ),
              ),
            ),
            addVerticalSpace(padding),

            //監視器畫面
            Padding(
              padding: sidePadding,
              child: Text("TESTING PAGE", style: themeData.textTheme.headline2),
            ),

            addVerticalSpace(10),
            Padding(
              padding: sidePadding,
              child: Column(
                children: [
                  //測試fileimage的擷取方式
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        width: 100,
                        height: 100,
                        child: ximage,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        width: 100,
                        height: 100,
                        child: yimage,
                      ),
                    ],
                  ),

                  OutlinedButton(
                    onPressed: () async {
                      txt = (await getResponse())["message"];
                      setState(() {
                        isclick = true;
                      });
                      print(txt);
                    },
                    child: Text("jsontest"),
                  ),

                  Text(isclick ? txt : " "),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 60,
                      width: mediasize.width,
                      child: OutlinedButton(
                        onPressed: () async {
                          var name = (await getName())[2];
                          setState(() {
                            yimage = Image.network(
                              getPic(name),
                              loadingBuilder: (context, child,
                                      loadingProgress) =>
                                  (loadingProgress == null)
                                      ? child
                                      : SizedBox(
                                          width: 10,
                                          height: 10,
                                          child: CircularProgressIndicator()),
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.network(
                                      'https://cdn.pixabay.com/photo/2014/03/24/17/21/wrong-295503_1280.png'),
                            );
                          });
                          print("getpicname: $name");
                        },
                        child: Text("getpicname"),
                      )),
                  addVerticalSpace(padding),
                  Container(
                      height: 60,
                      width: mediasize.width,
                      child: OutlinedButton(
                        onPressed: () async {
                          var name = (await getName())[1];
                          setState(() {
                            yimage = Image.network(
                              getPic(name),
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child,
                                      loadingProgress) =>
                                  (loadingProgress == null)
                                      ? child
                                      : SizedBox(
                                          width: 10,
                                          height: 10,
                                          child: CircularProgressIndicator()),
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.network(
                                      'https://cdn.pixabay.com/photo/2014/03/24/17/21/wrong-295503_1280.png'),
                            );
                          });
                        },
                        child: Text("get cat"),
                      )),
                  addVerticalSpace(padding),
                  Container(
                    height: 60,
                    width: mediasize.width,
                    child: OutlinedButton(
                      onPressed: () async {
                        var temp = (await HTTP_DATA)[0]['image'];
                        var getaj = (await getAllJson());
                        setState(() {
                          ximage = temp;
                          ximage = Image.memory(
                            base64Decode(ximage),
                            fit: BoxFit.cover,
                          );
                        });
                        print((await HTTP_DATA)[0]['Time']);
                        print("getAllJson: $getaj");
                      },
                      child: Text("getalljson test"),
                    ),
                  ),
                  addVerticalSpace(padding),
                  Container(
                    height: 60,
                    width: mediasize.width,
                    child: OutlinedButton(
                      onPressed: () {
                        SocketConnect();
                      },
                      child: Text("websocket test (not good for now)"),
                    ),
                  ),
                  // Container(
                  //     height: 60,
                  //     width: mediasize.width,
                  //     child: StreamBuilder(
                  //       stream: channel.stream,
                  //       builder: (context, snapshot) {
                  //         return TextFormField(
                  //           controller: control,
                  //           decoration: InputDecoration(labelText: 'to server'),
                  //           onEditingComplete: () {
                  //             Socketadd(control.text);
                  //             FocusScope.of(context).unfocus();
                  //           },
                  //         );
                  //       }
                  //     )),
                ],
              ),
            ),

            addVerticalSpace(50),
            Padding(
              padding: sidePadding,
              child: Text("其他出現時間", style: themeData.textTheme.headline3),
            ),
            addVerticalSpace(padding),
            Container(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: IMG_DATA.length,
                itemBuilder: (context, index) {
                  return Item(itemData: IMG_DATA[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//選擇監視器畫面按鈕
//之後要在這裡設定i，i為攝影機號碼
class Choiseroom extends StatelessWidget {
  final String text;
  const Choiseroom({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final int i = 1; //在此設定攝影機號碼
    final ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), color: COLOR_GREEN),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      margin: const EdgeInsets.only(left: 25),
      child: Text(text + " (攝影機 $i)", style: themeData.textTheme.headline5),
    );
  }
}

//嫌疑人畫面
class Item extends StatelessWidget {
  final dynamic itemData;

  const Item({Key? key, required this.itemData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.asset(
            itemData["image"],
            fit: BoxFit.cover,
          )),
    );
  }
}
