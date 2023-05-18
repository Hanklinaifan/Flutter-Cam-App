import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterproject_second/custom/BorderBox.dart';
import 'package:flutterproject_second/custom/Showup.dart';
import 'package:flutterproject_second/utils/constants.dart';
import 'package:flutterproject_second/utils/sample_data.dart';
import 'package:flutterproject_second/utils/widget_functions.dart';
import 'package:image_picker/image_picker.dart';

class MemberScreen extends StatefulWidget {
  @override
  _MemberScreen createState() => _MemberScreen();
}

class _MemberScreen extends State<MemberScreen> {
  @override

  //手機相簿
  File? image;
  Future pickImage(Function setState, ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print("Failed because of $e");
    }
  }



  List<bool> isClick = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  bool showPosition = false;
  //當輸入字時，按鈕會消失
  bool isinput = false;
  @override
  Widget build(BuildContext context) {
    setState(() {

    });
     print('pagebuild');
//個人檔案視窗大小
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;

    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[100],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(padding),
            //家庭成員
            Padding(
              padding: sidePadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("家庭成員列表", style: themeData.textTheme.headline2),
                  GestureDetector(
                    onTap: () {
                      setState(() => image = null);
                      showAddDialog(context);
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
            addVerticalSpace(10),
            Padding(
              padding: sidePadding,
              child: Divider(
                height: padding,
                thickness: .5,
                color: Colors.brown,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: sidePadding,
                child: GestureDetector(onTap: (){print('repair');setState(() {});},child:Text('重新整理',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown,fontSize: 14),)),
              ),
            ),
addVerticalSpace(10),
//家庭成員列表
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: MEMBER_DATA.length,
                itemBuilder: (context, index) {
                  return Item(
                    setmemberState: (){
                      setState(() {

                      });
                    },
                    itemData: MEMBER_DATA[index],
                    ontap: () {
                      //  setState(() {
                      //   for (int i = 0; i < MEMBER_DATA.length; i++) {
                      //     if (i == index) {
                      //       continue;
                      //     } else {
                      //       isClick[i] = false;
                      //     }
                      //   }
                      //   isClick[index] = !isClick[index];
                      // });
                    },
                    isclick: isClick[index],
                    member_index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //新增成員function
  showAddDialog(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    bool _isinput = false;
    ImageProvider addmemimage ;

    if(image != null){
      addmemimage = FileImage(image!);
    }
    else{addmemimage = AssetImage("assets/images/01.jpg") as ImageProvider;}
    print(_isinput);
    // Init
    AlertDialog dialog = AlertDialog(
      scrollable: true,
      content: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: 250,
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 200,
                  child: Stack(children: [
                    Center(
                        child: Ink.image(
                      fit: BoxFit.cover,
                      width: 150,
                      image: image != null
                          ? FileImage(
                              image!,
                            )
                          : AssetImage("assets/images/01.jpg") as ImageProvider,
                      child: InkWell(
                        onTap: () {
                          pickImage(setState, ImageSource.gallery);
                        },
                      ),
                    )),
                    Positioned(
                        bottom: 5,
                        left: 100,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(color: Colors.grey, width: 1)),
                          height: 35,
                          width: 70,
                          child: GestureDetector(
                            onTap: () {
                              pickImage(setState, ImageSource.gallery);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add),
                                Text(
                                  "新增",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ]),
                ),
                addVerticalSpace(8),
                TextField(
                    onTap: () {
                     setState((){
                        _isinput = true;
                      });
                    },
                    onEditingComplete: () {
                      print("complete");
                      setState((){
                        _isinput = false;
                        FocusScope.of(context).unfocus();
                      });
                    },
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      labelText: "Name",
                    )),
              ],
            ),
          );
        },
      ),
      title: Text(
        "新增成員",
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      actions: [
        _isinput
            ? SizedBox.shrink()
            : MaterialButton(
                color: Color.fromRGBO(192, 176, 162, 1),
                child: Text(
                  "新增臉部辨識",
                  style: TextStyle(color: Colors.brown),
                ),
                onPressed: () {
                  // Navigator.pop(context);
                  pickImage(setState, ImageSource.camera);
                  setState(() {
                    this.image = File(image!.path);
                  });
                }),
        _isinput
            ? SizedBox.shrink()
            : MaterialButton(
                color: Color.fromRGBO(192, 176, 162, 1),
                child: Text(
                  "取消",
                  style: TextStyle(color: Colors.brown),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
      ],
    );

    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Wrap();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform(
            transform: Matrix4.translationValues(
              0.0,
              (1.0 - Curves.easeInOut.transform(anim1.value)) * 400,
              0.0,
            ),
            child: dialog);
      },
      transitionDuration: Duration(milliseconds: 300),
    );
  }
}

