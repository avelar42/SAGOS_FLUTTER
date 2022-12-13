import 'package:flutter/material.dart';
import 'package:sagos_mobile/components/app_drawer.dart';

class WorkOrderScreen extends StatelessWidget {
  const WorkOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ordens de Serviço'),
      ),
      drawer: AppDrawer(),
      body: Container(
        child: Center(
          child: Image.asset('assets/images/under_construction.png'),
        ),
      ),
    );
  }
}
