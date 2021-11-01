import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/icon_const.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/models/providers/auth_model.dart';
import 'package:penger/ui/auth/login_view.dart';
import 'package:penger/ui/profile/profile_info.dart';
import 'package:penger/ui/profile/setting_view.dart';
import 'package:penger/ui/widgets/layout/sliver_appbar.dart';
import 'package:penger/ui/widgets/layout/sliver_body.dart';
import 'package:penger/ui/widgets/list/custom_list_item.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            title: Text(
              "Profile",
              style: PengoStyle.navigationTitle(context),
            ),
          ),
          CustomSliverBody(
            content: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: <Widget>[
                    _buildProfileInfo(context),
                    _buildAccountSection(context),
                    _buildActionSection(context)
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: SECTION_GAP_HEIGHT * 1.5,
        ),
        Text(
          "Actions",
          style: PengoStyle.header(context),
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
        CustomListItem(
          onTap: () {
            context.read<AuthModel>().logoutUser();
            Navigator.of(context, rootNavigator: true).push(
              CupertinoPageRoute(
                builder: (BuildContext context) => LoginPage(),
              ),
            );
          },
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: primaryLightColor,
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(PROFILE_ICON_PATH, fit: BoxFit.scaleDown),
          ),
          content: <Widget>[
            Text(
              "Logout",
              style: PengoStyle.title2(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: SECTION_GAP_HEIGHT * 1.5,
        ),
        Text(
          "Account",
          style: PengoStyle.header(context),
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
        CustomListItem(
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: primaryLightColor,
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(PROFILE_ICON_PATH, fit: BoxFit.scaleDown),
          ),
          content: <Widget>[
            Text(
              "Edit profile",
              style: PengoStyle.title2(context),
            ),
            Text(
              "Update personal info",
              style: PengoStyle.smallerText(context)
                  .copyWith(color: grayTextColor),
            ),
          ],
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
        CustomListItem(
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: primaryLightColor,
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(COUPON_ICON_PATH, fit: BoxFit.scaleDown),
          ),
          content: <Widget>[
            Text(
              "My rewards",
              style: PengoStyle.title2(context),
            ),
            Text(
              "View vouchers",
              style: PengoStyle.smallerText(context)
                  .copyWith(color: grayTextColor),
            ),
          ],
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
        CustomListItem(
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: primaryLightColor,
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(REPORT_ICON_PATH, fit: BoxFit.scaleDown),
          ),
          content: <Widget>[
            Text(
              "Feedback",
              style: PengoStyle.title2(context),
            ),
            Text(
              "Report defects or suggestion",
              style: PengoStyle.smallerText(context)
                  .copyWith(color: grayTextColor),
            ),
          ],
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
        CustomListItem(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              CupertinoPageRoute(builder: (context) => SettingView()),
            );
          },
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: primaryLightColor,
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(SETTING_ICON_PATH, fit: BoxFit.scaleDown),
          ),
          content: <Widget>[
            Text(
              "Setting",
              style: PengoStyle.title2(context),
            ),
            Text(
              "Configure in-app setting",
              style: PengoStyle.smallerText(context)
                  .copyWith(color: grayTextColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    final String? _avatar = context.select<AuthModel, String>(
        (AuthModel model) => model.user?.avatar ?? '');
    final String _username = context.select<AuthModel, String>(
        (AuthModel model) => model.user?.username ?? '');
    final String _phone = context.select<AuthModel, String>(
        (AuthModel model) => model.user?.phone ?? '');

    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute(builder: (context) => ProfileInfoView()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        height: 100,
        decoration: BoxDecoration(
          color: greyBgColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              minRadius: 27,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                _avatar ?? "",
              ),
            ),
            const SizedBox(
              width: SECTION_GAP_HEIGHT,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  _username,
                  style: PengoStyle.header(context),
                ),
                Text(
                  _phone,
                  style: PengoStyle.text(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
