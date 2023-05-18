import 'package:flutterproject_second/utils/http.dart';

List<Map<String, dynamic>> MEMBER_DATA = [
  {
    //資料庫資料，如圖片之類的
    "image":"assets/images/Theif.png",
    "name":"Hank"
  },
  {
    "image":"assets/images/Theif2.png",
    "name":"Andy"
  },

  {
    "image":"assets/images/Theif.png",
    "name":"Bob"

  },
  {
    //資料庫資料，如圖片之類的
    "image":"assets/images/01.jpg",
    "name":"Cathy"
  },
  {
    "image":"assets/images/02.jpg",
    "name":"Dormane"
  },

  {
    "image":"assets/images/03.jpg",
    "name":"Ethon"

  },
  {
    //資料庫資料，如圖片之類的
    "image":"assets/images/04.jpg",
    "name":"Frank"
  },

];



List<Map<String, dynamic>> IMG_DATA = [

  {
  //資料庫資料，如圖片之類的
    "image":"assets/images/01.jpg",
    "time":"2023/5/9",
    "place":"room1",
    "id": 0,
  },
  {
    "image":"assets/images/02.jpg",
    "id": 1,
    "time":"2023/6/9",
    "place":"room11",
  },

  {
    "image":"assets/images/03.jpg",
    "id": 2,
    "time":"2023/1/9",
    "place":"room4",

  },
  {
    //資料庫資料，如圖片之類的
    "image":"assets/images/04.jpg",
    "id": 0,
    "time":"2023/2/9",
    "place":"room5",
  },
  {
    "image":"assets/images/05.jpg",
    "id": 1,
    "time":"2023/1/9",
    "place":"room5",
  },

  {
    "image":"assets/images/06.jpg",
    "id": 2,
    "time":"2023/2/9",
    "place":"room8",

  },
  {
    //資料庫資料，如圖片之類的
    "image":"assets/images/07.jpg",
    "id": 0,
    "time":"2023/1/9",
    "place":"room7",
  },
  {
    "image":"assets/images/08.jpg",
    "id": 1,
    "time":"2023/3/9",
    "place":"room6",
  },

  {
    "image":"assets/images/09.jpg",
    "id": 2,
    "time":"2023/6/9",
    "place":"room2",

  },
  {
    //資料庫資料，如圖片之類的
    "image":"assets/images/10.jpg",
    "id": 0,
    "time":"2023/5/9",
    "place":"room1",
  },


];

List<Map<String, dynamic>> ROOM_DATA = [
  {
    //資料庫資料，如圖片之類的
    "image":"assets/images/10.jpg",
    "room":"客廳"
  },
  {
    "image":"assets/images/09.jpg",
    "room":"廚房"
  },

  {
    "image":"assets/images/08.jpg",
    "room":"房間1"
  },

  {
    "image":"assets/images/07.jpg",
    "room":"房間2"
  },
  {
    "image":"assets/images/06.jpg",
    "room":"房間3"
  },

];

//getHTTPDATA
Future<List<Map<String, dynamic>>> HTTP_DATA = getJson().then((value) => [value]);



