import 'package:flutter/material.dart';
import 'package:sagos_mobile/components/app_drawer.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SAGOS')),
      drawer: AppDrawer(),
      body: Container(
        child: Center(
          child: Image.asset(
            'assets/images/under_construction.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
