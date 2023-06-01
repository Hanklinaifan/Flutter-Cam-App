import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterproject_second/custom/BorderBox.dart';
import 'package:flutterproject_second/screen/SusScreen.dart';
import 'package:flutterproject_second/screen/ModeScreen.dart';
import 'package:flutterproject_second/utils/constants.dart';
import 'package:flutterproject_second/utils/sample_data.dart';
import 'package:flutterproject_second/utils/widget_functions.dart';
import 'package:flutterproject_second/custom/MyButton.dart';

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
                //設定以及選單鍵
                // Container(
                //   alignment: Alignment.centerRight,
                //   child: Padding(
                //     padding: sidePadding,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         GestureDetector(
                //           onTap: () {
                //             setState(() {
                //               _isElevated = !_isElevated;
                //               _isMenuOpen = !_isMenuOpen;
                //             });
                //           },
                //           child: AnimatedContainer(
                //             duration: const Duration(milliseconds: 150),
                //             height: 50,
                //             width: 50,
                //             decoration: BoxDecoration(
                //               color: Colors.grey[100],
                //               borderRadius: BorderRadius.circular(15.0),
                //
                //               //選單按鈕效果
                //               /*boxShadow: _isElevated
                //                   ? [
                //                       BoxShadow(
                //                         color: Colors.grey,
                //                         offset: const Offset(3, 3),
                //                         blurRadius: 5,
                //                         spreadRadius: 1,
                //                       ),
                //                       BoxShadow(
                //                         color: Colors.white,
                //                         offset: const Offset(-2, -2),
                //                         blurRadius: 5,
                //                         spreadRadius: 1,
                //                       ),
                //                     ]
                //                   : null,*/
                //             ),
                //             child: BorderBox(
                //               height: 50,
                //               width: 50,
                //               child: Icon(
                //                 Icons.menu,
                //                 color: COLOR_GREEN,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

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
                  height: 250,
                  child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: ROOM_DATA.length+1,
                      physics: const ClampingScrollPhysics(),
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        if (index == ROOM_DATA.length) {
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
                              itemData: ROOM_DATA[index],
                            roomindex: index,
                          );
                        }
                      }),
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
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: IMG_DATA.length,
                    itemBuilder: (context, index) {
                      return Item(itemData: IMG_DATA[index],susindex: index,);
                    },
                  ),
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

//sidebar
// class Drawpainter extends CustomPainter {
//   final Offset offset;
//   Drawpainter({required this.offset});
//
//   double getControlPointX(double width) {
//     if (offset.dx == 0) {
//       return width;
//     } else {
//       return offset.dx > width ? offset.dx : width + 75;
//     }
//   }
//
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;
//     Path path = Path();
//     path.moveTo(-size.width, 0);
//     path.lineTo(size.width, 0);
//     path.quadraticBezierTo(
//         getControlPointX(size.width), offset.dy, size.width, size.height);
//     path.lineTo(-size.width, size.height);
//     path.close();
//
//     canvas.drawPath(path, paint);
//   }
//
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }

// //選擇可疑人士(沒用到了)
// class ChoiseIcon extends StatelessWidget {
//   final IconData icon;
//   const ChoiseIcon({Key? key, required this.icon}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 150,
//       width: 150,
//       decoration: BoxDecoration(
//           color: COLOR_WHITE,
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: COLOR_GREY.withAlpha(40), width: 2)),
//       margin: const EdgeInsets.only(left: 25),
//       child: Icon(
//         icon,
//         color: COLOR_GREEN,
//       ),
//     );
//   }
// }

//監視器選擇畫面
class carouselView extends StatelessWidget {
  final dynamic itemData;
  final int roomindex;

  const carouselView({Key? key, required this.itemData,required this.roomindex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size mediasize = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    String itemimage = itemData["image"];
    return Padding(
      padding: sidePadding / 2,
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context, "/CamScreen",
                arguments: {'index':roomindex,}
              );
            },
            child: BorderBox(
              height: 300,
              width: 300,
              child: Icon(Icons.play_arrow),
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
              child: Text(itemData["room"],
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
                    arguments: {'roomnum': itemData,'room':itemData['room']});
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
                  "一般模式",
                  style: themeData.textTheme.headline5,
                )),
              ),
            )),
      ]),
    );
  }
}

//選擇監視器畫面按鈕
//之後要在這裡設定i，i為攝影機號碼
// class Choiseroom extends StatelessWidget {
//   final dynamic itemdata;
//   const Choiseroom({Key? key, required this.itemdata}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     //在此設定攝影機號碼
//     final ThemeData themeData = Theme.of(context);
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20.0), color: COLOR_ROOM),
//       padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
//       margin: const EdgeInsets.only(left: 25),
//       child: Text(itemdata["room"], style: themeData.textTheme.headline5),
//     );
//   }
// }

//嫌疑人畫面
class Item extends StatelessWidget {
  final dynamic itemData;
  final dynamic susindex;
  const Item({Key? key, required this.itemData,required this.susindex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String itemimage = itemData["image"];
    String itemtime = itemData["time"];
    String itemplace = itemData["place"];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/SusScreen',
              arguments: {'image': itemimage,'time':itemtime,'place':itemplace,'index':susindex});
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
