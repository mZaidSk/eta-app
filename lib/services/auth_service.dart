import 'package:eta_app/services/base_service.dart';

class AuthService extends BaseService {
  Future<bool> login(String email, String password) async {
    try {
      final res = await dio
          .post("/auth/login/", data: {"email": email, "password": password});
      if (res.statusCode == 200 && res.data['token'] != null) {
        await saveToken(res.data['token']);
        return true;
      }
      return false;
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }

  Future<Map<String, dynamic>?> getProfile() async {
    try {
      final res = await dio.get("/auth/profile/");
      if (res.statusCode == 200) return res.data;
      return null;
    } catch (e) {
      print("Profile error: $e");
      return null;
    }
  }

  /// Logout
  Future<void> logout() async {
    await removeToken();
  }
}
