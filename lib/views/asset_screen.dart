import 'package:flutter/material.dart';
import 'package:sagos_mobile/model/customer.dart';
import 'package:sagos_mobile/utils/app_routes.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({Key? key}) : super(key: key);

  @override
  _AssetsScreenState createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final arg = ModalRoute.of(context)?.settings.arguments as List<Customer>;
    if (arg.length > 0) {
      print(arg.length);
      print(arg[0].nome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ativos'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CUSTOMER_ASSET_FORM);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(child: Text('form')),
      ),
    );
  }
}
