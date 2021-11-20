import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/features/intro/views/intro_view.dart';
import 'package:new_ways_app/utils/matrix_effect/matrix_effect.dart';

import 'main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _userctrl = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 2),
        () => ((_userctrl.hive!.get('employee_id')) != '' &&
                (_userctrl.hive!.get('password')) != '' &&
                (_userctrl.hive!.get('employee_id')) != null &&
                (_userctrl.hive!.get('password')) != null)
            ? Get.off(() => MainPage())
            : Get.off(() => IntroView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            MatrixEffect(),
            Center(
              child: Container(
                child: Hero(
                    tag: 'eltanvir',
                    child: Image.asset('assets/images/splash_logo.png')),
              ),
            ),
          ],
        ));
  }
}
