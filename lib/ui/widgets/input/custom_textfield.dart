import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.label,
    required this.hintText,
    this.onChanged,
    this.obsecureText,
    this.readOnly,
    this.inputType,
    this.inputAction,
    this.validator,
    this.controller,
    this.lblStyle,
    this.contentPadding,
    this.decoration,
    this.inputFormatters,
  }) : super(key: key);

  final String label;
  final String hintText;
  final void Function(String value)? onChanged;
  final bool? obsecureText;
  final bool? readOnly;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextStyle? lblStyle;
  final EdgeInsetsGeometry? contentPadding;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: lblStyle ??
              PengoStyle.title2(context).copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obsecureText ?? false,
          onChanged: onChanged,
          readOnly: readOnly ?? false,
          textInputAction: inputAction,
          keyboardType: inputType,
          inputFormatters: inputFormatters,
          decoration: decoration == null
              ? InputDecoration(
                  hintText: hintText,
                  contentPadding: contentPadding,
                )
              : decoration,
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
      ],
    );
  }
}
