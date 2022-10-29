class Address {
  Address(
      {required this.id,
      this.cep,
      required this.rua,
      this.bairro,
      this.cidade,
      required this.numero});

  String id;
  String? cep;
  String rua;
  String? bairro;
  String? cidade;
  int numero;
}
