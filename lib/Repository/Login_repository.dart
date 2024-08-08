// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  Future<bool> login(String? username, String? password) async {
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/auth/login'),
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var token = jsonDecode(response.body);
      print('Response:${token['token']}');
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('userToken', token['token']);

      // Assuming the response is a token or a success message
      return true;
    } else {
      return false;
    }
  }
}
