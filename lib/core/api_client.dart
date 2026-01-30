import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hire_up_web/core/secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static BuildContext? _context;

  // Set context when app starts (call this in main.dart or root widget)
  static void setContext(BuildContext context) {
    _context = context;
  }

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

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );


      _handleErrors(response);
      return response;
    } on Exception catch (e) {
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
  // POST without token (for login/signup)
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
  // Handle 401 Unauthorized
  // -----------------------------
  static void _handleUnauthorized() async {
    // Clear token from storage
    await SecureStorage.removeToken();

    // Navigate to login screen if context is available
    if (_context != null && _context!.mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(_context!).pushNamedAndRemoveUntil(
          '/login',
              (route) => false,
        );
      });
    }
  }

  // -----------------------------
  // Handle API Errors
  // -----------------------------
  static void _handleErrors(http.Response res) {

    if (res.statusCode == 401) {
      _handleUnauthorized();
      throw Exception("Unauthorized: Please login again");
    } else if (res.statusCode >= 400) {
      throw Exception(
        "API Error: ${res.statusCode}\n${res.body}",
      );
    }
  }

}