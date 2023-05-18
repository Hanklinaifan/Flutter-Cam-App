import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterproject_second/custom/BorderBox.dart';
import 'package:flutterproject_second/custom/Showup.dart';
import 'package:flutterproject_second/utils/constants.dart';
import 'package:flutterproject_second/utils/sample_data.dart';
import 'package:flutterproject_second/utils/widget_functions.dart';

class SetmemberScreen extends StatefulWidget {
  @override
  _SetmemberScreen createState() => _SetmemberScreen();
}

class _SetmemberScreen extends State<SetmemberScreen> {

  @override
  Widget build(BuildContext context) {
//個人檔案視窗大小
    final Size size = MediaQuery
        .of(context)
        .size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;


    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return SafeArea(
    child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: sidePadding,
        child: Center(
          child: Container(
              width: 300,
              height: 500 ,
              decoration: BoxDecoration(
                color: COLOR_BACKGROUND,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500]!,
                    blurRadius: 10,
                    offset: Offset(10, 10),
                  ),
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.white,
                    offset: Offset(-10, -10),
                  ),
                ],
                //border: Border.all(color: COLOR_GREEN, width: 2),
                borderRadius: BorderRadius.circular(25),
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  addVerticalSpace(20),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360)),
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(360.0),
                      child: Image.asset(
                        theif,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  addVerticalSpace(20),
                  Text(
                    "Hank",
                    style: themeData.textTheme.headline1,
                  ),
                  ShowUp(
                    delay: 50,
                    child: Padding(
                      padding: sidePadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addVerticalSpace(25),
                          Text(
                            "Phone ： 098xxxxxxx",
                            style: themeData.textTheme.headline4,
                          ),
                          addVerticalSpace(15),
                          Text(
                            "Email：xxxxxxxx@gmail.com",
                            style: themeData.textTheme.headline4,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    ),
    );


  }
}

//家庭成員列表
class Item extends StatefulWidget {
  final dynamic itemData;
  final i;
  final bool isclick;
  final bool showPositioned;
  final VoidCallback ontap;
  const Item(
      {Key? key,
        required this.itemData,
        required this.isclick,
        required this.ontap,
        required this.showPositioned,
        required this.i})
      : super(key: key);
  @override
  _Item createState() => _Item();
}

class _Item extends State<Item> {

  @override
  Widget build(BuildContext context) {

    int num = widget.i+1;
    bool _isclick = widget.isclick;
    bool showPositioned = widget.showPositioned; //用來做延遲的

    final sidePadding = EdgeInsets.symmetric(horizontal: 25);
    final ThemeData themeData = Theme.of(context);



    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: sidePadding,
            child: Text(
              "成員$num：",
              style: themeData.textTheme.headline3,
            ),
          ),
          addVerticalSpace(20),
          Stack(children: [
//家庭成員人物按鈕
            Center(
              child: GestureDetector(
                onTap: widget.ontap,
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    width: 300,
                    height: _isclick ? 400 : 300,
                    decoration: BoxDecoration(
                      color: COLOR_BACKGROUND,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[500]!,
                          blurRadius: 10,
                          offset: Offset(10, 10),
                        ),
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.white,
                          offset: Offset(-10, -10),
                        ),
                      ],
                      //border: Border.all(color: COLOR_GREEN, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        addVerticalSpace(20),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(360)),
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(360.0),
                            child: Image.asset(
                              widget.itemData["image"],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        addVerticalSpace(20),
                        Text(
                          "Hank",
                          style: themeData.textTheme.headline1,
                        ),
                        _isclick? ShowUp(
                          delay: 50,
                          child: Padding(
                            padding: sidePadding,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                addVerticalSpace(25),
                                Text(
                                  "Phone ： 098xxxxxxx",
                                  style: themeData.textTheme.headline4,
                                ),
                                addVerticalSpace(15),
                                Text(
                                  "Email：xxxxxxxx@gmail.com",
                                  style: themeData.textTheme.headline4,
                                )
                              ],
                            ),
                          ),
                        ):SizedBox.shrink(),
                      ],
                    )
                ),
              ),
            ),
            showPositioned ? Positioned(
              top: 20,
              right: 70,
              child: ShowUp(
                delay: 5,
                child: GestureDetector(
                  onTap: (){
                    print("good");
                  },
                  child: Icon(Icons.menu,color: COLOR_GREEN,),
                ),
              ),
            ):SizedBox.shrink(),
          ]),
        ],
      ),
    );

  }
}

