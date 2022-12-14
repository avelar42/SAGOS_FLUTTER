import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sagos_mobile/view_models/auth_view_model.dart';

import '../utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<AuthViewModel>(context).getUserName;
    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text('${userName}'),
        ),
        ListTile(
          title: Text('Inicio/Dashboard'),
          leading: Icon(Icons.home),
          onTap: () => Navigator.of(context)
              .pushReplacementNamed(AppRoutes.AUTH_OR_HOME),
        ),
        ListTile(
          title: Text('Ordens de Serviço'),
          leading: Icon(Icons.payment),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(AppRoutes.WORKORDER),
        ),
        ListTile(
          title: Text('Clientes'),
          leading: Icon(Icons.person),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(AppRoutes.CUSTOMERS),
        ),
        Container(
          child: ListTile(
              title: Text('Sair'),
              leading: Icon(Icons.arrow_back),
              onTap: () {
                Provider.of<AuthViewModel>(context, listen: false).logout();
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
              }),
        )
      ]),
    );
  }
}
