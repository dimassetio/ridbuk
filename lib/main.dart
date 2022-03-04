import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ridbuk/app/const/color.dart';
import 'package:ridbuk/app/modules/auth/controllers/auth_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  await Firebase.initializeApp();
  AuthController authC = Get.put(AuthController());
  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute:
          authC.firebaseUser.value != null ? Routes.HOME : Routes.AUTH,
      getPages: AppPages.routes,
      navigatorKey: navigatorKey,
      theme: lightTheme,
    ),
  );
}
