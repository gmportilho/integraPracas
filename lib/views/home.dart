import 'package:flutter/material.dart';
import 'package:integrapracas/views/alterarDados.dart';
import 'package:integrapracas/views/alterarSenha.dart';
import 'package:integrapracas/views/cadastro.dart';
import 'package:integrapracas/views/classeComentario.dart';
import 'package:integrapracas/views/evento.dart';
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
        '/': (context) => LoginView(),
        '/cadastro': (context) => CadastroView(),
        '/edita': (context) => AlterarDadosView(),
        '/redefinir-senha': (context) => RedefinirSenha(),
        '/alteraSenha': (context) => AlteraSenha(),
        '/pracas': (context) => ListaPracas(),
        '/add-melhoria': (context) => ComentarioPraca(),
        '/add-evento': (context) => EventoPage(),
        '/selecionaCategoria': (context) => ClasseComentario(),
        '/comments': (context) => InfoPracaView(),
        '/my-comments': (context) => UserComments()
      },
    );
  }
}
