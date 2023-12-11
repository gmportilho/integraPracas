import 'package:cloud_firestore/cloud_firestore.dart';

class Praca {
  String id;
  String capa;
  String nome;
  String endereco;
  GeoPoint localizacao;

  Praca(
      {required this.id,
      required this.capa,
      required this.nome,
      required this.localizacao,
      required this.endereco});
}
