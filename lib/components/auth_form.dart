import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sagos_mobile/utils/app_routes.dart';
import 'package:sagos_mobile/utils/auth_exception.dart';
import 'package:sagos_mobile/view_models/auth_view_model.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Map<String, String> _authData = {'email': '', 'password': ''};

  Future<void> _submit() async {
    final _isValid = _formKey.currentState?.validate() ?? false;
    if (!_isValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _formKey.currentState?.save();
    AuthViewModel authViewModel = Provider.of(context, listen: false);

    //LOGIN
    try {
      await authViewModel.autenticate(
          _authData['email']!, _authData['password']!);
      Navigator.of(context).pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro desconhecido');
    }
  }

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Ocorreu um erro'),
              content: Text(msg),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Fechar'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 310,
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => _authData['email'] = email ?? '',
                  validator: (_email) {
                    final email = _email ?? '';
                    if (email.trim().isEmpty || !email.contains('@')) {
                      return 'Informe um e-mail valido.';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Senha'),
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (password) => _authData['password'] = password ?? '',
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text('Entrar'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 8)),
                )
              ],
            )),
      ),
    );
  }
}
