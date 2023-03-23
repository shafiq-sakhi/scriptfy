import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_to_image/home_page.dart';
import 'package:text_to_image/models/user_model.dart';
import 'package:text_to_image/view/screens/welcome_screen.dart';

import '../../controller/admin_base_controller.dart';
import '../../utils/data_cache.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserStatus();
  }

  void checkUserStatus() async {
    await DataCache.init();

    var userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    if (userId.isEmpty) {
      await Future.delayed(Duration(seconds: 2));
      Get.offAll(WelcomePage());
      return;
    }
    var userData =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    AdminBaseController.updateUser(
        UserModel.fromJson(userData.data() ?? {}));
    await Future.delayed(Duration(seconds: 1));
    Get.offAll(MyHomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset("assets/logo.png",width: Get.size.width*0.80,),
      )),
    );
  }
}
