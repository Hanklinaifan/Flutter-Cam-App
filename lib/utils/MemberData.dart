import 'dart:io' as Io;
import 'package:flutterproject_second/utils/Http.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';




//memberDATA
Future<dynamic> MEMBER_DATA = getAllMember().then((value) => [value]);



Future<List<Map<String,dynamic>>> getAllMember() async {
  final response = await http.get(Uri.parse(http_getMember));
  final decode0 = json.decode(response.body) as List<dynamic>;
  final decode = List<Map<String,dynamic>>.from(decode0);
  return decode;
}


Future<void> addMember(String name,String image,String avatar) async {

  final imgbytes = Io.File(image).readAsBytesSync();
  final avabytes = Io.File(avatar).readAsBytesSync();
  String img64 = base64Encode(imgbytes);
  String ava64 = base64Encode(avabytes);
  // var baseimage = base(image as List<int>); //turn into base64
  // var baseavtar = base64UrlEncode(avatar as List<int>); //turn into base64
  Map<String,dynamic> mdata = {
    "name" : name,
    "image" : img64,
    "avatar" : ava64,
  };
  final encode_mdata = json.encode(mdata);
  final encoding = Encoding.getByName('utf-8');


  http.Response response = await http.post(Uri.parse(http_addMember),

    headers: {
      //need to set headers ex :
      // "Accept": "application/json; charset=UTF-8",
      // "Content-Type": "application/x-www-form-urlencoded"
      "Content-Type": "application/json"
    },
    body: encode_mdata,
    encoding: encoding,
  );

  //接收回傳
  // String responsebody = response.body;
  var res = json.decode(response.body);
  var chinchanchun = res['message'];
  print(res);

}

Future<void> editMember(String oldname,String name, String image, String avatar) async {

  final imgbytes = Io.File(image).readAsBytesSync();
  final avabytes = Io.File(avatar).readAsBytesSync();
  String img64 = base64Encode(imgbytes);
  String ava64 = base64Encode(avabytes);
  Map<String,dynamic> mdata = {
    "name" : name,
    "image" : img64,
    "avatar" : ava64,
  };
  final encode_mdata = json.encode(mdata);
  final encoding = Encoding.getByName('utf-8');

  http.Response response = await http.put(Uri.parse(http_editMember + "/$oldname"),

    headers: {
      //need to set headers ex :
      // "Accept": "application/json",
      // "Content-Type": "application/x-www-form-urlencoded"
      "Content-Type": "application/json"
    },
    body: encode_mdata,
    encoding: encoding,
  );

  //接回傳
  var res = json.decode(response.body);
  var chinchanchun = res['message'];
  print(chinchanchun);
}


Future<void> DeleteMember(String name) async {
  http.Response response = await http.delete(Uri.parse(http_deleteMember+"/$name"),);
  //接收回傳
  String resposebody = response.body;
}


