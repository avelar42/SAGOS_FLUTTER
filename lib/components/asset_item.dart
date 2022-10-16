import 'package:flutter/material.dart';
import 'package:sagos_mobile/model/asset.dart';
import 'package:sagos_mobile/utils/app_routes.dart';

class AssetItem extends StatelessWidget {
  const AssetItem(this.asset, this.customerId, {Key? key}) : super(key: key);

  final Asset asset;
  final String customerId;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(asset.descricao),
      subtitle: Text(asset.identificacao.toString()),
      trailing: Container(
        width: 150,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.CUSTOMER_ASSET_FORM,
                      arguments: [asset, customerId]);
                },
                icon: Icon(Icons.edit),
                color: Colors.blue),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.delete), color: Colors.red),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.check_circle),
                color: Colors.green)
          ],
        ),
      ),
    );
  }
}
