import 'package:firestorage/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'classes/appUser.dart';

import 'homePages/home_page.dart';
import 'loginPages/loginPage.dart';

class ControlPanel extends StatefulWidget {
  const ControlPanel({super.key});

  @override
  State<ControlPanel> createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  _ControlPanelState() {
    stateCurrentUser.addListener(setstatehere);
  }
  setstatehere() {
    print("object");
    setState(() {});
  }

  @override
  void dispose() {
    stateCurrentUser.removeListener(setstatehere);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<Appuser>(builder: (controller) {

        return controller.isAuthenticated ? HomePage() : LoginPage();
      }),
    );
  }
}
