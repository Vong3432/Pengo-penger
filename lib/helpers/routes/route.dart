import 'package:flutter/cupertino.dart';
import 'package:penger/ui/coupon/coupon_listing_view.dart';
import 'package:penger/ui/home/home_view.dart';
import 'package:penger/ui/notification/notification_view.dart';
import 'package:penger/ui/profile/profile_view.dart';

final List<Widget> screens = <Widget>[
  const HomePage(),
  const CouponPage(),
  const NotificationPage(),
  const ProfilePage()
];
