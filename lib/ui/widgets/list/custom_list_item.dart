import 'package:flutter/material.dart';
import 'package:penger/config/color.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key? key,
    required this.leading,
    required this.content,
    this.onTap,
  }) : super(key: key);

  final Widget leading;
  final List<Widget> content;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: primaryLightColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: leading,
            clipBehavior: Clip.hardEdge,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content,
            ),
          ),
        ],
      ),
    );
  }
}
