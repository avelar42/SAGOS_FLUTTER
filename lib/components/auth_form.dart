import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
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
            child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
              validator: (_email) {
                final email = _email ?? '';
                if (email.trim().isEmpty || email.contains('@')) {
                  return 'Informe um e-mail valido.';
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Senha'),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Entrar'),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 8)),
            )
          ],
        )),
      ),
    );
  }
}
