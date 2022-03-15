import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridbuk/app/const/color.dart';
import 'package:ridbuk/app/modules/auth/controllers/auth_controller.dart';
import 'package:ridbuk/app/routes/app_pages.dart';

class BotBar extends StatelessWidget {
  BotBar({
    required this.authC,
    required this.index,
  });

  final AuthController authC;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: clr_background,
      notchMargin: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: index == 0
                  ? null
                  : () {
                      Get.offNamed(Routes.HOME);
                    },
              icon: Icon(
                Icons.home,
                size: 30,
                color: index == 0 ? clr_primary : clr_grey,
              )),
          IconButton(
              onPressed: index == 1
                  ? null
                  : () {
                      Get.offNamed(authC.firebaseUser.value == null
                          ? Routes.AUTH
                          : Routes.PROFILE);
                    },
              icon: Icon(
                Icons.person,
                size: 30,
                color: index == 1 ? clr_primary : clr_grey,
              )),
        ],
      ),
    );
  }
}
