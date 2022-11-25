import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:sagos_mobile/utils/auth_exception.dart';
import 'package:sagos_mobile/utils/constants.dart';
import '../model/auth.dart';

class AuthViewModel extends ChangeNotifier {
  Auth _auth = new Auth();

  bool get isAuth {
    return _auth.isAuth;
  }

  String? get token {
    return _auth.token;
  }

  Future<void> autenticate(String email, String password) async {
    final response = await post(Uri.parse(URL_LOGIN),
        body: jsonEncode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    final body = jsonDecode(response.body);
    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    } else {
      _auth.setToken(body['idToken']);
      _auth.setEmail(body['email']);
      _auth.setUid(body['localId']);
      _auth.setExpireDate(
          DateTime.now().add(Duration(seconds: int.parse(body['expiresIn']))));
      notifyListeners();
    }

    // print(body);
  }

  void logout() {
    _auth.removeCredentials();
    notifyListeners();
  }
}
