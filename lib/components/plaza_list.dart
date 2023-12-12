import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:integrapracas/components/plaza_card.dart';
import 'package:integrapracas/models/praca.dart';

class PlazaList extends StatelessWidget {
  final List<QueryDocumentSnapshot<Object?>> documents;
  PlazaList(
    this.documents, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: documents.length,
        itemBuilder: (_, index) {
          final nome = documents[index]['nome'];
          final id = documents[index].id;
          final capa = documents[index]['capa'];
          final endereco = documents[index]['endereço'];
          final localizacao = documents[index]['localização'];
          Praca praca = Praca(capa: capa, nome: nome, id: id, endereco: endereco, localizacao: localizacao);
          
          return PlazaCard(praca);
        });
  }
}

