import 'package:flutter/material.dart';
import 'package:sagos_mobile/utils/app_routes.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Endereços'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.CUSTOMER_ADDRESS_FORM);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Text('Endereços'),
    );
  }
}
