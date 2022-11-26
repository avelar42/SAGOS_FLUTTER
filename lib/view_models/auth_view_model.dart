import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:sagos_mobile/data/store.dart';
import 'package:sagos_mobile/utils/auth_exception.dart';
import 'package:sagos_mobile/utils/constants.dart';
import '../model/auth.dart';

class AuthViewModel extends ChangeNotifier {
  Auth _auth = new Auth();
  Timer? _logoutTimer;

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
      Store.saveMap('userData', {
        'token': _auth.token,
        'email': _auth.email,
        'userId': _auth.uid,
        'expireDate': _auth.expireDate!.toIso8601String(),
      });
      autoLogout();
      notifyListeners();
    }

    // print(body);
  }

  void logout() {
    _auth.removeCredentials();
    _clearLogoutTimer();
    Store.remove('userData').then((_) {
      notifyListeners();
    });
  }

  void _clearLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void autoLogout() {
    _clearLogoutTimer();
    final timeToLogout = _auth.expireDate?.difference(DateTime.now()).inSeconds;
    print(timeToLogout);
    _logoutTimer = Timer(Duration(seconds: timeToLogout ?? 0), logout);
  }

  Future<void> tryAutoLogin() async {
    if (_auth.isAuth) return;
    final userData = await Store.getMap('userData');
    if (userData.isEmpty) return;
    final expiryDate = DateTime.parse(userData['expireDate']);
    if (expiryDate.isBefore(DateTime.now())) return;
    _auth.setToken(userData['token']);
    _auth.setEmail(userData['email']);
    _auth.setUid(userData['userId']);
    _auth.setExpireDate(expiryDate);

    autoLogout();
    notifyListeners();
  }
}
