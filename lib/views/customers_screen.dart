import 'package:flutter/material.dart';
import 'package:sagos_mobile/components/app_drawer.dart';
import 'package:sagos_mobile/utils/app_routes.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({Key? key}) : super(key: key);

  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clientes'), actions: [
        IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.CUSTOMER_FORM),
            icon: Icon(Icons.add))
      ]),
      drawer: AppDrawer(),
      body: Text('CORPO'),
    );
  }
}
