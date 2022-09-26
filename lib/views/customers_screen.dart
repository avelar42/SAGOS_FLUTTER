import 'package:flutter/material.dart';
import 'package:sagos_mobile/components/app_drawer.dart';
import 'package:sagos_mobile/model/customer.dart';
import 'package:sagos_mobile/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:sagos_mobile/view_models/customer_view_model.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({Key? key}) : super(key: key);

  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
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
            : Column(
                children: [
                  Container(
                    child: Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              Customer customerModel =
                                  customerViewModel.customerListModel[index];
                              return Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(customerModel.nome),
                                    Text(
                                      customerModel.sobrenome,
                                    ),
                                    Text(
                                      customerModel.telefone,
                                    ),
                                    Text(
                                      customerModel.cpf,
                                    ),
                                    Text(
                                      customerModel.dataNascimento.toString(),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Divider(),
                            itemCount:
                                customerViewModel.customerListModel.length)),
                  ),
                ],
              ));
  }
}
