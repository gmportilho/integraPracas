import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserComments extends StatelessWidget {
  const UserComments({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          'Meus Comentários',
        ),
        leading: BackButton(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('comentarios')
                        .where('userid', isEqualTo: auth.currentUser!.uid)
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
                            return Slidable(
                              actionPane: SlidableScrollActionPane(),
                              actions: [
                                IconSlideAction(
                                  caption: 'Apagar',
                                  icon: Icons.delete,
                                  color: Colors.red,
                                  onTap: () {
                                    _firestore.collection("comentarios").doc(doc.id).delete();
                                  },
                                )
                              ],
                              child: Card(
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
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .all(
                                                                  Radius.elliptical(
                                                                      50, 50)),
                                                          color: Colors
                                                              .greenAccent),
                                                      child: Text(
                                                          doc['categoria'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)))
                                                ],
                                              ),
                                              SizedBox(height: 12),
                                              Container(
                                                  child:
                                                      Text(doc['comentario'])),
                                              SizedBox(height: 20),
                                              Container(
                                                  child: Text(
                                                'Praça: ${doc['nomePraca']}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ))
                                            ]),
                                      ),
                                    )
                                  ],
                                ),
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
