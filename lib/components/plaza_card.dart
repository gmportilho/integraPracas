import 'package:flutter/material.dart';
import 'package:integrapracas/models/praca.dart';
import 'package:integrapracas/utils/routes.dart';

class PlazaCard extends StatelessWidget {
  const PlazaCard(
    this.praca, {
    Key? key,
  }) : super(key: key);

  final Praca praca;

  @override
  Widget build(BuildContext context) {
    final plazaPicture = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: NetworkImage(praca.capa), fit: BoxFit.fill),
      ),
    );
    final plazaInfo = Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(praca.nome, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Text(praca.endereco),
        ],
      ),
    );
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: 200,
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.PLAZA_INFO, arguments: praca);
        },
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Flexible(
                  flex: 4,
                  child: plazaPicture,
                ),
                Flexible(
                  flex: 5,
                  child: plazaInfo,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
