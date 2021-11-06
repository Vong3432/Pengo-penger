import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penger/const/icon_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/ui/close-date/close_date_list_page.dart';
import 'package:penger/ui/home/widgets/stats/stat.dart';
import 'package:penger/ui/payout/payout_view.dart';

class EarningStat extends StatefulWidget {
  const EarningStat({Key? key}) : super(key: key);

  @override
  _EarningStatState createState() => _EarningStatState();
}

class _EarningStatState extends State<EarningStat> {
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
              builder: (BuildContext context) => PayoutView(),
            ),
          )
          .then((_) => setState(() {})),
      child: Stat(
        icon: SvgPicture.asset(
          MONEY_ICON_PATH,
          color: Colors.amber,
        ),
        body: Text(
          "Earning",
          style: PengoStyle.title(context),
        ),
        footer: Container(),
        color: Colors.amber,
      ),
    );
  }
}
