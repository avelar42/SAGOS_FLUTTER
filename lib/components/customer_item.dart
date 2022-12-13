import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sagos_mobile/model/customer.dart';
import 'package:sagos_mobile/view_models/customer_view_model.dart';
import '../utils/app_routes.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomerItem extends StatelessWidget {
  const CustomerItem(this.customer, {Key? key}) : super(key: key);

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    var phoneMask = new MaskTextInputFormatter(
        mask: '+55(##)#####-####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    return ListTile(
      tileColor: Colors.white,
      title: Text('${customer.nome} ${customer.sobrenome}'),
      subtitle: Text(
        phoneMask.maskText(customer.telefone as String),
        style: TextStyle(color: Colors.grey),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CUSTOMER_FORM_EDIT,
                    arguments: customer);
              },
              icon: Icon(Icons.edit),
              color: Colors.blue,
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Excluir cliente'),
                          content: Text('Tem certeza?'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.of(ctx).pop(false),
                                child: Text('Nao')),
                            TextButton(
                                onPressed: () => Navigator.of(ctx).pop(true),
                                child: Text('Sim'))
                          ],
                        )).then((value) async {
                  if (value ?? false) {
                    await Provider.of<CustomerViewModel>(context, listen: false)
                        .removeCustomer(customer);
                  }
                });
              },
              icon: Icon(Icons.delete),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
