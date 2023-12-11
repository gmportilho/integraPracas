import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:integrapracas/themes/appcolors.dart';
import 'package:integrapracas/utils/routes.dart';

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
                      style: TextStyle(color: AppColors.white, fontSize: 25),
                    ),
                  ),
                  Text(
                    '${auth.currentUser?.email}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.white, fontSize: 15),
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
                      color: AppColors.red,
                    ),
                    title: Text('Apagar conta', style: TextStyle(color: AppColors.red)),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text(
                                    'Tem certeza que deseja apagar a sua conta? Todos os seus dados serão perdidos.',
                                    style: TextStyle(color: AppColors.black, fontSize: 16)),
                                actions: [
                                  TextButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.white),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Não',
                                        style: TextStyle(color: AppColors.black),
                                      )),
                                  TextButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.white),
                                      onPressed: () async {
                                        await auth.currentUser!.delete();
                                        Navigator.of(context).pushNamed(AppRoutes.LOGIN);
                                      },
                                      child: Text('Sim, tenho certeza', style: TextStyle(color: AppColors.red)))
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
