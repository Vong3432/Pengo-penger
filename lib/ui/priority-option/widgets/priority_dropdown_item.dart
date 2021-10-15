import 'package:flutter/material.dart';

class PriorityOptionDropdownItem extends StatelessWidget {
  const PriorityOptionDropdownItem({Key? key, required this.value})
      : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(value),
    );
  }
}
