import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _id;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
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
      _id = responseData['localId'];
      _token = responseData['idToken'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
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
      _id = responseData['localId'];
      _token = responseData['idToken'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
