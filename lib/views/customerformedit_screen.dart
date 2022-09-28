import 'package:flutter/material.dart';
import 'package:sagos_mobile/model/customer.dart';
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
        .updateCustomer(_formData);
    print(_formData);
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        final customer = arg as Customer;
        _formData['id'] = customer.id;
        _formData['nome'] = customer.nome;
        _formData['sobrenome'] = customer.sobrenome;
        _formData['cpf'] = customer.cpf;
        _formData['telefone'] = customer.telefone;
        _formData['dataNascimento'] = customer.dataNascimento;
      }
    }
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
                  initialValue: _formData['nome']?.toString(),
                  decoration: InputDecoration(labelText: 'Nome'),
                  onSaved: (name) => _formData['nome'] = name ?? '',
                ),
                TextFormField(
                  initialValue: _formData['sobrenome']?.toString(),
                  decoration: InputDecoration(labelText: 'Sobrenome'),
                  onSaved: (lastname) =>
                      _formData['sobrenome'] = lastname ?? '',
                ),
                TextFormField(
                  initialValue: _formData['cpf']?.toString(),
                  decoration: InputDecoration(labelText: 'CPF'),
                  onSaved: (cpf) => _formData['CPF'] = cpf ?? '',
                ),
                TextFormField(
                  initialValue: _formData['telefone']?.toString(),
                  decoration: InputDecoration(labelText: 'Telefone'),
                  onSaved: (phone) => _formData['telefone'] = phone ?? '',
                ),
                TextFormField(
                  initialValue: _formData['dataNascimento']?.toString(),
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
