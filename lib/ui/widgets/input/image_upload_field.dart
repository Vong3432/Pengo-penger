import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/space_const.dart';

class ImageUploadField extends StatelessWidget {
  const ImageUploadField(
      {Key? key,
      this.height,
      this.color,
      required this.onTap,
      this.filePath,
      this.url})
      : super(key: key);

  final double? height;
  final Color? color;
  final VoidCallback onTap;
  final String? filePath;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: height ?? 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color ?? greyBgColor,
            ),
            child: _buildImg(context),
          ),
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
      ],
    );
  }

  Widget _buildImg(BuildContext context) {
    if (filePath != null) {
      return Image.file(
        File(filePath!),
        fit: BoxFit.cover,
      );
    }

    if (url != null) {
      return Image.network(url!);
    }

    return const Icon(Icons.upload_file_outlined);
  }
}
