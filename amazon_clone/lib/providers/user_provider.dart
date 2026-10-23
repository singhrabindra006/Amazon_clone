import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  // NEW: Method to set token from SharedPreferences
  void setTokenIfExists(String? token) {
    if (token != null && token.isNotEmpty) {
      _user = User(
        id: _user.id,
        name: _user.name,
        email: _user.email,
        password: _user.password,
        address: _user.address,
        type: _user.type,
        token: token,
      );
      notifyListeners();
    }
  }
}
