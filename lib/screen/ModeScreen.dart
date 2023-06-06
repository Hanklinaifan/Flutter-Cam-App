import 'package:flutter/material.dart';
import 'package:flutterproject_second/custom/BorderBox.dart';
import 'package:flutterproject_second/custom/MyButton.dart';
import 'package:flutterproject_second/screen/LandingScreen.dart';
import 'package:flutterproject_second/utils/CamData.dart';
import 'package:flutterproject_second/utils/constants.dart';
import 'package:flutterproject_second/utils/sample_data.dart';
import 'package:flutterproject_second/utils/widget_functions.dart';
import 'package:flutterproject_second/custom/Showup.dart';

class ModeScreen extends StatefulWidget {
  @override
  _ModeScreen createState() => _ModeScreen();
}

class _ModeScreen extends State<ModeScreen> {
  List<bool> _isElvated = [false, false, false, false,false];
  List<bool> _isElvated2 = [false, false, false, false, false];
  List<bool> _isMode = [false, false, false, false, false];




  @override
  Widget build(BuildContext context) {
    //mode的狀態歸0
    dynamic modeinfo = ModalRoute.of(context)?.settings.arguments;
    String roomname = modeinfo['room'];
    print(modeinfo['mode']);
    var mode = modeinfo['mode'];
    setState(() {
      if(mode == 'normal'){
        _isMode[0] = true;
      }
      else if(mode == 'room'){
        _isMode[1] = true;
      }
      else if(mode == 'outdoor'){
        _isMode[2] = true;
      }
      else{
        _isMode[3] = true;
      }
    });
    print(_isMode);

    final Size mediasize = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    double ContainerHeight = mediasize.height / 2;


    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        width: mediasize.width,
        height: mediasize.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(padding+10),
            //返回建
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
                    ),
                  ),
                  addHorizontalSpace(10),
                  Text("模式選擇：$roomname", style: themeData.textTheme.displayMedium),
                ],
              ),
            ),

            //選擇攝影機
            addVerticalSpace(padding),
            Container(
              height: 50,
              child: FutureBuilder(
                future: getAllCam(),
                builder: (context,AsyncSnapshot snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Choiseroom(itemdata: snapshot.data[index]);
                      },
                    );
                  }
                  else{return Center(child: CircularProgressIndicator(),);}
                },
              )
            ),

            Padding(
              padding: sidePadding,
              child: Divider(
                height: padding,
                color: COLOR_GREEN,
              ),
            ),

            //按鈕選項
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child:  ListView(
                  children: <Widget>[
                    ModeBotton(
                      text: "一般模式",
                      img: "assets/images/normal_mode.jpg",
                      widget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("一般的攝影機，無須設定成員，無臉部\n辨識系統",style: TextStyle(
                              color: Colors.brown.withOpacity(.6)
                          ),),
                          addVerticalSpace(10),
                          Text("功能："),
                          addVerticalSpace(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.highlight_off_outlined,
                                color: Colors.grey,
                                size: 20,
                              ),
                              addHorizontalSpace(2),
                              Text(
                                "可疑人士通知",
                                style: TextStyle(color: COLOR_GREY),
                              ),
                            ],
                          ),
                          addVerticalSpace(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.highlight_off_outlined,
                                color: Colors.grey,
                                size: 20,
                              ),
                              addHorizontalSpace(2),
                              Text(
                                "臉部辨識",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ontap: () {

                        this.setState(() {
                          for (int i = 0; i < _isElvated.length; i++) {
                            if (i == 0) {
                              continue;
                            } else {
                              _isElvated[i] = false;
                              _isElvated2[i] = false;
                            }
                          }
                        });
                        _isElvated[0] = !_isElvated[0];


                        Future.delayed(
                            Duration(milliseconds: _isElvated[0] ? 250 : 0),
                                () {
                              this.setState(() {
                                _isElvated2[0] = _isElvated[0];
                              });
                            });
                      },
                      modeontap: () {
                        modeinfo['mode'] = 'normal';
                        this.setState(() {
                          for (int i = 0; i < _isMode.length; i++) {
                            if (i == 0) {
                              continue;
                            } else {
                              _isMode[i] = false;
                            }
                          }
                          _isMode[0] = !_isMode[0];
                        });
                        ChangeCamMode(roomname, 'normal');

                        print("ismode: $_isMode");
                      },
                      isclick: _isElvated[0],
                      isclick2: _isElvated2[0],
                      ismode: _isMode[0],
                    ),
                    ModeBotton(
                      text: "室內模式",
                      img: "assets/images/room_mode.jpg",
                      widget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("依照成員的臉部進行辨識，若有不認識\n的臉孔出現會馬上進行通知。",style: TextStyle(
                              color: Colors.brown.withOpacity(.6)
                          ),),
                          addVerticalSpace(10),
                          Text("功能："),
                          addVerticalSpace(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: COLOR_GREEN,
                                size: 20,
                              ),
                              addHorizontalSpace(2),
                              Text(
                                "可疑人士通知",
                                style: TextStyle(color: COLOR_GREEN),
                              ),
                            ],
                          ),
                          addVerticalSpace(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: COLOR_GREEN,
                                size: 20,
                              ),
                              addHorizontalSpace(2),
                              Text(
                                "臉部辨識",
                                style: TextStyle(color: COLOR_GREEN),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ontap: () {

                        this.setState(() {
                          for (int i = 0; i < _isElvated.length; i++) {
                            if (i == 1) {
                              continue;
                            } else {
                              _isElvated[i] = false;
                              _isElvated2[i] = false;
                            }
                          }
                        });

                        _isElvated[1] = !_isElvated[1];
                        Future.delayed(
                            Duration(milliseconds: _isElvated[1] ? 250 : 0),
                                () {
                              this.setState(() {
                                _isElvated2[1] = _isElvated[1];
                              });
                            });
                      },
                      modeontap: () {
                        modeinfo['mode'] = 'room';
                        this.setState(() {
                          for (int i = 0; i < _isMode.length; i++) {
                            if (i == 1) {
                              continue;
                            } else {
                              _isMode[i] = false;
                            }
                          }
                          _isMode[1] = !_isMode[1];
                        });
                        ChangeCamMode(roomname, 'room');
                        print("ismode: $_isMode");
                      },
                      isclick: _isElvated[1],
                      isclick2: _isElvated2[1],
                      ismode: _isMode[1],
                    ),
                    ModeBotton(
                        text: "室外模式",
                        img: "assets/images/outside_mode.jpg",
                        widget: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("依照出現的時間來判斷是否為可疑人物\n逗留，用於配合室外的攝影設備。",style: TextStyle(
                                color: Colors.brown.withOpacity(.6)
                            ),),
                            addVerticalSpace(10),
                            Text("功能："),
                            addVerticalSpace(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: COLOR_GREEN,
                                  size: 20,
                                ),
                                addHorizontalSpace(2),
                                Text(
                                  "可疑人士通知",
                                  style: TextStyle(color: COLOR_GREEN),
                                ),
                              ],
                            ),
                            addVerticalSpace(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: COLOR_GREEN,
                                  size: 20,
                                ),
                                addHorizontalSpace(2),
                                Text(
                                  "人物追蹤技術",
                                  style: TextStyle(color: COLOR_GREEN),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ontap: () {
                          this.setState(() {
                            for (int i = 0; i < _isElvated.length; i++) {
                              if (i == 2) {
                                continue;
                              } else {
                                _isElvated[i] = false;
                                _isElvated2[i] = false;
                              }
                            }
                          });

                          _isElvated[2] = !_isElvated[2];
                          Future.delayed(
                              Duration(milliseconds: _isElvated[2] ? 250 : 0),
                                  () {
                                this.setState(() {
                                  _isElvated2[2] = _isElvated[2];
                                });
                              });
                        },
                        modeontap: () {
                          modeinfo['mode'] = 'outdoor';
                          this.setState(() {
                            for (int i = 0; i < _isMode.length; i++) {
                              if (i == 2) {
                                continue;
                              } else {
                                _isMode[i] = false;
                              }
                            }
                            _isMode[2] = !_isMode[2];
                          });
                          ChangeCamMode(roomname, 'outdoor');
                          print("ismode: $_isMode");
                        },
                        isclick: _isElvated[2],
                        isclick2: _isElvated2[2],
                        ismode: _isMode[2]),
                    ModeBotton(
                      text: "夜沒歸模式",
                      img: "assets/images/nightmare_mode.jpg",
                      widget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("當家中人員皆外出時可啟動此模式，此\n模式會偵測畫面內任何移動物，擷取畫\n面並通知使用者。",style: TextStyle(
                              color: Colors.brown.withOpacity(.6)
                          ),),
                          addVerticalSpace(8),
                          Text("功能："),
                          addVerticalSpace(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: COLOR_GREEN,
                                size: 20,
                              ),
                              addHorizontalSpace(2),
                              Text(
                                "可疑人士通知",
                                style: TextStyle(color: COLOR_GREEN),
                              ),
                            ],
                          ),
                          addVerticalSpace(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: COLOR_GREEN,
                                size: 20,
                              ),
                              addHorizontalSpace(2),
                              Text(
                                "移動物偵測",
                                style: TextStyle(color: COLOR_GREEN),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ontap: () {
                        this.setState(() {
                          for (int i = 0; i < _isElvated.length; i++) {
                            if (i == 3) {
                              continue;
                            } else {
                              _isElvated[i] = false;
                              _isElvated2[i] = false;
                            }
                          }
                        });

                        _isElvated[3] = !_isElvated[3];
                        Future.delayed(
                            Duration(milliseconds: _isElvated[3] ? 250 : 0),
                                () {
                              this.setState(() {
                                _isElvated2[3] = _isElvated[3];
                              });
                            });
                      },
                      modeontap: () {
                        modeinfo['mode'] = 'room_outside';
                        this.setState(() {
                          for (int i = 0; i < _isMode.length; i++) {
                            if (i == 3) {
                              continue;
                            } else {
                              _isMode[i] = false;
                            }
                          }
                          _isMode[3] = !_isMode[3];
                        });
                        ChangeCamMode(roomname, 'room_outside');
                        print("ismode: $_isMode");
                      },
                      isclick: _isElvated[3],
                      isclick2: _isElvated2[3],
                      ismode: _isMode[3],
                    ),
                  ],
                ),
                //
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModeBotton extends StatelessWidget {
  final String text;
  final String img;
  final Widget widget;
  final VoidCallback ontap, modeontap;
  final bool isclick, isclick2, ismode;
  const ModeBotton({
    Key? key,
    required this.widget,
    required this.text,
    required this.img,
    required this.ontap,
    required this.modeontap,
    required this.isclick,
    required this.isclick2,
    required this.ismode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String modename = text;
    final ThemeData themeData = Theme.of(context);
    final Size mediasize = MediaQuery.of(context).size;
    double ContainerHeight = mediasize.height / 2;
    bool isClick = isclick;
    bool isClick2 = isclick2;
var modeimage = img;
    return Column(
      children: [
        // Container(
        //   child: Text(
        //     modename,
        //       style: TextStyle(color: COLOR_BLACK,fontSize: 20,fontWeight: FontWeight.bold),
        //   ),
        // ),
        // addVerticalSpace(10),
        GestureDetector(
          onTap: ontap,
          child: AnimatedContainer(
            width: 500,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            duration: Duration(milliseconds: 250),
            height: isClick ? 510 : 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: isClick ? Border.all(color: COLOR_GREY) : null,
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey[500]!,
              //     blurRadius: 6,
              //     offset: Offset(6, 6),
              //   ),
              //   BoxShadow(
              //     blurRadius: 6,
              //     color: Colors.white,
              //     offset: Offset(-6, -6),
              //   ),
              // ],
            ),
            child: Stack(children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    //margin: isClick ? EdgeInsets.symmetric(vertical: 10) : null,
                    width: isClick ? 250 : 300,
                    height: isClick ? 250 : 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          alignment: Alignment.centerRight,
                          opacity: isClick ? 1 : .7,
                          image: ExactAssetImage(modeimage),
                          fit: BoxFit.fitWidth,
                        )),
                  ),
                ),
              ),
              //顯示內容

              if (isClick2)
                Positioned(
                    top: 280,
                    child: Padding(
                      padding: sidePadding,
                      child: Container(child: widget),
                    )),

              if (isClick2 && !ismode)
                Positioned(
                  bottom: 20,
                  child: Padding(
                    padding: sidePadding,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      minWidth: 250,
                      height: 50,
                      color: Colors.brown,
                      child: Text(
                        "選擇此模式",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: modeontap,
                    ),
                  ),
                ),

              if (isClick2)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 240),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        modename,
                        style: themeData.textTheme.headline4,
                      )),
                ),

              if (isClick2 && ismode)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: padding),
                child: Align(
                  alignment: Alignment.bottomCenter,
                    child: Text("已選擇此模式",style:TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),)),
                ),

              Positioned(
                  top: isClick ? 40 : 20,
                  right: isClick ? 30 : 20,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.9),
                    ),
                    width: isClick ? 90 : 100,
                    height: isClick ? 35 : 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ismode
                            ? Icon(
                                Icons.check_circle,
                                color: COLOR_GREEN,
                          size: 20,
                              )
                            : Icon(
                                Icons.check_circle_outline,
                                color: COLOR_GREY,size: 20,
                              ),
                        ismode
                            ? Text(
                                "已啟動",
                                style:
                                    TextStyle(fontSize: 18, color: COLOR_GREEN),
                              )
                            : Text(
                                "未啟動",
                                style:
                                    TextStyle(fontSize: 18, color: COLOR_GREY),
                              )
                      ],
                    ),
                  )),
            ]),
          ),
        ),
        addVerticalSpace(30),
      ],
    );
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
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/ModeScreen',arguments: {
          'room':itemdata["name"],
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: COLOR_ROOM),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        margin: const EdgeInsets.only(left: 25),
        child: Center(
            child:
                Text(itemdata["name"], style: themeData.textTheme.headline5)),
      ),
    );
  }
}
