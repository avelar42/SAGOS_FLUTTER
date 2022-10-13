import 'package:flutter/material.dart';

class AssetFormScreen extends StatefulWidget {
  const AssetFormScreen({Key? key}) : super(key: key);

  @override
  _AssetFormScreenState createState() => _AssetFormScreenState();
}

class _AssetFormScreenState extends State<AssetFormScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Ativo'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(label: Text('Rua')),
                ),
                TextFormField(
                  decoration: InputDecoration(label: Text('Numero')),
                ),
                TextFormField(
                  decoration: InputDecoration(label: Text('Bairro')),
                ),
                TextFormField(
                  decoration: InputDecoration(label: Text('Cidade')),
                ),
                TextFormField(
                  decoration: InputDecoration(label: Text('Complemento')),
                ),
              ],
            )),
      ),
    );
  }
}
