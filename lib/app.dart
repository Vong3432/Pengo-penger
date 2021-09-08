import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/icon_const.dart';
import 'package:penger/helpers/notification/push_notification_manager.dart';
import 'package:penger/helpers/routes/route.dart';
import 'package:penger/ui/coupon/coupon_listing_view.dart';
import 'package:penger/ui/home/home_view.dart';
import 'package:penger/ui/notification/notification_view.dart';
import 'package:penger/ui/profile/profile_view.dart';
import 'package:penger/ui/qr/qr_scanner_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.idx}) : super(key: key);

  final int? idx;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  // final _navigatorKey = GlobalKey<NavigatorState>();
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();

  void _onBottomNavItemTapped(int idx) {
    Widget screen;
    switch (idx) {
      case 0:
        // home
        screen = const HomePage();
        // _navigatorKey.currentState!.pushNamedAndRemoveUntil('/', (_) => false);
        break;
      case 1:
        // goocard
        screen = const CouponPage();
        // _navigatorKey.currentState!
        //     .pushNamedAndRemoveUntil('/goocard', (_) => false);
        break;
      case 2:
        // history
        screen = const NotificationPage();
        // _navigatorKey.currentState!.pushNamedAndRemoveUntil('/', (_) => false);
        break;
      case 3:
        // profile
        screen = const ProfilePage();
        // _navigatorKey.currentState!
        //     .pushNamedAndRemoveUntil('/profile', (_) => false);
        break;
      default:
        screen = const HomePage();
      // _navigatorKey.currentState!.pushNamedAndRemoveUntil('/', (_) => false);
    }

    setState(() {
      currentScreen = screens[idx];
      _selectedIndex = idx;
    });
  }

  final List<String> _icons = <String>[
    HOME_ICON_PATH,
    COUPON_ICON_PATH,
    NOTIFICATION_ICON_PATH,
    PROFILE_ICON_PATH,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.idx != null) {
      setState(() {
        currentScreen = screens[widget.idx!];
        _selectedIndex = widget.idx!;
      });
    }

    PushNotificationManager().init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      extendBody: true,
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: "scan ",
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => QRScannerPage(),
          ));
        },
        tooltip: 'Scan',
        backgroundColor: whiteColor,
        child: SvgPicture.asset(
          SCAN_ICON_PATH,
          color: primaryColor,
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: 4,
        tabBuilder: (int index, bool isActive) {
          final Color color = _selectedIndex == index
              ? primaryColor
              : textColor.withOpacity(0.65);
          return SvgPicture.asset(
            _icons[index],
            color: color,
            width: 27,
            height: 27,
            fit: BoxFit.scaleDown,
          );
        },
        splashColor: greyBgColor,
        elevation: 17,
        backgroundColor: whiteColor,
        activeIndex: _selectedIndex,
        onTap: _onBottomNavItemTapped,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // ignore: avoid_positional_boolean_parameters
  Stack navIcon(bool show, IconData icon) {
    return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor,
              ),
              width: show ? 8 : 0,
              height: show ? 8 : 0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Icon(
            icon,
            size: 27,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
