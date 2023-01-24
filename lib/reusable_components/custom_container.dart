import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Color? containerColor;
  final Color? textColor;
  final String? text;
  bool? isBorderRadius;
  final Function? onPressed;
  bool? isButton;
  bool? isIcon;
  final double width;
  final double height;
  final Color? backgroundColor;
  final IconData? icon;
  double? radius;
  double? padding;
 final double? textSize;
  none() {}

  CustomContainer(
      {Key? key,

        this.radius,
      this.containerColor,
      this.textColor,
      this.text,
      this.isBorderRadius = false,
      this.onPressed,
      this.isButton = false,
      this.isIcon = false,
      this.padding = 0,
      this.icon,
      required this.width,
      required this.height,
      this.backgroundColor, this.textSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isButton == true ? onPressed : none(),
      child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.all(padding!),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: containerColor,
              borderRadius: isBorderRadius == true
                  ? BorderRadius.circular(radius!)
                  : null),
          child: isIcon == false
              ? Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: TextStyle(backgroundColor: backgroundColor ,  color: textColor , fontSize: textSize),
                )
              : Icon(icon)),
    );
  }
}
