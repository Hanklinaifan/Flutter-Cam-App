import 'package:flutter/material.dart';
import 'package:flutterproject_second/utils/constants.dart';


class BorderBox extends StatelessWidget {

  final Widget child;
  final EdgeInsets? padding;
  final double? width, height;

  const BorderBox({super.key,  this.padding, this.width, this.height, required this.child});

  //這裡不一樣



  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        //color:  COLOR_WHITE,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.brown.withAlpha(80),width: 1.5)
      ),
      padding: padding ,
      child: child,
    );

  }
}
