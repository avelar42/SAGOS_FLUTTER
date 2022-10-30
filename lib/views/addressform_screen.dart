import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sagos_mobile/model/address.dart';
import 'package:sagos_mobile/view_models/customer_view_model.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({Key? key}) : super(key: key);

  @override
  _AddressFormScreenState createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    await Provider.of<CustomerViewModel>(context, listen: false)
        .saveAddress(_formData);
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)?.settings.arguments as List<Object>;
    if (arg.length > 0) {
      var address = arg[0] as Address?;
      _formData['customerId'] = arg[1].toString();
      if (address != null) {
        _formData['id'] = address.id;
        _formData['rua'] = address.rua.toString();
        _formData['cep'] = address.cep.toString();
        _formData['numero'] = address.numero;
        _formData['bairro'] = address.bairro.toString();
        _formData['cidade'] = address.cidade.toString();
      }
    }
    print(arg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de endereço'),
        actions: [IconButton(onPressed: _submitForm, icon: Icon(Icons.save))],
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  //Text('Codigo: 1'),
                  TextFormField(
                    initialValue: _formData['cep']?.toString(),
                    decoration: InputDecoration(label: Text('CEP')),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onSaved: (cep) => _formData['cep'] = cep.toString(),
                  ),
                  TextFormField(
                    initialValue: _formData['rua']?.toString(),
                    decoration: InputDecoration(label: Text('Rua')),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onSaved: (rua) => _formData['rua'] = rua.toString(),
                  ),
                  TextFormField(
                    initialValue: _formData['numero']?.toString(),
                    decoration: InputDecoration(label: Text('Numero')),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onSaved: (numero) =>
                        _formData['numero'] = numero.toString(),
                  ),
                  TextFormField(
                    initialValue: _formData['bairro']?.toString(),
                    decoration: InputDecoration(label: Text('Bairro')),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onSaved: (bairro) =>
                        _formData['bairro'] = bairro.toString(),
                  ),
                  TextFormField(
                    initialValue: _formData['cidade']?.toString(),
                    decoration: InputDecoration(label: Text('Cidade')),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    onSaved: (cidade) =>
                        _formData['cidade'] = cidade.toString(),
                  ),
                ],
              ))),
    );
  }
}
