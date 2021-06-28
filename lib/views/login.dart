import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:integrapracas/models/praca.dart';
import 'package:integrapracas/views/listaPracas.dart';
import 'cadastro.dart';

class LoginView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = new TextEditingController();
  final senhaController = new TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    getLocalizacao() async {
      Position? position = await Geolocator.getLastKnownPosition();
      print(position);
    }

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        // appBar: AppBar(title: Text('Cadastro')),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset('logoIntegraPracas.png'),
                ),
                SizedBox(height: 20),
                Container(
                  padding: new EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InputEmail(controller: emailController),
                        SizedBox(height: 20),
                        InputSenha(controller: senhaController),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 25)),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              realizaLogin(context);
                            }
                          },
                          child: Text('Login'),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                            onTap: () => {
                                  Navigator.of(context)
                                      .pushNamed('/redefinir-senha')
                                },
                            child: Text('Esqueci minha senha',
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    decoration: TextDecoration.underline,
                                    fontSize: 18))),
                        SizedBox(height: 15),
                        Divider(thickness: 2),
                        SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 25),
                              side: BorderSide(color: Color(0XFF7A9337))),
                          child: Text(
                            'Cadastre-se',
                            style: TextStyle(color: Color(0XFF7A9337)),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/cadastro');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void realizaLogin(BuildContext context) async {
    void _handleFirebaseLoginWithCredentialsException(
        FirebaseAuthException e, StackTrace s) {
      if (e.code == 'user-disabled') {
        String erroMsg = 'O usuário informado está desabilitado.';
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(erroMsg),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'))
                  ],
                ));
        print(e.code.toString());
      } else if (e.code == 'user-not-found') {
        String erroMsg = 'O usuário informado não está cadastrado.';
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(erroMsg),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'))
                  ],
                ));
        print(e.code.toString());
      } else if (e.code == 'invalid-email') {
        String erroMsg = 'O domínio do e-mail informado é inválido.';
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(erroMsg),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'))
                  ],
                ));
        print(e.code.toString());
      } else if (e.code == 'wrong-password') {
        String erroMsg = 'Email ou senha informados estão incorretos';
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(erroMsg),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'))
                  ],
                ));
      } else {
        return null;
      }
    }

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text, password: senhaController.text);
      Navigator.of(context).pushNamed('/pracas');
    } on FirebaseAuthException catch (e, s) {
      _handleFirebaseLoginWithCredentialsException(e, s);
    }
  }
}
