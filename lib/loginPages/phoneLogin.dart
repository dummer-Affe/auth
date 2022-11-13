import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestorage/control_panel.dart';
import '../classes/appUser.dart';
import '/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool otpVisibility = false;
  PhoneVerifier? verifier;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Login With Your Phone",
              style: TextStyle(fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30.0, left: 30),
              child: SizedBox(
                height: 80,
                child: TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Phone Number',
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text('+90'),
                    ),
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30.0, left: 30),
              child: Visibility(
                // ignore: sort_child_properties_last
                child: SizedBox(
                  height: 80,
                  child: TextField(
                    controller: otpController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      hintText: 'Your Sms Code',
                      prefix: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(''),
                      ),
                    ),
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                  ),
                ),
                visible: otpVisibility,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            OutlinedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0))),
              ),
              onPressed: () async {
                if (otpVisibility) {
                  try {
                    await verifier!.verifyOTP(otpController.text);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ControlPanel()),
                    );
                  } catch (e) {
                    print("zoooooooooooooooooort");
                  }
                } else {
                  stateCurrentUser.signInPhone(
                      phone: "+90${phoneController.text}",
                      verificationFailed: (error) {
                        print(error);
                      },
                      codeSent: (verifier) {
                        this.verifier = verifier;
                        setState(() {
                          otpVisibility = true;
                        });
                      });
                }
              },
              child: Text(
                otpVisibility ? "Verify" : "Login",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
