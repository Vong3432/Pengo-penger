import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:penger/helpers/storage/shared_preference_helper.dart';
import 'package:penger/models/auth_model.dart';

class AuthModel extends ChangeNotifier {
  Auth? _user;

  Auth? get user => _user;

  void setUser(Auth u) {
    // debugPrint("Set user ${u.selectedPenger?.id}");
    final String encoded = jsonEncode(u.toJson());
    _save(encoded);
    _user = u;
    notifyListeners();
  }

  Future<void> _save(String user) async {
    await SharedPreferencesHelper().setStr("user", user);
  }

  Future<void> logoutUser() async {
    _user = null;
    await SharedPreferencesHelper().remove("user");
    notifyListeners();
  }
}
