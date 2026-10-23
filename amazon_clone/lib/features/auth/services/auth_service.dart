import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/home/screen/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: user.toJson(),
      );

      if (!context.mounted) return;

      httpErroHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials.',
          );
        },
      );
    } catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (!context.mounted) return;

      httpErroHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final token = jsonDecode(res.body)['token'];
          if (token is! String || token.isEmpty) {
            showSnackBar(context, 'Login succeeded but no token was returned.');
            return;
          }

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('x-auth-token', token);
          if (!context.mounted) return;

          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, e.toString());
    }
  }
}
