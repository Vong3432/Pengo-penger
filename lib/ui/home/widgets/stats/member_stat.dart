import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penger/bloc/pengers/penger_repo.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/icon_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/ui/home/widgets/stats/stat.dart';
import 'package:penger/ui/staff/staff_list_page.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class MemberStat extends StatefulWidget {
  const MemberStat({Key? key}) : super(key: key);

  @override
  _MemberStatState createState() => _MemberStatState();
}

class _MemberStatState extends State<MemberStat> {
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
              builder: (BuildContext context) => StaffListPage(),
            ),
          )
          .then((_) => setState(() {})),
      child: Stat(
        icon: SvgPicture.asset(
          MEMBERS_ICON_PATH,
          color: blueColor,
        ),
        body: Text(
          "Members",
          style: PengoStyle.title(context),
        ),
        footer: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Total",
              style: PengoStyle.captionNormal(context).copyWith(
                color: secondaryTextColor,
              ),
            ),
            FutureBuilder<int>(
              future: PengerRepo().fetchTotalStaffStat(),
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    "${snapshot.data} staff",
                    style: PengoStyle.caption(context),
                  );
                }
                return const SkeletonText(height: 18);
              },
            ),
          ],
        ),
        color: blueColor,
      ),
    );
  }
}
