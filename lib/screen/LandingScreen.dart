import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterproject_second/custom/BorderBox.dart';
import 'package:flutterproject_second/screen/SusScreen.dart';
import 'package:flutterproject_second/screen/ModeScreen.dart';
import 'package:flutterproject_second/utils/SusData.Dart.dart';
import 'package:flutterproject_second/utils/constants.dart';
import 'package:flutterproject_second/utils/sample_data.dart';
import 'package:flutterproject_second/utils/widget_functions.dart';
import 'package:flutterproject_second/custom/MyButton.dart';

import '../utils/CamData.dart';

final double padding = 25;
final sidePadding = EdgeInsets.symmetric(horizontal: padding, vertical: 0);

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreen createState() => _LandingScreen();
}

class _LandingScreen extends State<LandingScreen> {
  GlobalKey globalKey = GlobalKey();
  List<double> limits = [];

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  Widget build(BuildContext context) {
    final Size mediasize = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_BACKGROUND[100],
        body: Container(
          width: mediasize.width,
          height: mediasize.height,
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(padding),
                //監視器畫面
                Padding(
                  padding: sidePadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("攝影機", style: themeData.textTheme.headline2),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/SettingScreen');
                          },
                          child: Text("查看全部",
                              style: themeData.textTheme.bodyText2)),
                    ],
                  ),
                ),

                addVerticalSpace(padding),
//監視器set
                Container(
                  height: 200,
                  child: FutureBuilder(
                    future: getAllCam(),
                    builder: (context,AsyncSnapshot snapshot){
                      if(snapshot.connectionState == ConnectionState.done){
                        if(snapshot.data == null){
                          return GestureDetector(
                            onTap: (){
                              //新增攝影機
                              Navigator.pushNamed(context, '/AddCamScreen');
                            },
                            child: Center(
                              child: Container(
                                  width: 250,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: COLOR_GREY),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add,),
                                      Text("新增攝影機")
                                    ],
                                  )),
                            ),
                          );
                        }
                        return PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length+1,
                            physics: const ClampingScrollPhysics(),
                            controller: _pageController,
                            itemBuilder: (context, index) {
                              if (index == snapshot.data.length) {
                                return GestureDetector(
                                  onTap: (){
                                    //新增攝影機
                                    Navigator.pushNamed(context, '/AddCamScreen');
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Container(
                                        width: 300,
                                        height: 300,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: COLOR_GREY),
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.add,),
                                            Text("新增攝影機")
                                          ],
                                        )),
                                  ),
                                );
                              } else {
                                return carouselView(
                                  itemData: snapshot.data[index],
                                  roomindex: index,
                                );
                              }
                            });
                      }
                      else{
                        return Center(child: CircularProgressIndicator(),);
                      }
                    },
                  )
                ),
                addVerticalSpace(padding),
                Padding(
                  padding: sidePadding,
                  child: Divider(
                    height: padding,
                    color: Colors.brown,
                  ),
                ),

                //可疑人士畫面
                addVerticalSpace(padding),
                Padding(
                  padding: sidePadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("潛在的可疑人士", style: themeData.textTheme.headline3),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/AllsusScreen');
                          },
                          child: Text("查看全部",
                              style: themeData.textTheme.bodyText2)),
                    ],
                  ),
                ),

                //可疑人士database
                addVerticalSpace(padding),
                Container(
                  height: 130,
                  child: FutureBuilder(
                    future: getAllSus(),
                    builder: (context,AsyncSnapshot snapshot){
                      if(snapshot.connectionState == ConnectionState.done){
                        if(snapshot.data == null){
                          return Padding(padding: sidePadding,child: Text('目前無可疑人士'));
                        }
                        else {
                          snapshot.data.sort((a,b){
                            var adate = a['appear_time'].toString();
                            var bdate = b['appear_time'].toString();
                            return bdate.compareTo(adate);
                          });
                          return  ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Item(itemData: snapshot.data[index],susindex: index,);
                          },
                        );}

                      }
                     else{return Center(child: CircularProgressIndicator(),);}
                    },
                  ),
                  // child: ListView.builder(
                  //   scrollDirection: Axis.horizontal,
                  //   itemCount: IMG_DATA.length,
                  //   itemBuilder: (context, index) {
                  //     return Item(itemData: IMG_DATA[index],susindex: index,);
                  //   },
                  // ),
                ),
                addVerticalSpace(20),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

//監視器選擇畫面
class carouselView extends StatelessWidget {
  final dynamic itemData;
  final int roomindex;


  const carouselView({Key? key, required this.itemData,required this.roomindex}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var mode ;
    if(itemData['mode']=='normal'){
      mode = '一般模式';
    }
    else if(itemData['mode']=='outdoor'){
      mode = '室外模式';
    }
    else if(itemData['mode']=='room'){
      mode = '室內模式';
    }
    else{
      mode = '夜沒歸模式';
    }

    final Size mediasize = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final plusone = roomindex+1;
    return Padding(
      padding: sidePadding / 2,
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context, "/CamScreen",
                arguments: {'index':roomindex,'name':itemData['name'],'mode':itemData["mode"]}
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              height: 200,
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.house_outlined,color: COLOR_LIGHTBROWN,size: 30,),
                  Text(itemData['name'],style: TextStyle(color: COLOR_LIGHTBROWN,fontSize: 18,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: COLOR_ROOM,
            ),
            child: Center(
              child: Text("攝影機 $plusone",
                  style: TextStyle(
                      color: Colors.white60.withOpacity(0.8),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/ModeScreen',
                    arguments: {'roomnum': itemData,'room':itemData['name'],'mode':itemData['mode']});
              },
              child: Container(
                width: 130,
                height: 50,
                decoration: BoxDecoration(
                  color: COLOR_GREY.withOpacity(.8),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(25)),
                ),
                child: Center(
                    child: Text(
                 mode,
                  style: themeData.textTheme.headline5,
                )),
              ),
            )),
      ]),
    );
  }
}

//嫌疑人畫面
class Item extends StatelessWidget {
  final dynamic itemData;
  final dynamic susindex;
  const Item({Key? key, required this.itemData,required this.susindex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemimage = getSusPic(itemData["imagepath"]);
    var itemtime = itemData["appear_time"];
    var itemplace = itemData["place"];
    var itemvid = getSusVid(itemData["videopath"]);
    return Container(
      height: 100,
      width: 130,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/SusScreen',
              arguments: {'image': itemimage,'time':itemtime,'index':susindex,'place':itemplace,'video':itemvid});
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.network(
            itemimage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
