import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterproject_second/custom/Showup.dart';
import 'package:flutterproject_second/screen/FullCamScreen.dart';
import 'package:flutterproject_second/screen/httptestScreen.dart';
import 'package:flutterproject_second/utils/constants.dart';
import 'package:flutterproject_second/utils/sample_data.dart';
import 'package:flutterproject_second/utils/widget_functions.dart';
import 'package:flutterproject_second/utils/http.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutterproject_second/screen/LandingScreen.dart';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:web_socket_channel/status.dart';

class CamScreen extends StatefulWidget {
  @override
  _CamScreen createState() => _CamScreen();
}

class _CamScreen extends State<CamScreen> {
  bool _isclick = true ;
  bool _istouched = true;

  String videosource = "rtsp://Hank_MA303:ZH_MA303@192.168.0.170/stream1";
  String tsetvideosource = "rtsp://211.21.74.23:8554/stream1";
  VlcPlayerController? _vlccontroller;

  late Future<void> _vlcplayerfuture;

  @override
  void initState() {
    super.initState();
    _vlccontroller = VlcPlayerController.network(
      videosource,
      hwAcc: HwAcc.auto,
      autoPlay: false,
      options: VlcPlayerOptions(),
    );
    _vlcplayerfuture = _vlccontroller!.initialize();
    // ..initialize().then((_) {
    //   setState(() {});
    // });
  }

  Future<void> dispose() async {
    super.dispose();
    await _vlccontroller!.stop();
    await _vlccontroller!.stopRendererScanning();
    await _vlccontroller!.dispose();
  }

  Future setLandscape() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  Widget build(BuildContext context) {

    final Size mediasize = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    dynamic roominfo = ModalRoute.of(context)?.settings.arguments;
    var roomindex = roominfo['index'];
    String? roomname = ROOM_DATA[roomindex]['room'];



    return Scaffold(
        backgroundColor: COLOR_BACKGROUND[100],
        body: Container(
          width: mediasize.width,
          height: mediasize.height,
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(padding-20),
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
                      "監視器 ：$roomname",
                      style: themeData.textTheme.headline2,
                    )
                  ],
                ),
              ),
              addVerticalSpace(10),

              //選擇監視器

              // Container(
              //   height: 50,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: ROOM_DATA.length,
              //     itemBuilder: (context, index) {
              //       return Choiseroom(itemdata: ROOM_DATA[index]);
              //     },
              //   ),
              // ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap:(){
                        setState(() {
                          _istouched = !_istouched;

                          // if(_istouched){
                          //   sleep(Duration(seconds: 2));
                          //   setState(() {
                          //     _istouched = false;
                          //   });
                          // }
                        });
                      },
                      child: Container(
                        width: mediasize.width,
                        height: (mediasize.width - 20) * .5625,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                            border: Border.all(
                              color: COLOR_GREY,
                            )),
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                  ),

                                  child: FutureBuilder(
                                    future: _vlcplayerfuture,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return AspectRatio(
                                          aspectRatio:
                                              _vlccontroller!.value.aspectRatio,
                                          child: VlcPlayer(
                                            controller: _vlccontroller!,
                                            aspectRatio: 16 / 9,
                                            placeholder: Center(
                                                child: CircularProgressIndicator()),
                                          ),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                                ),

                            ),
                            _istouched?
                            ShowUp(
                              delay: 5,
                              child: Center(
                                  child: GestureDetector(
                                    onTap:(){
                                      setState(() {
                                        _vlccontroller!.value.isPlaying
                                            ? _vlccontroller!.pause()
                                            : _vlccontroller!.play();
                                        _isclick = !_isclick;

                                      });
                                    } ,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5 ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(90),
                                        color: COLOR_GREY.withOpacity(.4)
                                      ),
                                      child: Icon(
                                _isclick? Icons.play_arrow:Icons.pause,
                                color: Colors.white,
                                        size: 30,
                              ),
                                    ),
                                  )),
                            ):SizedBox.shrink(),
                            _istouched?
                            Positioned(
                              right: 5,
                              bottom: 5,
                              child: ShowUp(
                                delay: 5,
                                child: GestureDetector(
                                  onTap: () async {
                                    _vlccontroller!.stop();
                                    setState(() {
                                      _isclick = true;
                                    });
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) =>
                                            FullCamScreen(vlcsource: videosource),
                                        )
                                    );
                                  },
                                  child: Icon(Icons.fullscreen_sharp,
                                        color: Colors.white),
                                ),
                              ),
                            ):SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: COLOR_GREY),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _vlccontroller!.value.isPlaying
                                  ? _vlccontroller!.pause()
                                  : _vlccontroller!.play();
                              setState(() {
                                _isclick = !_isclick;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: COLOR_GREY),
                                borderRadius: BorderRadius.circular(90),
                              ),
                              child: Center(
                                child: Icon(
                                    _isclick ? Icons.play_arrow : Icons.pause),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              _vlccontroller!.stop();
                              //dispose();
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: COLOR_GREY),
                                borderRadius: BorderRadius.circular(90),
                              ),
                              child: Center(
                                child: Icon(Icons.stop),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              _vlccontroller!.stop();
                              setState(() {
                                _isclick = true;
                              });
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) =>
                                      FullCamScreen(vlcsource: videosource),
                                )
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: COLOR_GREY),
                                borderRadius: BorderRadius.circular(90),
                              ),
                              child: Center(
                                child: Icon(Icons.fullscreen_sharp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 280,
                  decoration: BoxDecoration(
                    border: Border.all(color: COLOR_GREY),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListView(
                    padding: sidePadding,
                    children: [
                      addVerticalSpace(padding),
                      Container(
                          height: 60,
                          width: mediasize.width,
                          child: OutlinedButton(
                            onPressed: () {
                              print("getpic: $http_get_pic");
                            },
                            child: Text("更換攝影機名稱"),
                          )),
                      addVerticalSpace(padding),
                      Container(
                          height: 60,
                          width: mediasize.width,
                          child: OutlinedButton(
                            onPressed: () async {
                             if(await _vlccontroller!.isPlaying() == true){
                               _vlccontroller!.stop();
                               setState(() {
                                 _isclick = true;
                                 _istouched = true;
                               });
                             }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => httptestScreen()));
                            },
                            child: Text("查看紀錄"),
                          )),
                      addVerticalSpace(padding),
                      Container(
                          height: 60,
                          width: mediasize.width,
                          child: OutlinedButton(
                            onPressed: () {
                              print("picjson: $http_get_picnjson");
                            },
                            child: Text("切換模式"),
                          )),
                      addVerticalSpace(padding),
                      Container(
                          height: 60,
                          width: mediasize.width,
                          child: OutlinedButton(
                            onPressed: () {
                              print("picjson: $http_get_picnjson");
                            },
                            child: Text("刪除攝影機"),
                          )),
                      addVerticalSpace(padding),
                    ],
                  ),
                ),
              ),
            ],
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
