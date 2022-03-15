// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ridbuk/app/const/color.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ridbuk/app/const/images.dart';
import 'package:ridbuk/app/modules/form_book/controllers/form_controller.dart';
import 'package:ridbuk/app/data/models/book_model.dart';
import 'package:ridbuk/app/widgets/widgets.dart';
import 'package:dropdown_search/dropdown_search.dart';

class FormView extends GetView<FormController> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  Book book = Get.arguments ?? Book();
  @override
  Widget build(BuildContext context) {
    controller.modelToController(book);
    return Scaffold(
        backgroundColor: clr_background,
        appBar: AppBar(
          title: Text('Add Book'),
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _form,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    16.height,
                    BoxContainer(
                      children: [
                        AppTextField(
                          textFieldType: TextFieldType.NAME,
                          isValidationRequired: true,
                          controller: controller.nameC,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.title),
                            labelText: "Book Name",
                          ),
                        ),
                        16.height,
                        DropdownSearch<String>(
                          items: controller.listCategory,
                          onChanged: (value) =>
                              controller.selectedCategory = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                            prefixIcon: Icon(Icons.category),
                            labelText: "Category",
                            contentPadding: EdgeInsets.zero,
                          ),
                          validator: (value) => value.isEmptyOrNull
                              ? "This field is required"
                              : null,
                          selectedItem: controller.selectedCategory,
                        ),
                        16.height,
                        AppTextField(
                          textFieldType: TextFieldType.PHONE,
                          isValidationRequired: true,
                          controller: controller.pageC,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.menu_book),
                            labelText: "Pages",
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        16.height,
                        AppTextField(
                          textFieldType: TextFieldType.PHONE,
                          isValidationRequired: true,
                          controller: controller.readC,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.remove_red_eye_outlined),
                            labelText: "Read Page",
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        16.height,
                      ],
                    ),
                    16.height,
                    BoxContainer(
                      crossAxis: CrossAxisAlignment.center,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: text("Book's Cover")),
                        8.height,
                        Obx(
                          () => ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: !controller.imagePath.value.isEmptyOrNull
                                ? Image.file(
                                    File(controller.imagePath.value),
                                    height: 150,
                                  )
                                : !book.images.isEmptyOrNull
                                    ? Image.network(
                                        book.images!,
                                        height: 150,
                                      )
                                    : SvgPicture.asset(
                                        svgCover,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                          ),
                        ),
                        16.height,
                        TextButton.icon(
                            onPressed: () async {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16))),
                                  builder: (context) => Container(
                                        height: 200,
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(
                                                  top: 16, left: 16),
                                              child: text("Image Source"),
                                            ),
                                            ListTile(
                                                title: text("Camera"),
                                                leading: Icon(
                                                  Icons.camera,
                                                  color: clr_primary,
                                                ),
                                                onTap: () async {
                                                  await controller.pickImage(
                                                      ImageSource.camera);
                                                  Get.back();
                                                }),
                                            ListTile(
                                                title: text("Gallery"),
                                                leading: Icon(
                                                  Icons.photo,
                                                  color: clr_primary,
                                                ),
                                                onTap: () async {
                                                  await controller.pickImage(
                                                      ImageSource.gallery);
                                                  Get.back();
                                                }),
                                          ],
                                        ),
                                      ));
                            },
                            style: ButtonStyle(),
                            icon: Icon(Icons.upload),
                            label: text("Upload Image")),
                      ],
                    ),
                    16.height,
                    Obx(
                      () => Container(
                        width: Get.width,
                        child: FloatingActionButton.extended(
                            onPressed: controller.isSaving
                                ? null
                                : () {
                                    if (_form.currentState!.validate()) {
                                      controller.store(book);
                                    }
                                  },
                            label: controller.isSaving
                                ? CircularProgressIndicator(
                                    color: clr_white,
                                  )
                                : text("Submit")),
                      ),
                    ),
                    16.height,
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
