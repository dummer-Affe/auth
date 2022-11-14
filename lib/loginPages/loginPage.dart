// ignore_for_file: use_build_context_synchronously

import '/classes/appUser.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../main.dart';
import 'auth_service.dart';

import 'phoneLogin.dart';
import 'signUpPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Welcome",
            style: TextStyle(fontSize: 40),
          ),
          Column(
            children: [
              SizedBox(
                width: width,
                height: height / 8,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 40, right: 40),
                  child: TextField(
                      controller: email,
                      decoration: const InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                          hintText: 'E-Mail Address',
                          //hintStyle: appFonts.S(),
                          suffixIcon: Icon(Icons.type_specimen
                              //color: appColors.textColor,
                              ))),
                ),
              ),
              SizedBox(
                width: width,
                height: height / 8,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 40, right: 40),
                  child: TextField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                          hintText: 'Password',
                          //hintStyle: appFonts.S(),
                          suffixIcon: Icon(Icons.type_specimen
                              //color: appColors.textColor,
                              ))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: login, child: Text("Login")),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0, top: 5),
                child: Text("Login or Sign up With : "),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: TextButton(
                          onPressed: () async {
                            stateCurrentUser.signInGoogle();
                          },
                          child: Image.network(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png")),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: TextButton(
                        onPressed: () async {
                          stateCurrentUser.signInFacebook();
                        },
                        child: Image.network(
                            "https://t.ctcdn.com.br/Aj24sYbFoXOnIS1CWTaRHHdiIxg=/400x400/smart/i489928.jpeg")),
                  ),
                  SizedBox(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhoneLoginPage()),
                          );
                        },
                        child: Icon(
                          Icons.phone,
                          size: 40,
                        )),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: Icon(
                        Icons.email,
                        size: 40,
                      )),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  login() {
    try {
      stateCurrentUser.signInEmail(email: email.text, password: password.text);
    } catch (e) {}
  }
}
