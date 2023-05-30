import 'dart:io';
import 'package:flutterproject_second/utils/Http.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';



Future<void> addCam(String name,String url) async {

  Map<String,dynamic> mdata = {
    "name" : name,
    "url" : url,
    "init_mode" : "normal",
  };
  final encode_mdata = json.encode(mdata);
  final encoding = Encoding.getByName('utf-8');


  http.Response response = await http.post(Uri.parse(http_addCam),

    headers: {
      //need to set headers ex :
      // "Accept": "application/json",
      // "Content-Type": "application/x-www-form-urlencoded"
    },
    body: encode_mdata,
    encoding: encoding,
  );
}

Future<void> DeleteCam(String name) async {
  http.Response response = await http.delete(Uri.parse(http_deleteCam+"/$name"),);
  //接收回傳
  String resposebody = response.body;
}