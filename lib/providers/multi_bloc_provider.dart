import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penger/bloc/auth/auth_bloc.dart';

List<BlocProvider<dynamic>> multiBlocProviders(BuildContext context) {
  return <BlocProvider<dynamic>>[
    BlocProvider<AuthBloc>(
      create: (BuildContext context) => AuthBloc(),
    ),
  ];
}
