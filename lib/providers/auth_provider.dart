import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String? _email;
  
  bool get isLoggedIn => _isLoggedIn;
  String? get email => _email;
  
  Future<bool> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    _isLoggedIn = true;
    _email = email;
    notifyListeners();
    return true;
  }
  
  void logout() {
    _isLoggedIn = false;
    _email = null;
    notifyListeners();
  }
}