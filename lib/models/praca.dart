import 'package:cloud_firestore/cloud_firestore.dart';

class Praca {
  String id;
  String capa;
  String nome;
  String localizacao;
  String endereco;

  Praca(
      {this.id = '',
      this.capa = '',
      this.nome = '',
      this.localizacao = '',
      this.endereco = ''});
}
