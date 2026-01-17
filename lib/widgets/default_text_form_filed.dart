import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultTextFormFiled extends StatelessWidget {
  String hintText;
  String? prefixIconImageName;
  String? suffixIconImageName;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  TextEditingController? controller;

  DefaultTextFormFiled({
    required this.hintText,
    this.prefixIconImageName,
    this.suffixIconImageName,
    this.controller,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIconImageName == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  'assets/icons/$prefixIconImageName.svg',
                ),
              ),
        suffixIcon: suffixIconImageName == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  'assets/icons/$suffixIconImageName.svg',
                ),
              ),
      ),
      onChanged: onChanged,
      controller: controller,
    );
  }
}
