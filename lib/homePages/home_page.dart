import 'package:firebase_auth/firebase_auth.dart';
import '/classes/appUser.dart';
import '/loginPages/loginPage.dart';
import '/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String providerName;
  @override
  void initState() {
    getproviderId();
    if (providerName == "google.com" || providerName == "facebook.com") {
      print(stateCurrentUser.user!.providerData);
    }
    print(stateCurrentUser.email);
    // TODO: implement initState
    super.initState();
  }

  void getproviderId() {
    Iterable<String> providerid =
        stateCurrentUser.user!.providerData.map((e) => e.providerId);
    providerName = providerid.single;
    print(providerName + "z");
  }

  Widget photoGetter() {
    if (providerName == "google.com" || providerName == "facebook.com") {
      return Image.network(
        stateCurrentUser.user!.photoURL!,
        width: 200,
        height: 200,
        fit: BoxFit.fill,
      );
    } else {
      return SizedBox();
    }
  }

  Widget nameGetter() {
    if (providerName == "google.com" || providerName == "facebook.com") {
      return Text(
        stateCurrentUser.user!.displayName!,
        style: TextStyle(fontSize: 40),
      );
    } else {
      return Text(stateCurrentUser.email!, style: TextStyle(fontSize: 30));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Appuser>(builder: (controllerr) {
      return Scaffold(
        body: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              photoGetter(),
              nameGetter(),
              SizedBox(
                width: 100,
                child: TextButton(
                    onPressed: () async {
                      print("object");
                      if (providerName == "google.com") {
                        await GoogleSignIn().disconnect();
                        FirebaseAuth.instance.signOut();
                      }
                      if (providerName == "facebook.com") {
                        await FacebookAuth.instance.logOut();
                        FirebaseAuth.instance.signOut();
                      } else {
                        FirebaseAuth.instance.signOut();
                      }
                      stateCurrentUser.signOut();
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 80,
                        ),
                        Text("LOGOUT"),
                      ],
                    )),
              )
            ],
          ),
        ),
      );
    });
  }
}
