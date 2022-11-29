class Asset {
  Asset({
    required this.id,
    required this.ativo,
    required this.descricao,
    this.identificacao,
  });

  String id;
  String descricao;
  String? identificacao;
  bool ativo;
}
