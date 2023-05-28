import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutterproject_second/screen/CamScreen.dart';
import 'package:video_player/video_player.dart';

class FullCamScreen extends StatefulWidget {

  @override
  State<FullCamScreen> createState() => _FullCamScreenState();
}

class _FullCamScreenState extends State<FullCamScreen> {
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
  }

  @override
  void dispose() {
    _setAllOrientation();
    super.dispose();
  }

  Widget build(BuildContext context) {
    dynamic vlcvid = ModalRoute.of(context)?.settings.arguments;
    dynamic vlccontrol = vlcvid['controller'];
    print(vlccontrol);
    return Stack(
      children: [
        VlcPlayer(controller: vlccontrol, aspectRatio: 16/9),
        GestureDetector(
          onTap: (){
            vlccontrol!.play();
            print(vlccontrol);
          },
          child: Center(
            child: Icon(Icons.play_arrow,color: Colors.white,),
          ),
        )
      ],
    );
  }
}
