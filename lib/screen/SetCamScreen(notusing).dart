import 'package:flutter/material.dart';
import 'package:flutterproject_second/custom/BorderBox.dart';
import 'package:flutterproject_second/custom/MyButton.dart';
import 'package:flutterproject_second/utils/constants.dart';
import 'package:flutterproject_second/utils/sample_data.dart';
import 'package:flutterproject_second/utils/widget_functions.dart';
import 'package:flutterproject_second/custom/Showup.dart';

class SetCamScreen extends StatefulWidget {
  @override
  _SetCamScreen createState() => _SetCamScreen();
}

class _SetCamScreen extends State<SetCamScreen> {
  @override
  Widget build(BuildContext context) {
    final Size mediasize = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Container(
          width: mediasize.width,
          height: mediasize.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(padding),
              //返回建
              Padding(
                padding: sidePadding,
                child: Text("攝影機設定", style: themeData.textTheme.headline2),
              ),

              Padding(
                padding: sidePadding,
                child: Divider(
                  height: padding,
                  color: Colors.brown,
                ),
              ),
              addVerticalSpace(20),
              Padding(
                padding: sidePadding,
                child: Column(
                  children: [
                    SizedBox(
                      width: mediasize.width,
                      height: mediasize.height / 10,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/AddCamScreen');
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "新增攝影機",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    addVerticalSpace(padding),
                    SizedBox(
                      width: mediasize.width,
                      height: mediasize.height / 10,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/SettingScreen');
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "編輯攝影機",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    addVerticalSpace(padding),
                    SizedBox(
                      width: mediasize.width,
                      height: mediasize.height / 10,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/ModeScreen');
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "變更攝影機模式",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    addVerticalSpace(padding),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
