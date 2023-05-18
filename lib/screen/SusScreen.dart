import 'package:flutter/material.dart';
import 'package:flutterproject_second/custom/BorderBox.dart';
import 'package:flutterproject_second/screen/AddCamScreen.dart';
import 'package:flutterproject_second/utils/constants.dart';
import 'package:flutterproject_second/utils/sample_data.dart';
import 'package:flutterproject_second/utils/widget_functions.dart';
import 'package:flutterproject_second/screen/ModeScreen.dart';
import 'package:video_player/video_player.dart';


class SusScreen extends StatefulWidget {
  @override
  _SusScreen createState() => _SusScreen();
}

class _SusScreen extends State<SusScreen> {
  @override
  var _faceasset ;
  var _timeasset ;
  var _placeasset ;

  Widget build(BuildContext context) {

    final Size mediasize = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    dynamic susinfo = ModalRoute.of(context)?.settings.arguments;
    var susindex = susinfo['index'];
    String Face_assets = IMG_DATA[susindex]['image'].toString();//susinfo["image"];
    String Time_assets = IMG_DATA[susindex]['time'].toString();//susinfo["time"];
    String Place_assets = IMG_DATA[susindex]['place'].toString();//susinfo["place"];
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: [
          addVerticalSpace(10),
          //設定以及選單鍵
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
                addHorizontalSpace(5),
                Text("可疑人士詳情", style: themeData.textTheme.headline2),
              ],
            ),
          ),
          addVerticalSpace(padding),
          Center(
            child: Padding(
              padding: sidePadding,
              child: Container(
                  alignment: Alignment.center,
                  width: 250,
                  height: 250,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        (_faceasset==null) ? Face_assets : _faceasset,
                        fit: BoxFit.cover,
                      ))
              ),
            ),
          ),
          addVerticalSpace(padding),
          Padding(
            padding: sidePadding,
            child: Text((_faceasset==null) ? "時間：$Time_assets":"時間：$_timeasset", style: themeData.textTheme.headline4),
          ),
          addVerticalSpace(20),
          Padding(
            padding: sidePadding,
            child: Text((_faceasset==null) ? "地點：$Place_assets":"地點：$_placeasset", style: themeData.textTheme.headline4),
          ),

          addVerticalSpace(30),
          Padding(
            padding: sidePadding,
            child: Text("可疑人士截錄", style: themeData.textTheme.headline3),
          ),
          addVerticalSpace(15),
          Container(
            height: 200,
            child: PageView.builder(
              itemCount: IMG_DATA.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return Susvid(index: index,source: videosource,);
                })
          ),

          addVerticalSpace(30),
          Padding(
            padding: sidePadding,
            child: Text("其他可疑人士", style: themeData.textTheme.headline3),
          ),
          addVerticalSpace(10),
          Container(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: IMG_DATA.length,
              itemBuilder: (context, index) {
                return Item(
                  itemData: IMG_DATA[index],
                  index: index,
                  ontap: (){
                    setState(() {
                      _faceasset = IMG_DATA[index]['image'];
                      _timeasset = IMG_DATA[index]['time'];
                      _placeasset = IMG_DATA[index]['place'];
                    });
                  },
                );
              },
            ),
          ),

          addVerticalSpace(10),
        ],
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
  final int index;
  final VoidCallback ontap;
  const Item(
      {Key? key,
      required this.itemData,
      required this.index,
      required this.ontap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 110,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Image.asset(
              itemData["image"],
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}


class Susvid extends StatefulWidget {
  final String source;
  final index;
  const Susvid({Key? key,required this.index,required this.source}) : super(key: key);

  @override
  State<Susvid> createState() => _SusvidState();
}

class _SusvidState extends State<Susvid> {
  bool arrowstate = false;
  VideoPlayerController? _controller;
  late Future<void> _vedioplayerfuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.source);
    _vedioplayerfuture = _controller!.initialize();
    super.initState();
  }
  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: sidePadding,
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: COLOR_GREY)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FutureBuilder(
                future: _vedioplayerfuture,
                builder: (context,snapshot){
                  if (snapshot.connectionState == ConnectionState.done){
                    return AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    );
                  }
                  else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                },
              ),

              // child: _controller!.value.isInitialized
              //     ?AspectRatio(aspectRatio: _controller!.value.aspectRatio,
              // child: VideoPlayer(_controller!),
              // ) : SizedBox.shrink(),

              // child: Image.network(
              //   http_get_pic,
              //   fit: BoxFit.cover,
              //   loadingBuilder: (context, child, loadingProgress) =>
              //       (loadingProgress == null)
              //           ? child
              //           : SizedBox(
              //               width: 10,
              //               height: 10,
              //               child: CircularProgressIndicator()),
              //   errorBuilder: (context, error, stackTrace) =>
              //       Center(
              //     child: Text(
              //       "圖片加載出錯，請確認網路是否正確連接",
              //       style: themeData.textTheme.headline6,
              //     ),
              //   ),
              // )
            ),
          ),
          Center(child: GestureDetector(
              onTap: (){
                setState(() {
                  arrowstate = !arrowstate;
              });
                _controller!.value.isPlaying?
                    _controller!.pause():
                    _controller!.play();

              },
              child: Icon(arrowstate?Icons.pause:Icons.play_arrow,color: COLOR_GREY,)),)
        ],
      ),
    );
  }
}

