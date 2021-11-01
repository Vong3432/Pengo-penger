import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/icon_const.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/models/penger_model.dart';
import 'package:penger/models/providers/auth_model.dart';
import 'package:penger/ui/home/widgets/penger_listing_view.dart';
import 'package:provider/provider.dart';

class CurrentPengerHighlight extends StatelessWidget {
  const CurrentPengerHighlight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(
          SELECTED_PENGER_ICON_PATH,
          color: secondaryTextColor,
        ),
        const SizedBox(
          width: SECTION_GAP_HEIGHT,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Current penger",
              style: PengoStyle.smallerText(context).copyWith(
                color: secondaryTextColor,
              ),
            ),
            Consumer<AuthModel>(
              builder: (BuildContext context, AuthModel model, _) {
                return Text(
                  model.user?.selectedPenger?.name ?? "-",
                  style: PengoStyle.title(context).copyWith(
                    color: textColor,
                  ),
                );
              },
            ),
          ],
        ),
        const Spacer(),
        CupertinoButton(
          child: Text(
            "Change",
            style: PengoStyle.caption(context).copyWith(
              color: primaryColor,
            ),
          ),
          onPressed: () => _viewPengerList(context),
        )
      ],
    );
  }

  void _viewPengerList(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<Widget>(
        builder: (BuildContext context) => const PengerListingView(),
      ),
    );
  }
}
