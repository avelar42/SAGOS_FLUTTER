import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sagos_mobile/components/asset_item.dart';
import 'package:sagos_mobile/model/customer.dart';
import 'package:sagos_mobile/utils/app_routes.dart';

import '../view_models/customer_view_model.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({Key? key}) : super(key: key);

  @override
  _AssetsScreenState createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  String _customerId = "";
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final arg = ModalRoute.of(context)?.settings.arguments as List<Customer>;
    if (arg.length > 0) {
      //print(arg.length);
      //print(arg[0].nome);
      _customerId = arg[0].id;
    }
  }

  @override
  Widget build(BuildContext context) {
    CustomerViewModel customerViewModel = context.watch<CustomerViewModel>();
    final Customer customer = customerViewModel.getCustomer(_customerId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ativos'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CUSTOMER_ASSET_FORM,
                    arguments: [_customerId]);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (context, index) => Column(
            children: [
              customer.assets != null
                  ? AssetItem(customer.assets![index])
                  : Text('Nao possui dados')
            ],
          ),
          itemCount: customer.assets != null ? customer.assets!.length : 0,
        ),
      ),
    );
  }
}
