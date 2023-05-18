import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

//url網址
final String comurl = "https://newmainpy-1-c9615948.deta.app";
final String phoneurl = "http://10.0.2.2:8000";

//url回傳response
final String http_get = "$comurl/test/get";

//url回傳json檔案單一圖片
final String http_get_pic = "$comurl/test/get/pic";

//取得所有圖片檔名
final String http_get_picname = "$comurl/test/get/allpicid";

//取得包含圖片的 JSON 檔: 有{Place, Time, Name, image}四個key
final String http_get_picnjson = "$comurl/test/get/picnjson";

//取的多個json
final String http_get_alljson = "$comurl/test/get/alljson";

//上傳 JSON 檔，上傳成功會回傳JSON
final String http_post = "$comurl/test/post";

//建立websocket，目前先建立在本地端
final String http_ws = "ws://10.0.2.2:8000/ws";



String getPic(String picname){
  return "$comurl/test/get/allpic" + "/$picname";
}

void SocketConnect(){
  IOWebSocketChannel.connect(Uri.parse(http_ws));
}
var channel = WebSocketChannel.connect(Uri.parse(http_ws));
void Socketadd(String message){

  // channel.stream.listen((res) {
  //   channel.sink.add(message);
  // });
  channel.sink.add(message);
}


Future<Map<String,dynamic>> getJson() async {
  final response = await http.get(Uri.parse(http_get_picnjson));
  final decode = json.decode(response.body) as Map<String,dynamic>;
  return decode;
}

Future<List<Map<String,dynamic>>> getAllJson() async {
  final response = await http.get(Uri.parse(http_get_alljson));
  final decode0 = json.decode(response.body) as List<dynamic>;
  final decode = List<Map<String,dynamic>>.from(decode0);
  return decode;
}

Future<List> getName() async {
  final response = await http.get(Uri.parse(http_get_picname));
  final decode = json.decode(response.body) as List<dynamic>;
  return decode;
}

Future<Map<String,dynamic>> getResponse() async {
  final response = await http.get(Uri.parse(http_get));
  final decode = json.decode(response.body) as Map<String,dynamic>;
  return decode;
}