class Asset {
  Asset(
      {required this.id,
      required this.descricao,
      required this.codigo,
      this.identificacao});

  String id;
  String codigo;
  String descricao;
  String? identificacao;
}
