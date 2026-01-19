import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
  Function() onPressed;
  String label;
  double? width;
  double? height;
  double? fontSize;
  FontWeight? fontWeight;
  Color? backgroundColor;
  Color? foregroundColor;


  DefaultElevatedButton({
    required this.label,
    required this.onPressed,
    this.width,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        fixedSize: Size(
          width ?? MediaQuery.sizeOf(context).width,
          height ?? 48,
        ),
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight, 
        )
      ),
      child: Text(label),
    );
  }
}
