import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class CustomText extends StatelessWidget {
 String? text;
 Color? color;
 Color? backgroundColor;
 double? fontSize;
CustomText({super.key , required this.text ,this.color , this.backgroundColor , this.fontSize });
  @override
  Widget build(BuildContext context) {
    return Text(text! ,style: TextStyle(color: color?? Colors.black , backgroundColor:backgroundColor?? Colors.white , fontSize:fontSize??12 , ) );
  }
}
