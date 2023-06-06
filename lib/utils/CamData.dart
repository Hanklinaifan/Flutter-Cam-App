import 'dart:io';
import 'package:flutterproject_second/utils/Http.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';



Future<List<Map<String,dynamic>>> getAllCam() async {
  final response = await http.get(Uri.parse(http_getCam));
  final decode0 = json.decode(response.body) as List<dynamic>;
  final decode = List<Map<String,dynamic>>.from(decode0);
  return decode;
}

Future<void> addCam(String name,String url) async {

  String initmode ="normal";

  Map<String,dynamic> mdata = {
    "name" : name,
    "url" : url,
    "init_mode" : initmode,
  };
  final encode_mdata = json.encode(mdata);
  final encoding = Encoding.getByName('utf-8');
  print(encode_mdata);

  http.Response response = await http.post(Uri.parse(http_addCam),
    headers: {
      //need to set headers ex :
      // "Accept": "application/json",
      // "Content-Type": "application/x-www-form-urlencoded"
      "Content-Type": "application/json"
    },
    body: encode_mdata,
    encoding: encoding,
  );

  var res = json.decode(response.body);
  print(res);

}

Future<void> DeleteCam(String name) async {
  http.Response response = await http.delete(Uri.parse(http_deleteCam+"/$name"),);
  //接收回傳
  String resposebody = response.body;
}
