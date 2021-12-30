import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/icon_const.dart';
import 'package:penger/helpers/notification/push_notification_manager.dart';
import 'package:penger/ui/booking-item/item_listing_view.dart';
import 'package:penger/ui/coupon/coupon_listing_view.dart';
import 'package:penger/ui/home/home_view.dart';
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
    // same path
    if (idx == _selectedIndex && idx != 2) return;

    switch (idx) {
      case 0:
        // home
        _navigatorKey.currentState!.pushNamedAndRemoveUntil('/', (_) => false);
        break;
      case 1:
        // coupon
        _navigatorKey.currentState!
            .pushNamedAndRemoveUntil('/coupons', (_) => false);
        break;
      case 2:
        // history
        showCupertinoModalBottomSheet(
          useRootNavigator: true,
          context: context,
          builder: (BuildContext context) {
            return const QRScannerPage();
          },
        );
        break;
      case 3:
        // history
        _navigatorKey.currentState!
            .pushNamedAndRemoveUntil('/items', (_) => false);
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

  final List<Map<String, String>> _icons = <Map<String, String>>[
    <String, String>{"label": "Home", "path": HOME_ICON_PATH},
    <String, String>{"label": "Coupon", "path": COUPON_ICON_PATH},
    <String, String>{"label": "Scan", "path": SCAN_ICON_PATH},
    <String, String>{"label": "My items", "path": ITEMS_ICON_PATH},
    <String, String>{"label": "Profile", "path": PROFILE_ICON_PATH},
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
                builder = (BuildContext context) => const HomePage();
                break;
              case '/coupons':
                builder = (BuildContext context) => const CouponPage();
                break;
              case '/items':
                builder = (BuildContext context) => const ItemsPage();
                break;
              case '/profile':
                builder = (BuildContext context) => const ProfilePage();
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
            label: _icons[index]["label"],
            icon: SvgPicture.asset(
              _icons[index]["path"]!,
              color: color,
              width: 23,
              height: 23,
              fit: BoxFit.scaleDown,
            ),
          );
        }),
        elevation: 17,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: whiteColor,
        currentIndex: _selectedIndex,
        onTap: _onBottomNavItemTapped,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
