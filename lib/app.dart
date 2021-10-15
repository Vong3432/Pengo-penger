import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
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
  final _bottomBarKey = GlobalKey();
  final _navigatorKey = GlobalKey<NavigatorState>();

  void _onBottomNavItemTapped(int idx) {
    switch (idx) {
      case 0:
        // home
        _navigatorKey.currentState!.pushNamedAndRemoveUntil('/', (_) => false);
        break;
      case 1:
        // goocard

        break;
      case 2:
        // history
        _navigatorKey.currentState!
            .pushNamedAndRemoveUntil('/scan', (_) => false);
        break;
      case 3:
        // history
        _navigatorKey.currentState!
            .pushNamedAndRemoveUntil('/notifications', (_) => false);
        break;
      case 4:
        // profile
        _navigatorKey.currentState!
            .pushNamedAndRemoveUntil('/profile', (_) => false);
        break;
      default:
        _navigatorKey.currentState!.pushNamedAndRemoveUntil('/', (_) => false);
    }

    setState(() {
      _selectedIndex = idx;
    });
  }

  final List<String> _icons = <String>[
    HOME_ICON_PATH,
    COUPON_ICON_PATH,
    SCAN_ICON_PATH,
    NOTIFICATION_ICON_PATH,
    PROFILE_ICON_PATH,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.idx != null) {
      setState(() {
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
      // body: PageStorage(bucket: bucket, child: currentScreen),
      body: WillPopScope(
        onWillPop: () async {
          if (_navigatorKey.currentState!.canPop()) {
            _navigatorKey.currentState!.pop();
            return false;
          }
          return true;
        },
        child: Navigator(
          key: _navigatorKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            // Manage your route names here
            switch (settings.name) {
              case '/':
                builder = (BuildContext context) => HomePage();
                break;
              case '/coupons':
                builder = (BuildContext context) => CouponPage();
                break;
              case '/scan':
                builder = (BuildContext context) => QRScannerPage();
                break;
              case '/notifications':
                builder = (BuildContext context) => NotificationPage();
                break;
              case '/profile':
                builder = (BuildContext context) => ProfilePage();
                break;
              default:
                throw Exception('Invalid route: ${settings.name}');
            }
            // You can also return a PageRouteBuilder and
            // define custom transitions between pages
            return CupertinoPageRoute(
              builder: builder,
              maintainState: false,
              settings: settings,
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(_icons.length, (int index) {
          final Color color = _selectedIndex == index
              ? primaryColor
              : textColor.withOpacity(0.5);
          return BottomNavigationBarItem(
            label: "",
            icon: SvgPicture.asset(
              _icons[index],
              color: color,
              width: 27,
              height: 27,
              fit: BoxFit.scaleDown,
            ),
          );
        }),
        elevation: 17,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: whiteColor,
        currentIndex: _selectedIndex,
        onTap: _onBottomNavItemTapped,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
