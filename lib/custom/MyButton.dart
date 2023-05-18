import 'package:flutter/material.dart';
import 'package:flutterproject_second/utils/constants.dart';

class MyButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final double textsize;
  final double height;
  const MyButton({Key? key, required this.text, required this.iconData, required this.textsize, required this.height,required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;



  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return MaterialButton(
      height: height,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              iconData,
              color: Colors.black45,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.black45,fontSize: textsize),
            ),
          ],
        ),
        onPressed: onPressed,
    );
  }
}