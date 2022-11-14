import 'package:firebase_auth/firebase_auth.dart';

import '/loginPages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'classes/appUser.dart';
import 'control_panel.dart';
import 'firebase_options.dart';
//furkan
late Appuser stateCurrentUser;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  stateCurrentUser = Get.put(Appuser());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ControlPanel());
  }
}
