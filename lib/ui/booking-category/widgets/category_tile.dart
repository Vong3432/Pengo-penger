import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:penger/config/color.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/models/booking_category_model.dart';

class CategoryListTile extends StatefulWidget {
  const CategoryListTile(
      {Key? key, required this.category, required this.onTap})
      : super(key: key);
  final BookingCategory category;
  final VoidCallback onTap;

  @override
  State<CategoryListTile> createState() => _CategoryListTileState();
}

class _CategoryListTileState extends State<CategoryListTile> {
  late bool _shouldEnable;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _shouldEnable = widget.category.isEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.category.name,
        style: PengoStyle.title(context),
      ),
      subtitle: Text(
        widget.category.bookingItems == null ||
                widget.category.bookingItems?.isEmpty == true
            ? "No related item"
            : "${widget.category.bookingItems!.length} related items",
        style: PengoStyle.subtitle(context).copyWith(
          color: secondaryTextColor,
        ),
      ),
      trailing: CupertinoSwitch(
        value: _shouldEnable,
        onChanged: (bool value) {
          setState(() {
            _shouldEnable = value;
          });
        },
      ),
      onTap: widget.onTap,
    );
  }
}
