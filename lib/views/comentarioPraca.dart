import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:integrapracas/models/praca.dart';
import 'package:provider/provider.dart';

class ComentarioPraca extends StatelessWidget {
  const ComentarioPraca({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    var db = FirebaseFirestore.instance;
    var comentarioPraca = new TextEditingController();
    var dadosPraca = ModalRoute.of(context)!.settings.arguments as Praca;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Adicionar Comentário'),
          leading: BackButton(),
        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.all(50),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft, child: Text('Categoria')),
                SizedBox(height: 3),
                Categorias(),
                SizedBox(height: 50),
                Container(
                    alignment: Alignment.centerLeft, child: Text('Seu texto')),
                SizedBox(height: 3),
                TextFormField(
                    controller: comentarioPraca,
                    maxLines: 5,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        focusColor: Color(0XFF7A9337),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0XFFBBCC8F), width: 2.0)))),
                SizedBox(height: 80),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(padding: EdgeInsets.all(30)),
                    child: const Text('Adicionar Comentário'),
                    onPressed: () {
                      db.collection('comentarios').add({
                        'usuario': user!.displayName,
                        'userid': user.uid,
                        'categoria':
                            Provider.of<ValueCategoria>(context, listen: false)
                                .getCategoriaValue,
                        'comentario': comentarioPraca.text,
                        'praca': dadosPraca.id,
                        'timestamp': Timestamp.now(),
                        'nomePraca': dadosPraca.nome
                      });
                      Navigator.pop(context);
                    }),
              ],
            ),
          )
        ]));
  }
}

class Categorias extends StatefulWidget {
  const Categorias({Key? key}) : super(key: key);

  @override
  _CategoriasState createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  @override
  Widget build(BuildContext context) {
    String? categoriaValue;
    return DropdownButtonFormField<String>(
      value:
          Provider.of<ValueCategoria>(context, listen: false).getCategoriaValue,
      items: ["Manutenção", "Sugestão de Melhoria", "Evento"]
          .map((label) => DropdownMenuItem(
                child: Text(label),
                value: label,
              ))
          .toList(),
      onChanged: (value) {
        Provider.of<ValueCategoria>(context, listen: false)
            .setCategoriaValue(value);
        setState(() {
          categoriaValue = value!;
        });
      },
    );
  }
}

class ValueCategoria extends ChangeNotifier {
  String? categoriaValue;

  String? get getCategoriaValue => this.categoriaValue;

  void setCategoriaValue(String? value) {
    this.categoriaValue = value;
    notifyListeners();
  }
}
