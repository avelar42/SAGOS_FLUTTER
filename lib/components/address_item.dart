import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sagos_mobile/model/address.dart';
import 'package:sagos_mobile/utils/app_routes.dart';

import '../view_models/customer_view_model.dart';

class AddressItem extends StatelessWidget {
  const AddressItem(this.address, this.customerId, {Key? key})
      : super(key: key);

  final Address address;
  final String customerId;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${address.rua} - ${address.numero}'),
      subtitle: Text('${address.cidade}'),
      trailing: Container(
        width: 150,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CUSTOMER_ADDRESS_FORM,
                    arguments: [address, customerId]);
              },
              icon: Icon(Icons.edit),
              color: Colors.blue,
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Deseja excluir este endreço?'),
                          content: Text('Tem certeza?'),
                          actions: [
                            TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text('Nao')),
                            TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text('Sim'))
                          ],
                        )).then((value) async {
                  if (value ?? false) {
                    await Provider.of<CustomerViewModel>(context, listen: false)
                        .removeAddress(address, customerId);
                  }
                });
              },
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
            IconButton(
              onPressed: () {
                Provider.of<CustomerViewModel>(context, listen: false)
                    .changeAddressStatus(address, customerId);
              },
              icon: Icon(Icons.check_circle),
              color: address.ativo == true ? Colors.green : Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
