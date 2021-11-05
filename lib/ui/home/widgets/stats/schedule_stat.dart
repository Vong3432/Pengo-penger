import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penger/bloc/pengers/penger_repo.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/icon_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/ui/close-date/close_date_list_page.dart';
import 'package:penger/ui/home/widgets/stats/stat.dart';
import 'package:penger/ui/staff/staff_list_page.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class ScheduleStat extends StatefulWidget {
  const ScheduleStat({Key? key}) : super(key: key);

  @override
  _ScheduleStatState createState() => _ScheduleStatState();
}

class _ScheduleStatState extends State<ScheduleStat> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context, rootNavigator: true)
          .push(
            CupertinoPageRoute(
              builder: (BuildContext context) => CloseDateListPage(),
            ),
          )
          .then((_) => setState(() {})),
      child: Stat(
        icon: SvgPicture.asset(
          CALENDAR_ICON_PATH,
          color: secondaryTextColor,
        ),
        body: Text(
          "Schedule",
          style: PengoStyle.title(context),
        ),
        footer: Container(),
        color: secondaryTextColor,
      ),
    );
  }
}
