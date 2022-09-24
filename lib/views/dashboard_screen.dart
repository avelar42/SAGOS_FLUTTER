import 'package:flutter/material.dart';
import 'package:sagos_mobile/components/app_drawer.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SAGOS')),
      drawer: AppDrawer(),
      body: Text('Corpo do APP!'),
    );
  }
}
