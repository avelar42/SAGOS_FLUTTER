import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sagos_mobile/model/asset.dart';
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
    final arg = ModalRoute.of(context)?.settings.arguments as List<Object>;

    if (arg.length > 0) {
      var asset = arg[0] as Asset?;
      _formData['customerId'] = arg[1].toString();
      if (asset != null) {
        _formData['id'] = asset.id.toString();
        _formData['descricao'] = asset.descricao.toString();
        _formData['identificacao'] = asset.identificacao.toString();
      }
    }
    print(arg);
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
                  initialValue: _formData['descricao']?.toString(),
                  decoration: InputDecoration(label: Text('Descrição')),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (_descricao) {
                    final descricao = _descricao ?? '';
                    if (descricao.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    if (descricao.isNotEmpty) {
                      if (descricao.length > 255) {
                        return 'Limite 255 caracteres.';
                      }
                    }
                    return null;
                  },
                  onSaved: (descricao) =>
                      _formData['descricao'] = descricao ?? "",
                ),
                TextFormField(
                  initialValue: _formData['identificacao']?.toString(),
                  decoration:
                      InputDecoration(label: Text('Identificação (Placa)')),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  validator: (_identificacao) {
                    final identificacao = _identificacao ?? '';
                    if (identificacao.isNotEmpty) {
                      if (identificacao.length > 7) {
                        return 'Limite 7 caracteres';
                      }
                    }
                    return null;
                  },
                  onSaved: (identificacao) =>
                      _formData['identificacao'] = identificacao ?? "",
                ),
              ],
            )),
      ),
    );
  }
}
