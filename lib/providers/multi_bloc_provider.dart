import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penger/bloc/auth/auth_bloc.dart';
import 'package:penger/bloc/booking-categories/booking_category_bloc.dart';
import 'package:penger/bloc/booking-items/booking_item_bloc.dart';

List<BlocProvider<dynamic>> multiBlocProviders(BuildContext context) {
  return <BlocProvider<dynamic>>[
    BlocProvider<AuthBloc>(
      create: (BuildContext context) => AuthBloc(),
    ),
    BlocProvider<BookingCategoryBloc>(
      create: (BuildContext context) => BookingCategoryBloc(),
    ),
    BlocProvider<BookingItemBloc>(
      create: (BuildContext context) => BookingItemBloc(),
    ),
  ];
}
