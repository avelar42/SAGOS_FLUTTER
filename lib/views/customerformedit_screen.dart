import 'package:flutter/material.dart';
import 'package:sagos_mobile/view_models/customer_view_model.dart';
import 'package:provider/provider.dart';

class CustomerFormEditScreen extends StatefulWidget {
  const CustomerFormEditScreen({Key? key}) : super(key: key);

  @override
  _CustomerFormEditScreenState createState() => _CustomerFormEditScreenState();
}

class _CustomerFormEditScreenState extends State<CustomerFormEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  //TO DO: IMPLEMENT PROVIDER HERE
  Future<void> _submitForm() async {
    _formKey.currentState?.save();
    await Provider.of<CustomerViewModel>(context, listen: false)
        .saveCustomer(_formData);
    print(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar dados Cliente'), actions: [
        IconButton(onPressed: _submitForm, icon: Icon(Icons.save))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                          onPressed: () {}, child: Text('Ativos')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                          onPressed: () {}, child: Text('Enderecos')),
                    )
                  ],
                ),
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
                      _formData['dataNascimento'] = DateTime.now(),
                )
              ],
            )),
      ),
    );
  }
}
