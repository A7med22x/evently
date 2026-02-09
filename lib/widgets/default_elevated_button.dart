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
  Color? border;
  String? icon;

  DefaultElevatedButton({
    required this.label,
    required this.onPressed,
    this.width,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.backgroundColor,
    this.foregroundColor,
    this.border,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        side: border == null ? null : BorderSide(color: border!),
        fixedSize: Size(
          width ?? MediaQuery.sizeOf(context).width,
          height ?? 48,
        ),
        textStyle: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      ),
      child: (icon == null)
          ? Text(label)
          : Row(
              mainAxisAlignment: .center,
              children: [
                Image.asset(
                  'assets/images/$icon.png',
                  width: 24,
                  height: 24,
                  fit: .scaleDown,
                ),
                SizedBox(width: 16),
                Text(label),
              ],
            ),
    );
  }
}
