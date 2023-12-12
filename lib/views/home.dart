import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:integrapracas/components/plaza_list.dart';
import 'package:integrapracas/components/side_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        drawer: SideDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Praças'),
        ),
        body: FutureBuilder<QuerySnapshot>(
            future: _firestore.collection('pracas').orderBy('nome').get(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    heightFactor: double.infinity, widthFactor: double.infinity, child: CircularProgressIndicator());
              }
              final documents = snapshot.data!.docs;
              return PlazaList(documents);
            }));
  }
}
