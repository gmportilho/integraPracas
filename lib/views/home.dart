import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:integrapracas/models/praca.dart';
import 'package:integrapracas/themes/appcolors.dart';
import 'package:integrapracas/utils/routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        key: _scaffoldKey,
        drawer: SideDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Praças'),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('pracas').orderBy('nome').snapshots(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    heightFactor: double.infinity, widthFactor: double.infinity, child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    var doc = snapshot.data!.docs[index];
                    return Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      height: 220,
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          var nomePraca = doc['nome'];
                          var idPraca = doc.id;
                          var capaPraca = doc['capa'];
                          Navigator.of(context).pushNamed(AppRoutes.PLAZA_INFO,
                              arguments: Praca(id: idPraca, nome: nomePraca, capa: capaPraca));
                        },
                        child: Card(
                          elevation: 5,
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: NetworkImage(doc['capa']), fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(height: 20),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Center(
                                          child: Text(doc['nome'],
                                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Container(
                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0), child: Text(doc['endereço'])),
                                      Container(height: 50)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }));
  }
}

class Pra {
  String id;
  String nome;
  String capa;

  get getId => this.id;

  get getNome => this.nome;

  get getCapa => this.capa;

  Pra(this.id, this.nome, this.capa);
}

class SideDrawer extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Column(
                children: [
                  Container(
                    child: Text(
                      '${auth.currentUser?.displayName}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  Text(
                    '${auth.currentUser?.email}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: AppColors.brown,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Editar Dados'),
                        onTap: () async {
                          Navigator.of(context).pushNamed(AppRoutes.CHANGE_USER_DATA);
                        }),
                    ListTile(
                        leading: Icon(Icons.chat_bubble),
                        title: Text('Meus Comentários'),
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.USER_COMMENTS);
                        }),
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Sair'),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushNamed(AppRoutes.LOGIN);
                      },
                    )
                  ],
                ),
                ListTile(
                    leading: Icon(
                      Icons.delete_forever,
                      color: Colors.red.shade400,
                    ),
                    title: Text('Apagar conta', style: TextStyle(color: Colors.red.shade400)),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text(
                                    'Tem certeza que deseja apagar a sua conta? Todos os seus dados serão perdidos.',
                                    style: TextStyle(color: Colors.black, fontSize: 16)),
                                actions: [
                                  TextButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Não',
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  TextButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                      onPressed: () async {
                                        await auth.currentUser!.delete();
                                        Navigator.of(context).pushNamed(AppRoutes.LOGIN);
                                      },
                                      child: Text('Sim, tenho certeza', style: TextStyle(color: Colors.red.shade400)))
                                ],
                              ));
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
