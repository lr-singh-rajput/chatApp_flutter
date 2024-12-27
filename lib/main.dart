import 'package:chatapp/Config/PagePath.dart';
import 'package:chatapp/Config/Themes.dart';
import 'package:chatapp/Controller/CallController.dart';
import 'package:chatapp/Pages/SplaceScreen/SplacePage.dart';
import 'package:chatapp/Pages/Welcome/WelcomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    CallController callController = Get.put(CallController());
    return GetMaterialApp(
      builder: FToastBuilder(),
      title: "ChatApp",
      theme: lightTheme,
      getPages: pagePath,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const Splacepage(),
    );
  }
}


