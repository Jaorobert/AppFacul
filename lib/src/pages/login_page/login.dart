import 'dart:convert';
import 'package:app_facul/src/data/services/socket-service.dart';
import 'package:app_facul/src/pages/home_page/home_page.dart';
import 'package:app_facul/src/pages/semeters_page/semeter.dart';
import 'package:flutter/material.dart';
import 'package:app_facul/src/data/services/api_login.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final controleEmail = TextEditingController();
  final controleSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 60,
          ),
          child: ListView(
            children: [
              SizedBox(
                width: 128,
                height: 128,
                child: Image.asset('assets/imgs/logo-unicv.png'),
              ),
              const SizedBox(height: 20),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controleEmail,
                      decoration: const InputDecoration(
                        labelText: 'RA ou E-mail',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: controleSenha,
                      decoration: const InputDecoration(
                        labelText: 'Senha:',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          try {
                            Response loginSuccess =
                                await LoginServices.enviarAluno({
                              'email': controleEmail.text,
                              'password': controleSenha.text,
                            });

                            final Map<String, dynamic> jsonLoginResponse =
                                json.decode(loginSuccess.body);

                            if (jsonLoginResponse['bo_login']) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SemeterPage()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Falha no login! Login e/ou Senha incorretos!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } catch (error) {
                            return print(error);
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(72, 92, 57, 1),
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                          const Size(150, 35),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Esqueci a senha.'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
