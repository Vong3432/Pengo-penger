import 'package:flutter/material.dart';
import 'package:penger/config/color.dart';
import 'package:penger/helpers/theme/custom_font.dart';

class ItemStepTile extends StatelessWidget {
  const ItemStepTile({
    Key? key,
    this.onTap,
    required this.stepNum,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
  }) : super(key: key);

  final VoidCallback? onTap;
  final int stepNum;
  final String title;
  final String subtitle;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      minLeadingWidth: 42,
      leading: Stack(
        children: [
          Container(
            width: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted ? primaryColor : Colors.transparent,
              border: Border.all(
                width: 2,
                color: isCompleted ? primaryColor : greyBgColor,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              child: Text(
                stepNum.toString(),
                style: PengoStyle.title2(context).copyWith(
                    color: onTap == null
                        ? textColor.shade300
                        : isCompleted
                            ? Colors.white
                            : textColor),
              ),
            ),
          ),
        ],
      ),
      title: Text(
        title,
        style: PengoStyle.title2(context).copyWith(
          color: onTap == null ? textColor.shade400 : textColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: PengoStyle.captionNormal(context).copyWith(
          color: onTap == null ? textColor.shade300 : textColor,
        ),
      ),
    );
  }
}
