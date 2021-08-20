import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:penger/bloc/auth/auth_repo.dart';
import 'package:penger/helpers/storage/shared_preference_helper.dart';
import 'package:penger/models/auth_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  final AuthRepo _authRepo = AuthRepo();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    // TODO: implement mapEventToState
    debugPrint(event.toString());
    if (event is LoginEvent) {
      yield* _mapLoginToState(event.phone, event.password);
    }
  }

  Stream<AuthState> _mapLoginToState(String phone, String password) async* {
    try {
      yield AuthenticatingState();
      final Auth auth = await _authRepo.login(phone, password);
      await SharedPreferencesHelper().setStr("user", auth.toString());
      yield AuthenticatedState();
    } catch (_) {
      yield NotAuthenticatedState();
    }
  }
}
