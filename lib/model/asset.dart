class Asset {
  Asset(
      {required this.id,
      required this.descricao,
      required this.codigo,
      this.identificacao});

  final String id;
  final String codigo;
  final String descricao;
  final String? identificacao;
}
