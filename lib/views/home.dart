import 'package:flutter/material.dart';
import 'package:integrapracas/utils/routes.dart';
import 'package:integrapracas/views/alterarDados.dart';
import 'package:integrapracas/views/alterarSenha.dart';
import 'package:integrapracas/views/cadastro.dart';
import 'package:integrapracas/views/classeComentario.dart';
import 'package:integrapracas/views/evento.dart';
import 'package:integrapracas/views/manutencao.dart';
import 'package:integrapracas/views/sugestaoDeMelhoria.dart';
import 'package:integrapracas/views/infoPraca.dart';
import 'package:integrapracas/views/listaPracas.dart';
import 'package:integrapracas/views/login.dart';
import 'package:integrapracas/views/redefSenha.dart';
import 'package:integrapracas/views/usuarioComments.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF3D3129), //Marrom
        backgroundColor: Color(0xFFF5F1E0), //Bege
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0XFF7A9337)))),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF3D3129),
          titleTextStyle: TextStyle(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      routes: {
        AppRoutes.HOME: (context) => LoginView(),
        AppRoutes.REGISTER: (context) => CadastroView(),
        AppRoutes.CHANGE_USER_DATA: (context) => AlterarDadosView(),
        AppRoutes.FORGOT_MY_PASSWORD: (context) => RedefinirSenha(),
        AppRoutes.CHANGE_PASSWORD: (context) => AlteraSenha(),
        AppRoutes.PLAZAS: (context) => ListaPracas(),
        AppRoutes.PLAZA_INFO: (context) => InfoPracaView(),
        AppRoutes.SELECT_CATEGORY: (context) => ClasseComentario(),
        AppRoutes.ADD_SUGGESTION: (context) => ComentarioPraca(),
        AppRoutes.ADD_EVENT: (context) => EventoPage(),
        AppRoutes.ADD_MAINTENANCE: (context) => Manutencao(),
        AppRoutes.USER_COMMENTS: (context) => UserComments()
      },
    );
  }
}
