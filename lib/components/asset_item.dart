import 'package:flutter/material.dart';
import 'package:sagos_mobile/model/asset.dart';

class AssetItem extends StatelessWidget {
  const AssetItem(this.asset, {Key? key}) : super(key: key);

  final Asset asset;

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
                onPressed: () {}, icon: Icon(Icons.edit), color: Colors.blue),
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
