import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:integrapracas/models/praca.dart';
import 'package:integrapracas/views/comentarioPraca.dart';
import 'package:integrapracas/views/listaPracas.dart';

class InfoPracaView extends StatefulWidget {
  const InfoPracaView({Key? key}) : super(key: key);

  @override
  _InfoPracaViewState createState() => _InfoPracaViewState();
}

class _InfoPracaViewState extends State<InfoPracaView> {
  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    var dadosPraca = ModalRoute.of(context)!.settings.arguments as Praca;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          '${dadosPraca.nome}',
        ),
      ),
      body: Column(
        children: [
          Image.asset('assets/${dadosPraca.id}_1.png'),
          SizedBox(
              height: 100,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  primary: Color(0xFFF5F1E0),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/addcomment', arguments: dadosPraca);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.message,
                      color: Colors.black,
                    ),
                    Text('Adicionar Comentário',
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
              )),
          Expanded(
            child: Container(
                decoration: BoxDecoration(color: Color(0xFFF5F1E0)),
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('comentarios')
                        .where('praca', isEqualTo: dadosPraca.id)
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            heightFactor: double.infinity,
                            widthFactor: double.infinity,
                            child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (_, index) {
                            var doc = snapshot.data!.docs[index];
                            var categoria = doc['categoria'];
                            return Card(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Text(doc['usuario'],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 0, 10, 0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            new BorderRadius
                                                                    .all(
                                                                Radius
                                                                    .elliptical(
                                                                        50,
                                                                        50)),
                                                        color:
                                                            Colors.greenAccent),
                                                    child: Text(categoria))
                                              ],
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                                child: Text(doc['comentario'])),
                                          ]),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    })),
          )
        ],
      ),
    );
  }
}
