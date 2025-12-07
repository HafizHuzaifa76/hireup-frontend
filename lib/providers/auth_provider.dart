import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../core/secure_storage.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

final authControllerProvider =
StateNotifierProvider<AuthController, bool>((ref) => AuthController(ref));

final authUserProvider = StateProvider<UserModel?>((ref) => null);

class AuthController extends StateNotifier<bool> {
  final Ref ref;
  String? token;
  final _service = AuthService();

  AuthController(this.ref) : super(false) {
    getToken();
  }

  void getToken(){
    SecureStorage.getToken().then((token) {
      this.token = token;
    });
  }

  UserModel? get user => ref.read(authUserProvider);

  // -------------------------------
  // Signup
  // -------------------------------
  Future<void> signup(Map data, BuildContext context) async {
    state = true;
    final res = await _service.signup(data);
    state = false;

    if (res["success"] == true) {
      Navigator.pushReplacementNamed(context, "/login");
    }

    _snack(context, res["message"]);
  }

  // -------------------------------
  // Login
  // -------------------------------
  Future<void> login(Map body, BuildContext context) async {
    state = true;
    final res = await _service.login(body);
    state = false;
    final data = res['data'];

    print('res');
    print(res);
    if (res["success"] == true) {
      SecureStorage.saveToken(data["access_token"]);
      ref.read(authUserProvider.notifier)
          .state = UserModel.fromJson(data["user"]);

      Navigator.pushReplacementNamed(context, "/jobs");
    }

    _snack(context, res["message"]);
  }

  // -------------------------------
  // Auto Login / Verify
  // -------------------------------
  Future<bool> verify() async {
    if (token == null) return false;

    final res = await _service.verifyToken(token!);

    if (res["success"] == true) {
      ref.read(authUserProvider.notifier)
          .state = UserModel.fromJson(res["user"]);
      return true;
    }

    SecureStorage.removeToken();
    return false;
  }

  // -------------------------------
  // Logout
  // -------------------------------
  void logout(BuildContext context) {
    SecureStorage.removeToken();
    ref.read(authUserProvider.notifier).state = null;

    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
  }

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
