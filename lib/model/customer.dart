class Customer {
  Customer({
    required this.id,
    required this.nome,
    required this.sobrenome,
    this.telefone,
    this.cpf,
    this.dataNascimento,
  });
  String id;
  String nome;
  String sobrenome;
  String? telefone;
  String? cpf;
  DateTime? dataNascimento;
}
