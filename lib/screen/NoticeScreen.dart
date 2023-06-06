import 'package:flutter/material.dart';
import 'package:flutterproject_second/custom/BorderBox.dart';
import 'package:flutterproject_second/custom/MyButton.dart';
import 'package:flutterproject_second/screen/AddCamScreen.dart';
import 'package:flutterproject_second/utils/SusData.Dart.dart';
import 'package:flutterproject_second/utils/constants.dart';
import 'package:flutterproject_second/utils/sample_data.dart';
import 'package:flutterproject_second/utils/widget_functions.dart';
import 'package:flutterproject_second/custom/Showup.dart';

class NoticeScreen extends StatefulWidget {
  @override
  _NoticeScreen createState() => _NoticeScreen();
}

class _NoticeScreen extends State<NoticeScreen> {
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("通知", style: themeData.textTheme.headline2),
                    GestureDetector(
                      onTap: (){
                        setState(() {

                        });
                      },
                        child: Text("重新整理", style: themeData.textTheme.bodyText1)),
                  ],
                ),
              ),

              Padding(
                padding: sidePadding,
                child: Divider(
                  height: padding,
                  color: Colors.brown,
                ),
              ),
              Padding(
                padding: sidePadding,
                child: Container(
                  height: mediasize.height/1.65,
                  child: FutureBuilder(
                    future: getAllSus(),
                    builder: (context,AsyncSnapshot snapshot){
                      if(snapshot.connectionState == ConnectionState.done){
                        if(snapshot.data == null){
                          return Center(child: Text('尚無通知'),);
                        }
                        else{
                          var data = snapshot.data;
                          data.sort((a,b){
                            var adate = a['appear_time'].toString();
                            var bdate = b['appear_time'].toString();
                            return bdate.compareTo(adate);
                          });
                          return  ListView.builder(
                            itemCount: data.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return NoticeItem(index: index,
                                SUSDATA: data[index],);
                            },
                          );
                        }
                      }
                      else{
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                )

              )
            ],
          ),
        ),
      ),
    );
  }
}

class NoticeItem extends StatelessWidget {
  final index;
  final SUSDATA;
  const NoticeItem({Key? key, required this.index, this.SUSDATA}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemimage = getSusPic(SUSDATA["imagepath"]);
    var itemtime = SUSDATA["appear_time"];
    var itemplace = SUSDATA["place"];
    var itemvid = getSusVid(SUSDATA["videopath"]);
    final Size mediasize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/SusScreen',
            arguments: {'image': itemimage,'time':itemtime,'index':index,'place':itemplace,'video':itemvid});
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: mediasize.width,
        height: mediasize.height / 7.5,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                right: 10,
                child: Text(SUSDATA['appear_time'].toString())),
            Padding(
              padding: sidePadding,
              child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Container(width: 60,height:60,child: ClipRRect(borderRadius: BorderRadius.circular(5),child: Image.network(getSusPic(SUSDATA['imagepath']),fit: BoxFit.cover,))),
                      addHorizontalSpace(20),
                      Text(
                        '有可疑人士出沒!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: COLOR_BLACK),
                      ),
                    ],
                  )),
            ),
            Positioned(
              bottom: 0,
              right: 10,
              child: Text('點入以查看更多'),
            ),
          ],
        ),
      ),
    );
  }
}
