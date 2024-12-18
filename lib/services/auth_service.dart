import 'dart:convert';

import 'package:chat/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/services/global/environments.dart';
import 'package:chat/models/login_response.dart';

class AuthServiceNotifier extends ChangeNotifier {
  User? user;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final _storage = FlutterSecureStorage();

  static Future<String?> getToken() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final data = {
      'email': email,
      'password': password,
    };

    final uri = Uri.parse('${Environments.apiUrl}/login');

    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    _isLoading = false;
    notifyListeners();

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      final user = loginResponse.user;

      await _saveToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final data = {
      'name': name,
      'email': email,
      'password': password,
    };

    final uri = Uri.parse('${Environments.apiUrl}/login/new');

    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    _isLoading = false;
    notifyListeners();

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      final user = loginResponse.user;

      await _saveToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      // return respBody['msg'];
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token') ?? '';

    final uri = Uri.parse('${Environments.apiUrl}/login/renew');
    final resp = await http.get(
      uri,
      headers: {'Content-Type': 'application/json', 'x-token': token},
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      final user = loginResponse.user;

      await _saveToken(loginResponse.token);

      return true;
    } else {
      logout();
      return false;
    }
  }

  Future<void> _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future<void> logout() async {
    await _storage.delete(key: 'token');
  }
}
