// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ridbuk/app/const/color.dart';
import 'package:ridbuk/app/const/images.dart';
import 'package:ridbuk/app/modules/auth/controllers/auth_controller.dart';
import 'package:ridbuk/app/widgets/bottom_bar.dart';
import 'package:ridbuk/app/widgets/widgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final AuthController authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: clr_background,
        bottomNavigationBar: BotBar(
          authC: authC,
          index: 1,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: Get.width,
                child: SvgPicture.asset(
                  svgBgProfile,
                  fit: BoxFit.fill,
                  height: 350,
                ),
              ),
              SafeArea(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              foregroundImage: NetworkImage(sampleProfile),
                            ),
                            32.width,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                16.height,
                                text("Name", fontSize: 18, color: clr_white),
                                text("name@gmail.com",
                                    fontSize: 16, color: clr_white),
                                Expanded(child: SizedBox()),
                                TextButton.icon(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          clr_white.withOpacity(0.2)),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(horizontal: 12)),
                                      foregroundColor:
                                          MaterialStateProperty.all(clr_white),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            side: BorderSide(color: clr_white)),
                                      ),
                                    ),
                                    icon: Icon(Icons.edit),
                                    label: text("Edit Profile"))
                              ],
                            ))
                          ],
                        ),
                      ),
                      32.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BoxContainer(
                            padding: 8,
                            radius: 8,
                            crossAxis: CrossAxisAlignment.center,
                            children: [
                              text("Total Books"),
                              text("300", color: clr_primary, fontSize: 32),
                            ],
                          ),
                          BoxContainer(
                            padding: 8,
                            radius: 8,
                            crossAxis: CrossAxisAlignment.center,
                            children: [
                              text("Total Read"),
                              text("300", color: clr_primary, fontSize: 32),
                            ],
                          ),
                        ],
                      ),
                      32.height,
                      ListTile(
                        leading: Icon(
                          Icons.email_outlined,
                          color: clr_primary,
                        ),
                        title: text("youremail@mail.com"),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: clr_primary,
                        ),
                        title: text("+62856434567"),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.cake,
                          color: clr_primary,
                        ),
                        title:
                            text(DateFormat.MMMMEEEEd().format(DateTime(1999))),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.male,
                          color: clr_primary,
                        ),
                        title: text("Male"),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.female,
                          color: clr_primary,
                        ),
                        title: text("Female"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
