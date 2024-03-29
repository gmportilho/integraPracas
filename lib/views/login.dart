import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:integrapracas/themes/appcolors.dart';
import 'package:integrapracas/utils/routes.dart';
import 'register.dart';

class LoginView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = new TextEditingController();
  final senhaController = new TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        // appBar: AppBar(title: Text('Cadastro')),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset('assets/logoIntegraPracas.png'),
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
                          style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25)),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              _realizaLogin(context);
                            }
                          },
                          child: Text('Login'),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                            onTap: () => {Navigator.of(context).pushNamed(AppRoutes.FORGOT_MY_PASSWORD)},
                            child: Text('Esqueci minha senha',
                                style: TextStyle(
                                    color: AppColors.grey, decoration: TextDecoration.underline, fontSize: 18))),
                        SizedBox(height: 15),
                        Divider(thickness: 2),
                        SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              padding: EdgeInsets.symmetric(horizontal: 70, vertical: 25),
                              side: BorderSide(color: AppColors.green)),
                          child: Text(
                            'Cadastre-se',
                            style: TextStyle(color: AppColors.green),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoutes.REGISTER);
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

  void _realizaLogin(BuildContext context) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: emailController.text, password: senhaController.text);
      Navigator.of(context).pushNamed(AppRoutes.HOME_VIEW);
    } on FirebaseAuthException catch (error) {
      _handleFirebaseLoginWithCredentialsException(context, error);
    }
  }
}

void _handleFirebaseLoginWithCredentialsException(BuildContext context, FirebaseAuthException error) {
  if (error.code == 'user-disabled') {
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
    print(error.code.toString());
  } else if (error.code == 'user-not-found') {
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
    print(error.code.toString());
  } else if (error.code == 'invalid-email') {
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
    print(error.code.toString());
  } else if (error.code == 'wrong-password') {
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
    String erroMsg = error.message!;
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
  }
}
