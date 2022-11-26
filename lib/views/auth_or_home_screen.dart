import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sagos_mobile/view_models/auth_view_model.dart';
import 'package:sagos_mobile/views/auth_page.dart';
import 'package:sagos_mobile/views/dashboard_screen.dart';

class AuthOrHomeScreen extends StatelessWidget {
  const AuthOrHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthViewModel auth = Provider.of(context);
    return FutureBuilder(
        future: auth.tryAutoLogin(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('Ocorreu um erro!'));
          } else {
            return auth.isAuth ? DashBoardScreen() : AuthPage();
          }
        });
    // return auth.isAuth ? DashBoardScreen() : AuthPage();
  }
}
