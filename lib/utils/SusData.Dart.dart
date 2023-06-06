import 'dart:io';
import 'package:flutterproject_second/utils/Http.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';


//memberDATA
Future<dynamic> SUS_DATA = getAllSus().then((value) => [value]);


Future<List<Map<String,dynamic>>> getAllSus() async {
  final response = await http.get(Uri.parse(http_getAllSus));
  final decode0 = json.decode(response.body) as List<dynamic>;
  final decode = List<Map<String,dynamic>>.from(decode0);
  return decode;
}

//用network播放
String getSusPic(String picuri){
  return http_getSusimg + "/$picuri";
}

String getSusVid(String viduri){
  return http_getSusvid + "/$viduri";
}