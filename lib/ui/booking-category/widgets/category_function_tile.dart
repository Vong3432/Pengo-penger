import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/icon_const.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/const/text_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/models/system_function_model.dart';

class CategoryFunctionTile extends StatefulWidget {
  const CategoryFunctionTile({
    Key? key,
    required this.systemFunction,
    this.matchedOption,
    required this.onSwitchChanged,
  }) : super(key: key);
  final SystemFunction systemFunction;
  final SystemFunction? matchedOption;
  final ValueSetter<bool> onSwitchChanged;

  @override
  _CategoryFunctionTileState createState() => _CategoryFunctionTileState();
}

class _CategoryFunctionTileState extends State<CategoryFunctionTile> {
  bool? isActive;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isActive = widget.matchedOption != null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            widget.systemFunction.name,
            style: PengoStyle.title2(context),
          ),
          subtitle: Text(
            widget.systemFunction.description,
            style: PengoStyle.smallerText(context)
                .copyWith(color: secondaryTextColor),
          ),
          trailing: widget.systemFunction.isActive
              ? CupertinoSwitch(
                  value: isActive ?? false,
                  onChanged: (bool val) {
                    setState(() {
                      isActive = val;
                    });
                    widget.onSwitchChanged(val);
                  },
                )
              : Text(
                  "COMING SOON",
                  style: PengoStyle.caption(context).copyWith(
                    color: secondaryTextColor,
                  ),
                ),
        ),
        const SizedBox(height: SECTION_GAP_HEIGHT / 2),
        if (widget.systemFunction.isActive)
          Row(
            children: <Widget>[
              SvgPicture.asset(
                MONEY_ICON_PATH,
                width: 21,
                fit: BoxFit.scaleDown,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.systemFunction.isPremium
                      ? "RM ${widget.systemFunction.price!.toStringAsFixed(2)} per $MONTH_TEXT"
                      : FREE_TEXT,
                  style: PengoStyle.caption(context),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
