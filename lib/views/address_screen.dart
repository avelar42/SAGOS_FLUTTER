import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sagos_mobile/components/address_item.dart';
import 'package:sagos_mobile/model/address.dart';
import 'package:sagos_mobile/model/customer.dart';
import 'package:sagos_mobile/utils/app_routes.dart';
import 'package:sagos_mobile/view_models/customer_view_model.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String _customerId = "";
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)?.settings.arguments as Customer;
    _customerId = arg.id;
  }

  @override
  Widget build(BuildContext context) {
    CustomerViewModel customerViewModel = context.watch<CustomerViewModel>();
    final Customer customer = customerViewModel.getCustomer(_customerId);

    return Scaffold(
        appBar: AppBar(
          title: Text('Endereços'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.CUSTOMER_ADDRESS_FORM, arguments: [
                    Address(
                        cep: '',
                        id: '',
                        rua: '',
                        numero: null,
                        bairro: '',
                        cidade: '',
                        ativo: true),
                    _customerId
                  ]);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemBuilder: ((context, index) => Column(
                    children: [
                      AddressItem(customer.address![index], _customerId),
                      Padding(padding: EdgeInsets.all(3))
                    ],
                  )),
              itemCount:
                  customer.address != null ? customer.address!.length : 0),
        ),
        backgroundColor: Theme.of(context).backgroundColor);
  }
}
