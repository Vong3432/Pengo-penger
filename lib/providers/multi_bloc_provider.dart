import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penger/bloc/auth/auth_bloc.dart';
import 'package:penger/bloc/booking-categories/booking_category_bloc.dart';
import 'package:penger/bloc/booking-items/create/create_booking_item_bloc.dart';
import 'package:penger/bloc/booking-items/edit/edit_booking_item_bloc.dart';
import 'package:penger/bloc/booking-items/view/view_booking_item_bloc.dart';
import 'package:penger/bloc/coupons/view/view_active_coupons_bloc.dart';
import 'package:penger/bloc/coupons/view/view_coupon_bloc.dart';
import 'package:penger/bloc/coupons/view/view_expired_coupons_bloc.dart';

List<BlocProvider<dynamic>> multiBlocProviders(BuildContext context) {
  return <BlocProvider<dynamic>>[
    BlocProvider<AuthBloc>(
      create: (BuildContext context) => AuthBloc(),
    ),
    BlocProvider<BookingCategoryBloc>(
      create: (BuildContext context) => BookingCategoryBloc(),
    ),
    BlocProvider<CreateBookingBloc>(
      create: (BuildContext context) => CreateBookingBloc(),
    ),
    BlocProvider<EditBookingItemBloc>(
      create: (BuildContext context) => EditBookingItemBloc(),
    ),
    BlocProvider<ViewItemBloc>(
      create: (BuildContext context) => ViewItemBloc(),
    ),
    BlocProvider<ViewActiveCouponsBloc>(
      create: (BuildContext context) => ViewActiveCouponsBloc(),
    ),
    BlocProvider<ViewExpiredCouponsBloc>(
      create: (BuildContext context) => ViewExpiredCouponsBloc(),
    ),
    BlocProvider<ViewCouponBloc>(
      create: (BuildContext context) => ViewCouponBloc(),
    ),
  ];
}
