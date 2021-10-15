import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';
import 'package:penger/ui/priority-option/widgets/priority_dropdown_outer_view.dart';

class PriorityFieldBox<T> extends StatelessWidget {
  const PriorityFieldBox({
    Key? key,
    this.onItemSelected,
    required this.items,
    required this.itemBuilder,
    this.currValue,
  }) : super(key: key);

  final MenuItemSelected<T>? onItemSelected;
  final List<T> items;
  final Widget Function(T) itemBuilder;
  final String? currValue;

  @override
  Widget build(BuildContext context) {
    return MenuButton<T>(
      items: items,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0,
          color: Colors.transparent,
        ),
      ),
      menuButtonBackgroundColor: Colors.transparent,
      itemBuilder: itemBuilder,
      onItemSelected: onItemSelected,
      child: PriorityDropdownOuterView(
        value: currValue,
      ),
    );
  }
}
