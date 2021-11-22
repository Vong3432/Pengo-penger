import 'package:image_picker/image_picker.dart';
import 'package:penger/bloc/auth/auth_api_provider.dart';
import 'package:penger/models/auth_model.dart';

class AuthRepo {
  factory AuthRepo() {
    return _instance;
  }

  AuthRepo._constructor();

  static final AuthRepo _instance = AuthRepo._constructor();
  final AuthApiProvider _authApiProvider = AuthApiProvider();

  Future<Auth> login(String phone, String password) async =>
      _authApiProvider.login(phone, password);

  Future<Auth> register(
    String phone,
    String password,
    String username,
    String email,
    XFile avatar,
  ) async =>
      _authApiProvider.register(phone, password, username, email, avatar);

  Future<Auth> updateProfile({
    required int userId,
    String? phone,
    String? password,
    String? username,
    String? email,
    XFile? avatar,
  }) async =>
      _authApiProvider.updateProfile(
        userId: userId,
        phone: phone,
        password: password,
        username: username,
        email: email,
        avatar: avatar,
      );
}
