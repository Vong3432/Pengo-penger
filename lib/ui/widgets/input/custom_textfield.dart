import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.label,
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
    this.isOptional,
    this.sideNote,
    this.onSaved,
    this.onTap,
    this.onEditingComplete,
    this.maxLines,
  }) : super(key: key);

  final String? label;
  final String hintText;
  final void Function(String value)? onChanged;
  final void Function(String? value)? onSaved;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
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
  final bool? isOptional;
  final Text? sideNote;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            if (label != null)
              Text(
                label!,
                style: lblStyle ?? PengoStyle.caption(context),
              ),
            if (label != null) const Spacer(),
            if (isOptional == true)
              Text(
                "(optional)",
                style: PengoStyle.subcaption(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColor.withOpacity(0.5),
                ),
              )
            else
              Container()
          ],
        ),
        if (label != null)
          const SizedBox(
            height: 10,
          ),
        TextFormField(
          maxLines: maxLines ?? 1,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          controller: controller,
          validator: validator,
          onSaved: onSaved,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
        sideNote ?? Container(),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
      ],
    );
  }
}
