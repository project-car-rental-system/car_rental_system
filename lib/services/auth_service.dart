class AuthService {
  String? _registeredUsername;
  String? _registeredPassword;

  bool get isRegistered => _registeredUsername != null;

  void register(String username, String password) {
    _registeredUsername = username;
    _registeredPassword = password;
  }

  bool login(String username, String password) {
    return username == _registeredUsername && password == _registeredPassword;
  }
}
