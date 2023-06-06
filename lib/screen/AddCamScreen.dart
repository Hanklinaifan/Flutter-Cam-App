import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject_second/screen/httptestScreen.dart';
import 'package:flutterproject_second/utils/CamData.dart';
import 'package:flutterproject_second/utils/constants.dart';
import 'package:flutterproject_second/utils/sample_data.dart';
import 'package:flutterproject_second/utils/widget_functions.dart';
import 'package:flutterproject_second/utils/httptest.dart';

final double padding = 25;
final sidePadding = EdgeInsets.symmetric(horizontal: padding, vertical: 0);

class AddCamScreen extends StatefulWidget {
  @override
  _AddCamScreen createState() => _AddCamScreen();

}

class _AddCamScreen extends State<AddCamScreen> {

  final _namecontroll =TextEditingController();
  final _urlcontroll =TextEditingController();

  dispose(){
    _namecontroll.dispose();
    _urlcontroll.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {



    final Size mediasize = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    print(mediasize);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
        backgroundColor: COLOR_BACKGROUND[100],
        body: Container(
          width: mediasize.width,
          height: mediasize.height,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(padding + 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.keyboard_backspace,
                            color: Colors.brown,
                          )),
                      addHorizontalSpace(10),
                      Text(
                        "新增監視器",
                        style: themeData.textTheme.headline2,
                      )
                    ],
                  ),
                ),
                addVerticalSpace(10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    children: [
                      Container(
                        width: mediasize.width,
                        height: (mediasize.width - 20) * .5625,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: COLOR_GREY.withOpacity(.5),
                            )),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Center(
                              child: Icon(
                            Icons.add,
                          )),
                        ),
                      ),
                      addVerticalSpace(10),
                    ],
                  ),
                ),
                Padding(
                  padding: sidePadding,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: COLOR_GREY),
                      borderRadius: BorderRadius.circular(25)
                    ),
                    margin: EdgeInsets.symmetric(vertical: padding),
                    width: mediasize.width,
                    height: 200,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: padding),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextField(
                              controller: _namecontroll,
                                decoration: InputDecoration(
                                  labelText: "監視器名稱(ex:客廳)",
                                )),
                            addVerticalSpace(padding),
                            TextField(
                              controller: _urlcontroll,
                                decoration: InputDecoration(
                                  labelText: "URL",
                                )),
                            addVerticalSpace(5),
                            Text("如何確認我的URL?",style: TextStyle(fontSize: 12,color: COLOR_LIGHTBROWN),)


                            //Text("Email：",style: themeData.textTheme.headline3,textAlign: TextAlign.start,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                    width:500,
                    height: 50,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.brown,
                      ),
                      onPressed: () async {
                        print(_urlcontroll.text+" "+_namecontroll.text);
                        addCam(_namecontroll.text, _urlcontroll.text);
                        //Navigator.pop(context);
                      },
                      child: Text("確認新增"),
                    )
                )
              ],
            ),
          ),
        ));
  }
}

//選擇監視器畫面按鈕
//之後要在這裡設定i，i為攝影機號碼
class Choiseroom extends StatelessWidget {
  final dynamic itemdata;
  const Choiseroom({Key? key, required this.itemdata}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //在此設定攝影機號碼
    final ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), color: COLOR_ROOM),
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
      margin: const EdgeInsets.only(left: 25),
      child: Text(itemdata["room"], style: themeData.textTheme.headline5),
    );
  }
}

//嫌疑人畫面
class Item extends StatelessWidget {
  final dynamic itemData;

  const Item({Key? key, required this.itemData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String itemimage = itemData["image"];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/SusScreen',
              arguments: {'image': itemimage});
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.asset(
            itemData["image"],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
