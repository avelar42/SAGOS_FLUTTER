import 'package:sagos_mobile/model/address.dart';
import 'package:sagos_mobile/model/asset.dart';

class Customer {
  Customer(
      {required this.id,
      required this.nome,
      required this.sobrenome,
      this.telefone,
      this.cpf,
      this.dataNascimento,
      this.assets,
      this.address});
  String id;
  String nome;
  String sobrenome;
  String? telefone;
  String? cpf;
  DateTime? dataNascimento;
  List<Asset>? assets;
  List<Address>? address;
}
