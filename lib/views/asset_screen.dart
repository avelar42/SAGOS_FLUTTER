import 'package:flutter/material.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({Key? key}) : super(key: key);

  @override
  _AssetsScreenState createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ativos'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.save))],
      ),
      body: Text('body Ativos'),
    );
  }
}
