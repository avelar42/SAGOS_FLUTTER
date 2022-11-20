import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:sagos_mobile/utils/auth_exception.dart';
import 'package:sagos_mobile/utils/constants.dart';

class AuthViewModel extends ChangeNotifier {
  Future<void> autenticate(String email, String password) async {
    final response = await post(Uri.parse(URL_LOGIN),
        body: jsonEncode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    final body = jsonDecode(response.body);
    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    }
    print(body);
  }
}
