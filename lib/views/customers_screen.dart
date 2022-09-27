import 'package:flutter/material.dart';
import 'package:sagos_mobile/components/app_drawer.dart';
import 'package:sagos_mobile/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:sagos_mobile/view_models/customer_view_model.dart';

import '../components/customer_item.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({Key? key}) : super(key: key);

  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CustomerViewModel>(context, listen: false).getCustomers();
  }

  @override
  Widget build(BuildContext context) {
    CustomerViewModel customerViewModel = context.watch<CustomerViewModel>();

    return Scaffold(
        appBar: AppBar(title: Text('Clientes'), actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.CUSTOMER_FORM),
              icon: Icon(Icons.add))
        ]),
        drawer: AppDrawer(),
        body: customerViewModel.loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemBuilder: (ctx, i) => Column(
                      children: [
                        CustomerItem(customerViewModel.customerListModel[i]),
                        Divider()
                      ],
                    ),
                itemCount: customerViewModel.getItensCount()));
  }
}
