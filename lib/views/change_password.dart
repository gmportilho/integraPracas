import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:integrapracas/themes/appcolors.dart';
import 'package:integrapracas/utils/routes.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final formKey = GlobalKey<FormState>();
  final senhaController = new TextEditingController();
  final senhaConfirmController = new TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                tituloRegistro(),
                Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InputSenha(controller: senhaController),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BotaoVoltar(),
                          botaoConfirmar(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget tituloRegistro() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Text('Altere sua senha', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
    );
  }

  Widget botaoConfirmar() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
        child: const Text('Confirmar'),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            auth.currentUser?.updatePassword(senhaController.text);
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text('Senha alterada com sucesso!'),
              ));
            Navigator.of(context).pushNamed(AppRoutes.HOME_VIEW);
          }
        });
  }
}

class InputSenha extends StatefulWidget {
  final TextEditingController controller;

  const InputSenha({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _InputSenhaState createState() => _InputSenhaState();
}

class _InputSenhaState extends State<InputSenha> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(alignment: Alignment.centerLeft, child: Text('Senha:')),
        SizedBox(height: 3),
        Center(
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
                fillColor: AppColors.white,
                filled: true,
                focusColor: AppColors.green,
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.lightGreen, width: 2.0)),
                border: OutlineInputBorder(),
                hintText: 'Senha'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Insira uma senha';
              } else if (value.length < 6) {
                return 'A senha deve ter mais de 6 caracteres';
              }
              return null;
            },
            controller: widget.controller,
          ),
        )
      ],
    );
  }
}

class BotaoVoltar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          side: BorderSide(color: AppColors.black)),
      child: Text(
        'Voltar',
        style: TextStyle(color: AppColors.black),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
