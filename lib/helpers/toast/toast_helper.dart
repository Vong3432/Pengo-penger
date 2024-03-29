import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:penger/config/color.dart';

void showToast({
  required String msg,
  ToastGravity? gravity,
  Toast? toast,
  Color? backgroundColor,
  Color? textColor,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: toast ?? Toast.LENGTH_LONG,
    gravity: gravity ?? ToastGravity.BOTTOM,
    backgroundColor: backgroundColor ?? dangerColor,
    textColor: textColor ?? whiteColor,
    fontSize: 16.0,
  );
}
