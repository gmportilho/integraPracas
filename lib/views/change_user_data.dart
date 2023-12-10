import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:integrapracas/themes/appcolors.dart';
import 'package:integrapracas/utils/routes.dart';

class ChangeUserDataView extends StatefulWidget {
  @override
  _ChangeUserDataViewState createState() => _ChangeUserDataViewState();
}

class _ChangeUserDataViewState extends State<ChangeUserDataView> {
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: '${FirebaseAuth.instance.currentUser?.email}');
  final usuarioController = TextEditingController(text: '${FirebaseAuth.instance.currentUser?.displayName}');

  // @override
  // void dispose() {
  //   emailController.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  tituloAlterarDados(),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InputNome(controller: usuarioController),
                        SizedBox(height: 10),
                        InputEmail(controller: emailController),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BotaoVoltar(),
                            botaoConfirmar(),
                          ],
                        ),
                        SizedBox(height: 50),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text('Para alterar sua senha, clique no botão abaixo:')),
                        SizedBox(height: 3),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          height: 80,
                          width: double.infinity,
                          child: ElevatedButton(
                              child: Text('Alterar Senha'),
                              onPressed: () {
                                Navigator.of(context).pushNamed(AppRoutes.CHANGE_PASSWORD);
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget tituloAlterarDados() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Text('Alterar Dados', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
    );
  }

  Widget botaoConfirmar() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
        child: const Text('Confirmar'),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text('Alterações efetuadas com sucesso!'),
              ));
            auth.currentUser!.updateEmail(emailController.text);
            auth.currentUser!.updateDisplayName(usuarioController.text.toUpperCase());
            Navigator.of(context).pushNamed(AppRoutes.HOME_VIEW);
          }
        });
  }
}

class InputNome extends StatefulWidget {
  final TextEditingController controller;

  const InputNome({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _InputNomeState createState() => _InputNomeState();
}

class _InputNomeState extends State<InputNome> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(alignment: Alignment.centerLeft, child: Text('Nome:')),
        SizedBox(height: 3),
        Center(
            child: TextFormField(
                decoration: InputDecoration(
                    fillColor: AppColors.white,
                    filled: true,
                    focusColor: AppColors.green,
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.lightGreen, width: 2.0)),
                    border: OutlineInputBorder(),
                    hintText: 'Nome'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira um Nome';
                  } else if (value.length < 3) {
                    return 'O nome deve ter mais de 3 caracteres';
                  }
                  return null;
                },
                controller: widget.controller)),
      ],
    );
  }
}

class InputEmail extends StatefulWidget {
  final TextEditingController controller;

  const InputEmail({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _InputEmailState createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(alignment: Alignment.centerLeft, child: Text('Email:')),
        SizedBox(height: 3),
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              fillColor: AppColors.white,
              filled: true,
              focusColor: AppColors.green,
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.lightGreen, width: 2.0)),
              border: OutlineInputBorder(),
              hintText: 'Email'),
          validator: (email) {
            if ((email!.isEmpty)) {
              return 'Insira um email';
            } else if (!EmailValidator.validate(email)) {
              return 'Email Inválido';
            }
            return null;
          },
        ),
      ],
    );
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
        Navigator.of(context).pushNamed(AppRoutes.HOME_VIEW);
      },
    );
  }
}
