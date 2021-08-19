import 'package:flutter/material.dart';
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
  }) : super(key: key);

  final String label;
  final String hintText;
  final void Function(String value)? onChanged;
  final bool? obsecureText;
  final bool? readOnly;
  final TextInputType? inputType;
  final TextInputAction? inputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: PengoStyle.title2(context).copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          obscureText: obsecureText ?? false,
          onChanged: onChanged,
          readOnly: readOnly ?? false,
          textInputAction: inputAction,
          keyboardType: inputType,
          decoration: InputDecoration(hintText: hintText),
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
      ],
    );
  }
}
