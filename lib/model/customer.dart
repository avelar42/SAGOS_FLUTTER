// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  Customer({
    required this.nome,
    required this.sobrenome,
    required this.telefone,
    required this.cpf,
    required this.dataNascimento,
  });

  String nome;
  String sobrenome;
  String telefone;
  String cpf;
  DateTime dataNascimento;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        nome: json["nome"] == null ? null : json["nome"],
        sobrenome: json["sobrenome"] == null ? null : json["sobrenome"],
        telefone: json["telefone"] == null ? null : json["telefone"],
        cpf: json["CPF"] == null ? null : json["CPF"],
        dataNascimento: DateTime.parse(json["dataNascimento"]),
      );

  Map<String, dynamic> toJson() => {
        "nome": nome == null ? null : nome,
        "sobrenome": sobrenome == null ? null : sobrenome,
        "telefone": telefone == null ? null : telefone,
        "CPF": cpf == null ? null : cpf,
        "dataNascimento":
            dataNascimento == null ? null : dataNascimento.toIso8601String(),
      };
}
