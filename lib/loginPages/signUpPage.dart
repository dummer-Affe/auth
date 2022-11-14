import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestorage/control_panel.dart';
import '/main.dart';
import '/loginPages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';



class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

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
            "Create Your Account",
            style: TextStyle(fontSize: 40),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30.0, left: 30),
                child: TextField(
                    controller: email,
                    decoration: const InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        hintText: 'E-Mail Address',
                        //hintStyle: appFonts.S(),
                        suffixIcon: Icon(Icons.type_specimen
                            //color: appColors.textColor,
                            ))),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30.0, left: 30, top: 20),
                child: TextField(
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        hintText: 'Password',
                        //hintStyle: appFonts.S(),
                        suffixIcon: Icon(Icons.type_specimen
                            //color: appColors.textColor,
                            ))),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () async {
                  try {
                    await stateCurrentUser.signUpEmail(
                        email: email.text, password: password.text);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ControlPanel()),
                    );
                  } catch (e) {
                    print("zorrrrrrrrrrrrrry");
                  }
                },
                child: Text("Sign Up")),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ControlPanel()),
                );
              },
              child: Icon(Icons.arrow_back)),
        ],
      ),
    );
  }
}
