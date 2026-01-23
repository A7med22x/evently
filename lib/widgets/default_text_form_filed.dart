import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultTextFormFiled extends StatefulWidget {
  String hintText;
  String? prefixIconImageName;
  String? suffixIconImageName;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  TextEditingController? controller;
  bool isPassword;
  int maxLines;

  DefaultTextFormFiled({
    required this.hintText,
    this.prefixIconImageName,
    this.suffixIconImageName,
    this.controller,
    this.onChanged,
    this.validator,
    this.isPassword = false,
    this.maxLines = 1,
  });

  @override
  State<DefaultTextFormFiled> createState() => _DefaultTextFormFiledState();
}

class _DefaultTextFormFiledState extends State<DefaultTextFormFiled> {
  late bool isObscure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIconImageName == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  'assets/icons/${widget.prefixIconImageName}.svg',
                ),
              ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isObscure = !isObscure;
                  setState(() {});
                },
                icon: Icon(
                  isObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppTheme.grey,
                ),
              )
            : widget.suffixIconImageName == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  'assets/icons/${widget.suffixIconImageName}.svg',
                ),
              ),
      ),
      onChanged: widget.onChanged,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: isObscure,
      autovalidateMode: .onUserInteraction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      maxLines: widget.maxLines,
    );
  }
}
