import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';


//url網址
final String comurl = "http://211.21.74.23:8000";
final String localurl = "http://172.20.10.11:8000";
//final String comurl = "http://140.118.110.201:8080";


//MEMBER
//取得所有Member
final String http_getMember = comurl+"/member/getAll";

//新增成員
final String http_addMember = comurl+"/member/add";

//編輯成員
final String http_editMember = comurl+"/member/edit";

//刪除成員
final String http_deleteMember = comurl+"/member/delete";


//SUS
//取得ALLSUS
final String http_getAllSus = comurl+"/sus/get/all";

//取得SUSVID
final String http_getSusvid = comurl+"/sus/get/video";

//取得SUSIMG
final String http_getSusimg = comurl+"/sus/get/image";


//CAM
//取得CAM
final String http_getCam = comurl+"/server/camera/info";
//新增CAM
final String http_addCam = localurl+"/camera/add";
//刪除CAM
final String http_deleteCam = localurl+"/camera/delete";