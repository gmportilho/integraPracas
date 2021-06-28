import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class AlteraSenha extends StatefulWidget {
  @override
  _AlteraSenhaState createState() => _AlteraSenhaState();
}

class _AlteraSenhaState extends State<AlteraSenha> {
  final formKey = GlobalKey<FormState>();
  final senhaController = new TextEditingController();
  final senhaConfirmController = new TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
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
      child: Text('Altere sua senha',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
    );
  }

  Widget botaoConfirmar() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
        child: const Text('Confirmar'),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            auth.currentUser?.updatePassword(senhaController.text);
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text('Senha alterada com sucesso!'),
              ));
            Navigator.of(context).pushNamed('/pracas');
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
                    fillColor: Colors.white,
                    filled: true,
                    focusColor: Color(0XFF7A9337),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0XFFBBCC8F), width: 2.0)),
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
          primary: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          side: BorderSide(color: Colors.black)),
      child: Text(
        'Voltar',
        style: TextStyle(color: Colors.black87),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
