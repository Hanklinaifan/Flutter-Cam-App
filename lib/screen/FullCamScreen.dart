import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutterproject_second/screen/AddCamScreen.dart';
import 'package:flutterproject_second/screen/CamScreen.dart';
import 'package:flutterproject_second/utils/constants.dart';
import 'package:video_player/video_player.dart';

class FullCamScreen extends StatefulWidget {
  const FullCamScreen({Key? key,required this.vlcsource}) : super(key:key);
  final vlcsource;

  @override
  State<FullCamScreen> createState() => _FullCamScreenState();
}

class _FullCamScreenState extends State<FullCamScreen> {

  bool _istouched = true;
  bool _isClick = true;
  VlcPlayerController? _vlccontroller;
  late Future<void> _vlcplayerfuture;
  @override

  Future _landscapeMode() async{
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  Future _setAllOrientation() async{
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
  }

  void initState() {
    super.initState();
    _landscapeMode();
    _vlccontroller = VlcPlayerController.network(
      widget.vlcsource,
      hwAcc: HwAcc.auto,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
    _vlcplayerfuture = _vlccontroller!.initialize();
  }

  @override
  Future<void> dispose() async {
    _setAllOrientation();
    await _vlccontroller!.stop();
    await _vlccontroller!.stopRendererScanning();
    await _vlccontroller!.dispose();
    super.dispose();

  }

  Widget build(BuildContext context) {
    print("istouch : $_isClick");
    // dynamic vlcvid = ModalRoute.of(context)?.settings.arguments;
    // dynamic vlccontrol = vlcvid['controller'];
    // print(vlccontrol);
    return Container(
      child: Stack(
        children: [
          FutureBuilder(
            future: _vlcplayerfuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.done) {
                return VlcPlayer(
                  controller: _vlccontroller!,
                  aspectRatio: 16 / 9,
                  placeholder: Center(
                      child: CircularProgressIndicator()),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Align(
           alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: 150,
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: COLOR_WHITE.withOpacity(.4),
                borderRadius: BorderRadius.circular(50)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_new,color: Colors.black,size: 34,),
                  ),
                  GestureDetector(
                    onTap:(){
                      setState(() {
                        _vlccontroller!.value.isPlaying
                            ? _vlccontroller!.pause()
                            : _vlccontroller!.play();
                        _isClick = !_isClick;
                      });
                    },
                    child: _isClick? Icon(Icons.pause,color: Colors.black,size: 36,):Icon(Icons.play_arrow,color: Colors.black,size: 36,),
                  ),
                  GestureDetector(
                    onTap: (){
                      _vlccontroller!.stop();
                    },
                    child: Icon(Icons.stop,color: Colors.black,size: 36,),
                  ),
                ]
              ),
            ),
          )
        ],
      ),
    );
  }
}
