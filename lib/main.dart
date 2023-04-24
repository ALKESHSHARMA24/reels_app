//use for create the UI for the our app.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels_app/controllers/auth_controller.dart';
import 'package:reels_app/views/screens/auth/login_screen.dart';
import 'package:reels_app/constants.dart';
import 'package:reels_app/views/screens/auth/signup_screen.dart';
import 'package:reels_app/views/screens/home_screen.dart';
import 'package:reels_app/views/screens/video_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reels app',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundcolor,
      ),

      //here home will use for which screen we want to show
      home: VideoScreen(),
    );
  }
}
