import 'package:flutter/material.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({Key? key}) : super(key: key);

  @override
  _AddressFormScreenState createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de endereço'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.save))],
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  //Text('Codigo: 1'),
                  TextFormField(
                      decoration: InputDecoration(label: Text('CEP')),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next),
                  TextFormField(
                    decoration: InputDecoration(label: Text('Rua')),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    decoration: InputDecoration(label: Text('Numero')),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    decoration: InputDecoration(label: Text('Bairro')),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    decoration: InputDecoration(label: Text('Cidade')),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ))),
    );
  }
}
