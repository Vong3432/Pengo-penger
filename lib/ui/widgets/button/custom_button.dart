import 'package:flutter/material.dart';
import 'package:penger/config/color.dart';
import 'package:penger/config/shadow.dart';
import 'package:penger/helpers/theme/custom_font.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.backgroundColor,
    this.color,
    this.minimumSize,
    this.isLoading,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget text;
  final Color? backgroundColor;
  final Color? color;
  final Size? minimumSize;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(child: CircularProgressIndicator())
        : GestureDetector(
            onTap: onPressed,
            child: Container(
              width: minimumSize?.width ?? double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: backgroundColor ?? primaryColor,
                boxShadow: normalShadow(Theme.of(context)),
              ),
              child: DefaultTextStyle(
                textAlign: TextAlign.center,
                style: PengoStyle.caption(context).copyWith(
                  color: whiteColor,
                ),
                child: text,
              ),
            ),
          );
  }
}
