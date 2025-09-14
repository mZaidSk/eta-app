import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Fetch token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString("authToken");

    if (authToken != null && authToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $authToken';
    }

    options.headers['Content-Type'] = 'application/json';

    print('➡️ REQUEST[${options.method}] => PATH: ${options.path}');
    return handler.next(options); // continue
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');

    return handler.next(response); // continue
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print(
        '❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

    if (err.response?.statusCode == 401) {
      print("⚠️ Token expired or unauthorized!");

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("authToken");
    }

    return handler.next(err); // continue
  }
}
