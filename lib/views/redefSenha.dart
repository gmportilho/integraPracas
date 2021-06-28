import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RedefinirSenha extends StatelessWidget {
  const RedefinirSenha({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final redefineSenha = new TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Redefinir a Senha'),
        leading: BackButton(),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: Text(
                  'Insira o email da sua conta para redefinir a senha. Enviaremos uma confirmação para verificar se o dono da conta solicitou a mudança.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                )),
                SizedBox(height: 8),
                TextFormField(
                    controller: redefineSenha,
                    decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    focusColor: Color(0XFF7A9337),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0XFFBBCC8F), width: 2.0)),
                    border: OutlineInputBorder(),
                    hintText: 'Email'),),
                SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.all(30)),
                  child: const Text('Redefinir senha'),
                  onPressed: () async {
                    await firebaseAuth.sendPasswordResetEmail(
                        email: redefineSenha.text.trim());
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
