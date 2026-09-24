import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // Sign up user
  Future<void> signUpUser({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {
    try {
      User user = User(
        id: '',
        email: email,
        name: name,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse("$uri/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account Created! Login');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Sign in user
  Future<void> signInUser({
    required String email,
    required String password,
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {
    try {
      User user = User(
        id: '',
        email: email,
        name: '',
        password: password,
        address: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse("$uri/api/signin"), // Changed signup to signin
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Login Successful'); // Changed message
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
