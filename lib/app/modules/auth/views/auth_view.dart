// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ridbuk/app/const/color.dart';
import 'package:ridbuk/app/const/images.dart';
import 'package:ridbuk/app/routes/app_pages.dart';
import 'package:ridbuk/app/widgets/widgets.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  GlobalKey<FormState> _form = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('AuthView'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Container(
          height: Get.height,
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Obx(
              () => Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      svgLogin,
                      height: 200,
                    ),
                    16.height,
                    BoxContainer(
                      children: [
                        if (controller.isRegis)
                          AppTextField(
                            controller: controller.nameC,
                            textFieldType: TextFieldType.NAME,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                labelText: "Name"),
                            isValidationRequired: true,
                          ),
                        if (controller.isRegis) 16.height,
                        AppTextField(
                          controller: controller.emailC,
                          textFieldType: TextFieldType.EMAIL,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: "Email"),
                          errorInvalidEmail: "Invalid Email",
                        ),
                        16.height,
                        AppTextField(
                          controller: controller.passwordC,
                          isValidationRequired: true,
                          textFieldType: TextFieldType.PASSWORD,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              labelText: "Password",
                              suffixIconColor: clr_primary),
                        ),
                        16.height,
                        if (controller.isRegis)
                          Column(
                            children: [
                              AppTextField(
                                controller: controller.confirmPasswordC,
                                validator: (value) =>
                                    value == controller.passwordC.text
                                        ? null
                                        : "Password doesn't match",
                                isValidationRequired: true,
                                textFieldType: TextFieldType.PASSWORD,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock),
                                    labelText: "Confirm Password",
                                    suffixIconColor: clr_primary),
                              ),
                              16.height,
                              ListTile(
                                leading: Container(
                                    width: 24,
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: clr_primary,
                                    )),
                                onTap: () async =>
                                    await controller.handleBirthDate(context),
                                title: text("Birth Date", fontSize: 12),
                                subtitle: text(
                                    controller.selectedDate is DateTime
                                        ? DateFormat("EEE, dd MMM y")
                                            .format(controller.selectedDate!)
                                        : '--'),
                              ),
                              Divider(
                                color: clr_primary,
                                height: 0,
                                thickness: 1,
                              ),
                              16.height,
                              FormField<int>(
                                validator: (value) =>
                                    controller.selectedGender > 0
                                        ? null
                                        : "This field is required",
                                builder: (state) => Obx(
                                  () => ListTile(
                                    visualDensity: VisualDensity.compact,
                                    title: text("Gender"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    subtitle: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: RadioListTile<int>(
                                                value: 10,
                                                groupValue:
                                                    controller.selectedGender,
                                                onChanged: (value) =>
                                                    controller.selectedGender =
                                                        value ?? 0,
                                                title: text("Male"),
                                              ),
                                            ),
                                            Expanded(
                                              child: RadioListTile<int>(
                                                value: 20,
                                                groupValue:
                                                    controller.selectedGender,
                                                onChanged: (value) =>
                                                    controller.selectedGender =
                                                        value ?? 0,
                                                title: text("Female"),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (state.hasError)
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: text(state.errorText,
                                                color: Colors.red[900],
                                                fontSize: 12),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    32.height,
                    Obx(
                      () => AppButton(
                        shapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        width: Get.width,
                        text: controller.isSaving ? "" : "Submit",
                        child: controller.isSaving
                            ? CircularProgressIndicator()
                            : null,
                        color: clr_primary,
                        textColor: clr_white,
                        onTap: controller.isSaving
                            ? null
                            : () async {
                                if (_form.currentState!.validate()) {
                                  controller.isSaving = true;
                                  controller.isRegis
                                      ? await controller.signUp()
                                      : await controller.signIn();
                                  controller.isSaving = false;
                                }
                                // Get.toNamed(Routes.HOME);
                              },
                      ),
                    ),
                    // 16.height,
                    TextButton(
                      onPressed: () {
                        controller.isRegis = !controller.isRegis;
                      },
                      style: ButtonStyle(visualDensity: VisualDensity.compact),
                      child: Text(controller.isRegis
                          ? "Already have account? Login here"
                          : "Doesn't Have Account? Register!"),
                    ),
                    TextButton(
                      style: ButtonStyle(visualDensity: VisualDensity.compact),
                      onPressed: () {},
                      child: Text("Forgot Password?"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