//家庭成員列表
class Item extends StatefulWidget {
  final dynamic itemData;
  final member_index;
  final bool isclick;
  final VoidCallback setmemberState;

  final VoidCallback ontap;
  const Item(
      {Key? key,
        required this.setmemberState,
      required this.itemData,
      required this.ontap,
      required this.member_index,
      required this.isclick})
      : super(key: key);
  @override
  _Item createState() => _Item();
}

class _Item extends State<Item> {
  @override
  Widget build(BuildContext context) {
    print('itembuild');
    int memberindex = widget.member_index + 1;

    final sidePadding = EdgeInsets.symmetric(horizontal: 25);
    final ThemeData themeData = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
//家庭成員人物按鈕
            Center(
              child: GestureDetector(
                onTap: widget.ontap,
                child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: COLOR_GREY,),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        addVerticalSpace(20),
                        Positioned(
                          top: 20,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360)),
                            height: 210,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(360.0),
                              child: Image.asset(
                                widget.itemData["image"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        addVerticalSpace(20),
                        Positioned(
                          top: 240,
                          child: Text(
                            widget.itemData["name"],
                            style: themeData.textTheme.headline1,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Positioned(
                    top: 20,
                    right: 50,
                    child: ShowUp(
                      delay: 5,
                      child: GestureDetector(
                        onTap: () {
                          showEditDialog(context);
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                  )
          ]),
        ],
      ),
    );
  }

  File? image;
  Future pickImage(Function setState, ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print("Failed because of $e");
    }
  }

  showEditDialog(BuildContext context) {
    setState(() {
      image = null;
    });
    final ThemeData themeData = Theme.of(context);
    final FocusNode _focus = FocusNode();
    // Init
    AlertDialog dialog = AlertDialog(
      scrollable: true,
      content: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: 250,
            child: Stack(
              children: [Column(
                children: [
                  Container(
                    height: 150,
                    width: 200,
                    child: Stack(children: [
                      addVerticalSpace(10),
                      Center(
                          child: Ink.image(
                            fit: BoxFit.cover,
                            width: 150,
                            image: image != null
                                ? FileImage(image!)
                                : AssetImage(widget.itemData["image"])
                            as ImageProvider,
                            child: InkWell(
                              onTap: () {
                                pickImage(setState, ImageSource.gallery);
                              },
                            ),
                          )),
                      Positioned(
                          bottom: 5,
                          left: 100,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(60),
                                border: Border.all(color: Colors.grey, width: 1)),
                            height: 35,
                            width: 70,
                            child: GestureDetector(
                              onTap: () {
                                pickImage(setState, ImageSource.gallery);
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.swap_horiz),
                                  Text(
                                    "更換",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      pickImage(setState, ImageSource.camera);
                      setState(() {
                        this.image = File(image!.path);
                      });
                    },
                    child: Text(
                      "更新臉部辨識",
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                  addVerticalSpace(8),
                  TextFormField(
                      initialValue: widget.itemData["name"],
                      decoration: InputDecoration(
                        labelText: "Name",
                      )),
                ],
              ),
              ]
            ),
          );
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "編輯成員",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          GestureDetector(
            onTap: () {
              //  刪除成員
          showDialog(context,widget.member_index,);
            },
            child: Text(
              "刪除成員",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
      actions: [
        (MediaQuery.of(context).viewInsets.bottom > 0)?
        SizedBox.shrink():
        MaterialButton(
            color: Color.fromRGBO(192, 176, 162, 1),
            child: Text(
              "儲存",
              style: TextStyle(color: Colors.brown),
            ),
            onPressed: () {
              // Navigator.pop(context);
            }),
        MaterialButton(
            color: Color.fromRGBO(192, 176, 162, 1),
            child: Text(
              "取消",
              style: TextStyle(color: Colors.brown),
            ),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );

    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Wrap();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform(
            transform: Matrix4.translationValues(
              0.0,
              (1.0 - Curves.easeInOut.transform(anim1.value)) * 400,
              0.0,
            ),
            child: dialog);
      },
      transitionDuration: Duration(milliseconds: 300),
    );
  }
  showDialog(BuildContext context,int memberindex) {
    final ThemeData themeData = Theme.of(context);
    // Init
    AlertDialog dialog = AlertDialog(
      content: Text(
          "確定要刪除此成員?"
      ),
      actions: [
        MaterialButton(
            color: Color.fromRGBO(192, 176, 162, 1),
            child: Text(
              "是",
              style: TextStyle(color: Colors.brown),
            ),
            onPressed: () {
              MEMBER_DATA.removeAt(memberindex);
              widget.setmemberState;
              Navigator.pop(context);
              Navigator.pop(context);

            }),
        MaterialButton(
            color: Color.fromRGBO(192, 176, 162, 1),
            child: Text(
              "否",
              style: TextStyle(color: Colors.brown),
            ),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );

    // Show the dialog (showDialog() => showGeneralDialog())
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Wrap();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform(
          transform: Matrix4.translationValues(
            0.0,
            (1.0 - Curves.easeInOut.transform(anim1.value)) * 400,
            0.0,
          ),
          child: dialog,
        );
      },
      transitionDuration: Duration(milliseconds: 300),
    );
  }
  // showEditDialog(BuildContext context) {
  //   final ThemeData themeData = Theme.of(context);
  //   // Init
  //   AlertDialog dialog = AlertDialog(
  //     content: Container(
  //       height: 350,
  //       child: Column(
  //         children: [
  //           Container(
  //             height: 150,
  //             width: 200,
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(25),
  //               child: Image.asset(widget.itemData["image"]),
  //             ),
  //           ),
  //           GestureDetector(
  //             child: Text(
  //               "重新掃描",
  //               style: TextStyle(color: Colors.brown),
  //             ),
  //           ),
  //           addVerticalSpace(8),
  //           Align(
  //             alignment: Alignment.topLeft,
  //             child: Column(
  //               children: [
  //                 TextField(
  //                     decoration: InputDecoration(
  //                       labelText: "Name",
  //
  //                       // border: OutlineInputBorder(
  //                       //   borderRadius: BorderRadius.circular(100),
  //                       //   borderSide: BorderSide(width: 0,style: BorderStyle.none),
  //                       // )
  //                     )),
  //                 addVerticalSpace(7),
  //                 TextField(
  //                     decoration: InputDecoration(
  //                       labelText: "Phone",
  //                     )),
  //                 addVerticalSpace(7),
  //                 TextField(
  //                   decoration: InputDecoration(
  //                     labelText: "Email",
  //                   ),
  //                 ),
  //                 //Text("Email：",style: themeData.textTheme.headline3,textAlign: TextAlign.start,)
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     title: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           "編輯成員",
  //           style: TextStyle(
  //             fontSize: 18,
  //           ),
  //         ),
  //         GestureDetector(
  //           onTap: () {
  //             //跳出確認視窗，刪除資料庫
  //           },
  //           child: Text(
  //             "刪除成員",
  //             style: TextStyle(fontSize: 12, color: Colors.redAccent),
  //           ),
  //         )
  //       ],
  //     ),
  //     actions: [
  //       MaterialButton(
  //           color: Color.fromRGBO(192, 176, 162, 1),
  //           child: Text(
  //             "儲存",
  //             style: TextStyle(color: Colors.brown),
  //           ),
  //           onPressed: () {
  //             Navigator.pop(context);
  //           }),
  //       MaterialButton(
  //           color: Color.fromRGBO(192, 176, 162, 1),
  //           child: Text(
  //             "取消",
  //             style: TextStyle(color: Colors.brown),
  //           ),
  //           onPressed: () {
  //             Navigator.pop(context);
  //           })
  //     ],
  //   );
  //
  //   // Show the dialog (showDialog() => showGeneralDialog())
  //   showGeneralDialog(
  //     context: context,
  //     pageBuilder: (context, anim1, anim2) {
  //       return Wrap();
  //     },
  //     transitionBuilder: (context, anim1, anim2, child) {
  //       return Transform(
  //         transform: Matrix4.translationValues(
  //           0.0,
  //           (1.0 - Curves.easeInOut.transform(anim1.value)) * 400,
  //           0.0,
  //         ),
  //         child: dialog,
  //       );
  //     },
  //     transitionDuration: Duration(milliseconds: 300),
  //   );
  // }
}
//
// showEditDialog(BuildContext context) {
//   final ThemeData themeData = Theme.of(context);
//   // Init
//   AlertDialog dialog = AlertDialog(
//     content: Container(
//       height: 350,
//       child: Column(
//         children: [
//           Container(
//             height: 150,
//             width: 200,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(25),
//               child: Image.asset(theif),
//             ),
//           ),
//           GestureDetector(
//             child: Text(
//               "重新掃描",
//               style: TextStyle(color: Colors.brown),
//             ),
//           ),
//           addVerticalSpace(8),
//           Align(
//             alignment: Alignment.topLeft,
//             child: Column(
//               children: [
//                 TextField(
//                     decoration: InputDecoration(
//                   labelText: "Name",
//
//                   // border: OutlineInputBorder(
//                   //   borderRadius: BorderRadius.circular(100),
//                   //   borderSide: BorderSide(width: 0,style: BorderStyle.none),
//                   // )
//                 )),
//                 addVerticalSpace(7),
//                 TextField(
//                     decoration: InputDecoration(
//                   labelText: "Phone",
//                 )),
//                 addVerticalSpace(7),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: "Email",
//                   ),
//                 ),
//                 //Text("Email：",style: themeData.textTheme.headline3,textAlign: TextAlign.start,)
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//     title: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           "編輯成員",
//           style: TextStyle(
//             fontSize: 18,
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             //跳出確認視窗，刪除資料庫
//           },
//           child: Text(
//             "刪除成員",
//             style: TextStyle(fontSize: 12, color: Colors.redAccent),
//           ),
//         )
//       ],
//     ),
//     actions: [
//       MaterialButton(
//           color: Color.fromRGBO(192, 176, 162, 1),
//           child: Text(
//             "儲存",
//             style: TextStyle(color: Colors.brown),
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           }),
//       MaterialButton(
//           color: Color.fromRGBO(192, 176, 162, 1),
//           child: Text(
//             "取消",
//             style: TextStyle(color: Colors.brown),
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           })
//     ],
//   );
//
//   // Show the dialog (showDialog() => showGeneralDialog())
//   showGeneralDialog(
//     context: context,
//     pageBuilder: (context, anim1, anim2) {
//       return Wrap();
//     },
//     transitionBuilder: (context, anim1, anim2, child) {
//       return Transform(
//         transform: Matrix4.translationValues(
//           0.0,
//           (1.0 - Curves.easeInOut.transform(anim1.value)) * 400,
//           0.0,
//         ),
//         child: dialog,
//       );
//     },
//     transitionDuration: Duration(milliseconds: 300),
//   );
// }

// showAddDialog(BuildContext context) {
//   File? image;
//
//   Future pickImage() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if(image == null) return;
//
//       final imageTemp = File(image.path);
//
//
//     } on PlatformException catch (e) {
//       print("Failed because of $e");
//     }
//   }
//   final ThemeData themeData = Theme.of(context);
//   // Init
//   AlertDialog dialog = AlertDialog(
//     content: Container(
//       height: 350,
//       child: Column(
//         children: [
//           Container(
//             height: 150,
//             width: 200,
//
//             child: Stack(children: [
//               Center(child:
//              Ink.image(
//                width: 150,
//                image: image != null ? FileImage(image!) : AssetImage(theif) as ImageProvider,
//                child: InkWell(
//                  onTap: () => pickImage(),
//                ),
//                   )),
//               Positioned(
//                   bottom: 0,
//                   child: Container(
//                     decoration: BoxDecoration(color: Colors.white,
//                     borderRadius: BorderRadius.circular(60),
//                     border: Border.all(color: Colors.grey,width: 1)),
//                     width: 100,
//                     height: 30,
//                     child: GestureDetector(
//                       onTap: (){},
//                       child: Center(child: Row(children: [Icon(Icons.add),Text("上傳成員圖片",style: TextStyle(fontSize: 12,color: Colors.black),
//                       )],)),
//                     ),
//                   )),
//             ]),
//           ),
//           addVerticalSpace(8),
//           Align(
//             alignment: Alignment.topLeft,
//             child: Column(
//               children: [
//                 TextField(
//                     decoration: InputDecoration(
//                   labelText: "Name",
//
//                   // border: OutlineInputBorder(
//                   //   borderRadius: BorderRadius.circular(100),
//                   //   borderSide: BorderSide(width: 0,style: BorderStyle.none),
//                   // )
//                 )),
//                 addVerticalSpace(7),
//                 TextField(
//                     decoration: InputDecoration(
//                   labelText: "Phone",
//                 )),
//                 addVerticalSpace(7),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: "Email",
//                   ),
//                 ),
//                 //Text("Email：",style: themeData.textTheme.headline3,textAlign: TextAlign.start,)
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//     title: Text(
//       "新增成員",
//       style: TextStyle(
//         fontSize: 18,
//       ),
//     ),
//     actions: [
//       MaterialButton(
//           color: Color.fromRGBO(192, 176, 162, 1),
//           child: Text(
//             "新增臉部辨識",
//             style: TextStyle(color: Colors.brown),
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           }),
//       MaterialButton(
//           color: Color.fromRGBO(192, 176, 162, 1),
//           child: Text(
//             "取消",
//             style: TextStyle(color: Colors.brown),
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           })
//     ],
//   );
//
//   // Show the dialog (showDialog() => showGeneralDialog())
//   showGeneralDialog(
//     context: context,
//     pageBuilder: (context, anim1, anim2) {
//       return Wrap();
//     },
//     transitionBuilder: (context, anim1, anim2, child) {
//       return Transform(
//         transform: Matrix4.translationValues(
//           0.0,
//           (1.0 - Curves.easeInOut.transform(anim1.value)) * 400,
//           0.0,
//         ),
//         child: dialog,
//       );
//     },
//     transitionDuration: Duration(milliseconds: 300),
//   );
// }

