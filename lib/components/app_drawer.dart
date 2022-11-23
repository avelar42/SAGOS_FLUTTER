import 'package:flutter/material.dart';

import '../utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text('Welcome User!'),
        ),
        ListTile(
          title: Text('Inicio'),
          leading: Icon(Icons.home),
          onTap: () => Navigator.of(context)
              .pushReplacementNamed(AppRoutes.AUTH_OR_HOME),
        ),
        ListTile(
          title: Text('Ordens de Serviço'),
          leading: Icon(Icons.payment),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(AppRoutes.CUSTOMERS),
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
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.CUSTOMERS),
          ),
        )
      ]),
    );
  }
}
