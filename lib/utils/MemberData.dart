import 'dart:io';
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


Future<void> addMember(String name,File image,File avatar) async {

  var baseimage = image; //turn into base64
  var baseavtar = avatar; //turn into base64
  Map<String,dynamic> mdata = {
    "name" : name,
    "image" : baseimage,
    "avatar" : baseavtar,
  };
  final encode_mdata = json.encode(mdata);
  final encoding = Encoding.getByName('utf-8');


  http.Response response = await http.post(Uri.parse(http_addMember),

    headers: {
      //need to set headers ex :
      // "Accept": "application/json",
      // "Content-Type": "application/x-www-form-urlencoded"
    },
    body: encode_mdata,
    encoding: encoding,
  );

  //接收回傳
  String resposebody = response.body;

}

Future<void> editMember(String oldname,String name, String image, String avatar) async {

  var baseimage = image; //turn into base64
  var baseavtar = avatar; //turn into base64
  Map<String,dynamic> mdata = {
    "name" : name,
    "image" : baseimage,
    "avatar" : baseavtar,
  };
  final encode_mdata = json.encode(mdata);
  final encoding = Encoding.getByName('utf-8');

  http.Response response = await http.put(Uri.parse(http_editMember + "/$oldname"),

    headers: {
      //need to set headers ex :
      // "Accept": "application/json",
      // "Content-Type": "application/x-www-form-urlencoded"
    },
    body: encode_mdata,
    encoding: encoding,
  );

  //接回傳
}


Future<void> DeleteMember(String name) async {
  http.Response response = await http.delete(Uri.parse(http_deleteMember+"/$name"),);
  //接收回傳
  String resposebody = response.body;
}


