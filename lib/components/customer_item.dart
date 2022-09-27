import 'package:flutter/material.dart';
import 'package:sagos_mobile/model/customer.dart';
import '../utils/app_routes.dart';

class CustomerItem extends StatelessWidget {
  const CustomerItem(this.customer, {Key? key}) : super(key: key);

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${customer.nome} ${customer.sobrenome}'),
      subtitle: Text(
        customer.telefone,
        style: TextStyle(color: Colors.grey),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CUSTOMER_FORM_EDIT);
              },
              icon: Icon(Icons.edit),
              color: Colors.blue,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
