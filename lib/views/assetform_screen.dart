import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/customer.dart';
import '../view_models/customer_view_model.dart';

class AssetFormScreen extends StatefulWidget {
  const AssetFormScreen({Key? key}) : super(key: key);

  @override
  _AssetFormScreenState createState() => _AssetFormScreenState();
}

class _AssetFormScreenState extends State<AssetFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();
    await Provider.of<CustomerViewModel>(context, listen: false)
        .saveAsset(_formData);

    //print(_formData);
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)?.settings.arguments as List<String>;

    if (arg.length > 0) {
      _formData['customerId'] = arg[0];
    }
    print(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Ativo'),
        actions: [IconButton(onPressed: _submitForm, icon: Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(label: Text('Código')),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  onSaved: (codigo) => _formData['codigo'] = codigo ?? "",
                ),
                TextFormField(
                  decoration: InputDecoration(label: Text('Descrição')),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  onSaved: (descricao) =>
                      _formData['descricao'] = descricao ?? "",
                ),
                TextFormField(
                  decoration: InputDecoration(label: Text('Identificação')),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  onSaved: (identificacao) =>
                      _formData['identificacao'] = identificacao ?? "",
                ),
              ],
            )),
      ),
    );
  }
}
