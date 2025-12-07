import 'dart:convert';
import 'package:hire_up_web/core/secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  // -----------------------------
  // Load token automatically
  // -----------------------------
  static Future<Map<String, String>> _buildHeaders() async {
    final token = await SecureStorage.getToken();

    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  // -----------------------------
  // GET
  // -----------------------------
  static Future<http.Response> get(String url) async {
    final headers = await _buildHeaders();

    print('headers');
    print(headers);

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      print('response.headers');
      print(response.headers);

      _handleErrors(response);
      return response;
    } on Exception catch (e) {
      print('Exception');
      print(e);
      rethrow;
    }
  }

  // -----------------------------
  // POST
  // -----------------------------
  static Future<http.Response> post(
      String url, {
        Map? body,
      }) async {
    final headers = await _buildHeaders();

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body ?? {}),
    );

    _handleErrors(response);
    return response;
  }

  // -----------------------------
  // POST
  // -----------------------------
  static Future<http.Response> postWithoutToken(
      String url, {
        Map? body,
      }) async {
    final headers = {
      "Content-Type": "application/json",
    };
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body ?? {}),
    );

    _handleErrors(response);
    return response;
  }

  // -----------------------------
  // PATCH
  // -----------------------------
  static Future<http.Response> patch(
      String url, {
        Map? body,
      }) async {
    final headers = await _buildHeaders();

    final response = await http.patch(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body ?? {}),
    );

    _handleErrors(response);
    return response;
  }

  // -----------------------------
  // DELETE
  // -----------------------------
  static Future<http.Response> delete(String url) async {
    final headers = await _buildHeaders();

    final response = await http.delete(
      Uri.parse(url),
      headers: headers,
    );

    _handleErrors(response);
    return response;
  }

  // -----------------------------
  // Error Handler
  // -----------------------------
  static void _handleErrors(http.Response res) {
    print('res.statusCode: ${res.statusCode}');
    if (res.statusCode >= 400) {
      throw Exception(
        "API Error: ${res.statusCode}\n${res.body}",
      );
    }
  }
}
