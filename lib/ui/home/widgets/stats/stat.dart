import 'package:flutter/material.dart';
import 'package:penger/config/color.dart';
import 'package:penger/config/shadow.dart';

class Stat extends StatefulWidget {
  const Stat({
    Key? key,
    required this.icon,
    required this.body,
    required this.footer,
    required this.color,
  }) : super(key: key);

  final Widget icon;
  final Widget body;
  final Widget footer;

  /// will be set with opacity 0.15
  final Color color;

  @override
  _StatState createState() => _StatState();
}

class _StatState extends State<Stat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: normalShadow(
          Theme.of(context),
        ),
        color: whiteColor,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 37,
            height: 37,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color.withOpacity(0.15),
            ),
            clipBehavior: Clip.hardEdge,
            child: widget.icon,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: widget.body,
            ),
          ),
          widget.footer,
        ],
      ),
    );
  }
}
