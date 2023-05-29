import 'dart:ui';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterproject_second/screen/AddCamScreen.dart';
import 'package:flutterproject_second/screen/AllsusScreen.dart';
import 'package:flutterproject_second/screen/CamScreen.dart';
import 'package:flutterproject_second/screen/FullCamScreen.dart';
import 'package:flutterproject_second/screen/LandingScreen.dart';
import 'package:flutterproject_second/screen/ModeScreen.dart';
import 'package:flutterproject_second/screen/NoticeScreen.dart';
import 'package:flutterproject_second/screen/SetCamScreen(notusing).dart';
import 'package:flutterproject_second/screen/SusScreen.dart';
import 'package:flutterproject_second/screen/SettingScreen.dart';
import 'package:flutterproject_second/screen/MemberScreen.dart';
import 'package:flutterproject_second/utils/constants.dart';
import 'package:flutterproject_second/screen/SetmemberScreen.dart';
import 'package:flutter/rendering.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  debugPaintSizeEnabled = false;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(Myapp());
  });
}

// class Myapp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = window.physicalSize.width;
//     return FutureBuilder(
//         future: Future.delayed(Duration(seconds: 1)),
//         builder: (context, AsyncSnapshot snapshot) {
//           // Loading
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return MaterialApp(
//               theme: ThemeData(
//                   backgroundColor: Colors.grey[100],
//                   primaryColor: COLOR_GREY,
//                   textTheme: screenWidth < 500
//                       ? TEXT_THEME_SMALL
//                       : TEXT_THEME_DEFAULT,
//                   fontFamily: "Montserrat"),
//               debugShowCheckedModeBanner: false,
//               home: Scaffold(body: SplashPage()),
//             );
//           } else {
//             return MaterialApp(
//                 debugShowCheckedModeBanner: false,
//                 title: 'CatchTheif',
//                 theme: ThemeData(
//                     backgroundColor: Colors.grey[100],
//                     primaryColor: COLOR_GREY,
//                     textTheme: screenWidth < 500
//                         ? TEXT_THEME_SMALL
//                         : TEXT_THEME_DEFAULT,
//                     fontFamily: "Montserrat"),
//                 home: Scaffold(
//                   appBar: AppBar(
//                     backgroundColor: Colors.white,
//                     elevation: 0,
//                     toolbarHeight: 60,
//                     title: Text(
//                       "防盜攝影系統",
//                       style: TextStyle(
//                           color: COLOR_LIGHTBROWN,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18),
//                     ),
//                   ),
//                   resizeToAvoidBottomInset: false,
//                   body: BottomNavigationController(),
//                 ),
//                 routes: <String, WidgetBuilder>{
//                   '/SusScreen': (_) => new SusScreen(),
//                   '/ModeScreen': (_) => new ModeScreen(),
//                   '/MemberScreen': (_) => new MemberScreen(),
//                   '/AllsusScreen': (_) => new AllsusScreen(),
//                   '/SetmemberScreen': (_) => new SetmemberScreen(),
//                   '/CamScreen': (_) => new CamScreen(),
//                   '/AddCamScreen': (_) => new AddCamScreen(),
//                   '/SettingScreen': (_) => new SettingScreen(),
//                   '/NoticeScreen': (_) => new NoticeScreen(),
//                 });
//           }
//         });
//   }
// }
class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = window.physicalSize.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CatchTheif',
        theme: ThemeData(
            backgroundColor: Colors.grey[100],
            primaryColor: COLOR_GREY,
            textTheme: screenWidth < 500
                ? TEXT_THEME_SMALL
                : TEXT_THEME_DEFAULT,
            fontFamily: "Montserrat"),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            toolbarHeight: 60,
            title: Text(
              "防盜攝影系統",
              style: TextStyle(
                  color: COLOR_LIGHTBROWN,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: BottomNavigationController(),
        ),
        routes: <String, WidgetBuilder>{
          '/SusScreen': (_) => new SusScreen(),
          '/ModeScreen': (_) => new ModeScreen(),
          '/MemberScreen': (_) => new MemberScreen(),
          '/AllsusScreen': (_) => new AllsusScreen(),
          '/SetmemberScreen': (_) => new SetmemberScreen(),
          '/CamScreen': (_) => new CamScreen(),
          '/AddCamScreen': (_) => new AddCamScreen(),
          '/SettingScreen': (_) => new SettingScreen(),
          '/NoticeScreen': (_) => new NoticeScreen(),
          // '/FullCamScreen': (_) => new FullCamScreen(),
        });
  }
}

//開場動畫
// class SplashPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Container(
//           width: 200,
//             height: 200,
//             child: Icon(Icons.camera_alt_rounded,size: 100,)
//         ),
//       ),
//     );
//   }
// }

//底部的bar
class BottomNavigationController extends StatefulWidget {
  BottomNavigationController({Key? key}) : super(key: key);

  @override
  _BottomNavigationControllerState createState() =>
      _BottomNavigationControllerState();
}

class _BottomNavigationControllerState
    extends State<BottomNavigationController> {
  //目前選擇頁索引值
  int _currentIndex = 1; //預設值
  final pages = [NoticeScreen(), LandingScreen(), MemberScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 60,
        child: ClipRRect(
          //borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(25)),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_active), label: "通知"),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "首頁"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_alt_rounded), label: "成員"),
            ],
            elevation: 10,
            unselectedFontSize: 10,
            iconSize: 25,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.brown.withOpacity(0.7),
            unselectedItemColor: Colors.grey.withOpacity(.5),
            currentIndex: _currentIndex, //目前選擇頁索引值//選擇頁顏色
            onTap: _onItemClick,
          ),
        ),
      ),
    );
  }

  //BottomNavigationBar 按下處理事件，更新設定當下索引值
  void _onItemClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