// showDialog(BuildContext context,int memberindex) {
//   final ThemeData themeData = Theme.of(context);
//   // Init
//   AlertDialog dialog = AlertDialog(
//     content: Text(
//       "確定要刪除此成員?"
//     ),
//     actions: [
//       MaterialButton(
//           color: Color.fromRGBO(192, 176, 162, 1),
//           child: Text(
//             "是",
//             style: TextStyle(color: Colors.brown),
//           ),
//           onPressed: () {
//             MEMBER_DATA.removeAt(memberindex);
//             Navigator.pop(context);
//             Navigator.pop(context);
//           }),
//       MaterialButton(
//           color: Color.fromRGBO(192, 176, 162, 1),
//           child: Text(
//             "否",
//             style: TextStyle(color: Colors.brown),
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           })
//     ],
//   );
//
//   // Show the dialog (showDialog() => showGeneralDialog())
//   showGeneralDialog(
//     context: context,
//     pageBuilder: (context, anim1, anim2) {
//       return Wrap();
//     },
//     transitionBuilder: (context, anim1, anim2, child) {
//       return Transform(
//         transform: Matrix4.translationValues(
//           0.0,
//           (1.0 - Curves.easeInOut.transform(anim1.value)) * 400,
//           0.0,
//         ),
//         child: dialog,
//       );
//     },
//     transitionDuration: Duration(milliseconds: 300),
//   );
// }
