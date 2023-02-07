import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) {
      return false;
    }

    final decodedUserData =
        json.decode(prefs.getString("userData")!) as Map<String, dynamic>;
    final DateTime expiryDate =
        DateTime.parse(decodedUserData['expiryDate'] as String);

    _token = decodedUserData['token'] as String;
    _expiryDate = _expiryDate;
    _userId = decodedUserData['userId'] as String;
    notifyListeners();
    print("token: $_token");
    return true;
  }

  Future<void> signup(String? email, String? password) async {
    try {
      final url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCZIYSPHXNxAEH4R4A-cPKyN2WYbb2U1H8');
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      var responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw Exception(responseData['error']['message']);
      }
      _userId = responseData['localId'];
      _token = responseData['idToken'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = {
        'userId': _userId,
        'token': _token,
        'expiryDate': _expiryDate!.toIso8601String()
      };
      prefs.setString('userData', json.encode(userData));
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signin(String? email, String? password) async {
    try {
      final url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCZIYSPHXNxAEH4R4A-cPKyN2WYbb2U1H8');
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));

      var responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw Exception(responseData['error']['message']);
      }
      _userId = responseData['localId'];
      _token = responseData['idToken'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();

      final userData = {
        'userId': _userId,
        'token': _token,
        'expiryDate': _expiryDate!.toIso8601String()
      };
      print(userData['token']);
      prefs.setString('userData', json.encode(userData));
    } catch (error) {
      rethrow;
    }
  }

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    notifyListeners();
  }
}
