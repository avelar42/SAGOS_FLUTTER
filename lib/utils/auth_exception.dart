class AuthException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_NOT_FOUND': 'E-mail não encontrado',
    'INVALID_PASSWORD': 'Senha inválida',
    'USER_DISABLED': 'Usuario desabilitado'
  };

  final String key;

  AuthException(this.key);

  String toString() {
    return errors[key] ?? 'Ocorreu um erro no processo de autenticacao';
  }
}
