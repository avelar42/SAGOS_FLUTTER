import 'package:flutter/material.dart';

class CustomerFormScreen extends StatefulWidget {
  const CustomerFormScreen({Key? key}) : super(key: key);

  @override
  _CustomerFormScreenState createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends State<CustomerFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Formulario de clientes'),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.save))]),
      body: Text('CORPO FORMULARIO DE CLIENTES'),
    );
  }
}
