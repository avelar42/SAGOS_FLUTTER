// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

class Customer {
  Customer({
    required this.id,
    required this.nome,
    required this.sobrenome,
    required this.telefone,
    required this.cpf,
    required this.dataNascimento,
  });
  String id;
  String nome;
  String sobrenome;
  String telefone;
  String cpf;
  DateTime dataNascimento;
}
