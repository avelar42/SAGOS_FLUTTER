class Auth {
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expiryDate;

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  void setToken(String token) {
    _token = token;
  }

  void setUid(String uid) {
    _uid = uid;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setExpireDate(DateTime expireDate) {
    _expiryDate = expireDate;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get uid {
    return isAuth ? _uid : null;
  }

  void removeCredentials() {
    _token = null;
    _email = null;
    _uid = null;
    _expiryDate = null;
  }
}
