import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penger/bloc/pengers/penger_repo.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/icon_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/ui/home/widgets/stats/stat.dart';
import 'package:penger/ui/records/booking_records_view.dart';
import 'package:penger/ui/staff/staff_list_page.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class TodayStat extends StatefulWidget {
  const TodayStat({Key? key}) : super(key: key);

  @override
  _TodayStatState createState() => _TodayStatState();
}

class _TodayStatState extends State<TodayStat> {
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
              builder: (BuildContext context) => const BookingRecordsPage(),
            ),
          )
          .then((_) => setState(() {})),
      child: Stat(
        icon: SvgPicture.asset(
          TODAY_ICON_PATH,
          color: primaryColor,
        ),
        body: Text(
          "Today",
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
              future: PengerRepo().fetchTotalBookingToday(),
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    "${snapshot.data} booking",
                    style: PengoStyle.caption(context),
                  );
                }
                return const SkeletonText(height: 18);
              },
            ),
          ],
        ),
        color: primaryColor,
      ),
    );
  }
}
