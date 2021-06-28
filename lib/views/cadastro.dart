import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:integrapracas/views/login.dart';

class CadastroView extends StatefulWidget {
  @override
  _CadastroViewState createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  final formKey = GlobalKey<FormState>();
  final emailController = new TextEditingController();
  final emailconfirmcontroller = new TextEditingController();
  final usuarioController = new TextEditingController();
  final senhaController = new TextEditingController();
  final senhaConfirmController = new TextEditingController();
  final firebaseAuth = FirebaseAuth.instance;

  void cadastroUser() async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text, password: senhaController.text);
    final user = firebaseAuth.currentUser;
    user!.updateDisplayName(usuarioController.text.toUpperCase());
    user.sendEmailVerification();
  }

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
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
                        InputNome(controller: usuarioController),
                        SizedBox(height: 10),
                        InputEmail(controller: emailController),
                        SizedBox(height: 10),
                        InputSenha(controller: senhaController),
                        SizedBox(height: 20),
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
          ),
        ));
  }

  Widget tituloRegistro() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Text('Registre sua Conta.',
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
            cadastroUser();
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text('Cadastro efetuado com sucesso!'),
              ));

            Navigator.of(context).pushNamed('/');
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(alignment: Alignment.centerLeft, child: Text('Nome:')),
        SizedBox(height: 3),
        Center(
            child: TextFormField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    focusColor: Color(0XFF7A9337),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0XFFBBCC8F), width: 2.0)),
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

class InputConfirmarSenha extends StatefulWidget {
  const InputConfirmarSenha({Key? key}) : super(key: key);

  @override
  _InputConfirmarSenhaState createState() => _InputConfirmarSenhaState();
}

class _InputConfirmarSenhaState extends State<InputConfirmarSenha> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            child: Text('Confirme a sua senha:')),
        SizedBox(height: 3),
        Center(
            child: TextFormField(
                controller: _CadastroViewState().senhaConfirmController,
                obscureText: true,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    focusColor: Color(0XFF7A9337),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0XFFBBCC8F), width: 2.0)),
                    border: OutlineInputBorder(),
                    hintText: 'Confirmação de Senha'),
                validator: (value) {
                  if (_CadastroViewState().senhaController.text !=
                      _CadastroViewState().senhaConfirmController.text) {
                    return 'As senhas não são iguais';
                  }
                  return null;
                })),
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
                    fillColor: Colors.white,
                    filled: true,
                    focusColor: Color(0XFF7A9337),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0XFFBBCC8F), width: 2.0)),
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

class Termos extends StatefulWidget {
  @override
  _TermosState createState() => _TermosState();
}

class _TermosState extends State<Termos> {
  bool valor = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: valor,
        onChanged: (value) {
          setState(() {
            valor = !valor;
          });
        },
        title: Text('Aceito os Termos de Uso'),
      ),
    );
  }
}
