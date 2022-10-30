import 'package:flutter/material.dart';
import 'package:sagos_mobile/model/address.dart';
import 'package:sagos_mobile/utils/app_routes.dart';

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
              onPressed: () {},
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.check_circle),
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
