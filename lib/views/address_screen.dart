import 'package:flutter/material.dart';
import 'package:sagos_mobile/model/address.dart';
import 'package:sagos_mobile/model/customer.dart';
import 'package:sagos_mobile/utils/app_routes.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String _customerId = "";
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)?.settings.arguments as Customer;
    _customerId = arg.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Endereços'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CUSTOMER_ADDRESS_FORM,
                    arguments: [
                      Address(id: '', rua: '', numero: 0),
                      _customerId
                    ]);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Text('Endereços'),
    );
  }
}
