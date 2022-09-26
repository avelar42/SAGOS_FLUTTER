import 'package:flutter/material.dart';
import 'package:sagos_mobile/view_models/customer_view_model.dart';
import 'package:provider/provider.dart';

class CustomerFormScreen extends StatefulWidget {
  const CustomerFormScreen({Key? key}) : super(key: key);

  @override
  _CustomerFormScreenState createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends State<CustomerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  //TO DO: IMPLEMENT PROVIDER HERE
  // _submitForm() {
  //   _formKey.currentState?.save();
  //   print(_formData);
  //   return;
  // }

  @override
  Widget build(BuildContext context) {
    CustomerViewModel customerViewModel = context.watch<CustomerViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('Formulario de clientes'), actions: [
        IconButton(
            onPressed: () {
              _formKey.currentState?.save();
              customerViewModel.saveCustomer(_formData);
              print(_formData);
            },
            icon: Icon(Icons.save))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome'),
                  onSaved: (name) => _formData['nome'] = name ?? '',
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Sobrenome'),
                  onSaved: (lastname) =>
                      _formData['sobrenome'] = lastname ?? '',
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'CPF'),
                  onSaved: (cpf) => _formData['CPF'] = cpf ?? '',
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Telefone'),
                  onSaved: (phone) => _formData['telefone'] = phone ?? '',
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Data Nascimento'),
                  onSaved: (birth) =>
                      _formData['dataNascimento'] = DateTime.now() ?? '',
                )
              ],
            )),
      ),
    );
  }
}
