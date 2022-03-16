// ignore_for_file: prefer_const_constructors

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ridbuk/app/const/color.dart';
import 'package:ridbuk/app/data/models/book_model.dart';
import 'package:ridbuk/app/data/models/reading_model.dart';
import 'package:ridbuk/app/modules/home/controllers/home_controller.dart';
import 'package:ridbuk/app/widgets/widgets.dart';

class ReadForm extends GetView<HomeController> {
  Book? selectedBook;
  TextEditingController previousC = TextEditingController();
  TextEditingController currentC = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Obx(
        () => Form(
          key: _form,
          child: Column(
            children: [
              DropdownSearch<Book>(
                items: controller.books,
                itemAsString: (book) => book?.name ?? '',
                mode: Mode.MENU,
                enabled: !controller.isLoading,
                onChanged: (book) {
                  selectedBook = book;
                  print(book?.readPage ?? "Null");
                  previousC.text = book?.readPage.toString() ?? "";
                },
                dropdownSearchDecoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: Icon(Icons.book),
                  labelText: "Select Book",
                ),
              ),
              AppTextField(
                textFieldType: TextFieldType.PHONE,
                isValidationRequired: true,
                controller: previousC,
                enabled: !controller.isLoading,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.remove_red_eye_outlined),
                  labelText: "Previous Page",
                ),
                readOnly: true,
              ),
              TextFormField(
                // textFieldType: TextFieldType.PHONE,
                // isValidationRequired: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: currentC,
                enabled: !controller.isLoading,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.menu_book),
                  labelText: "Current Page",
                ),
                validator: (value) {
                  if (value.isEmptyOrNull) {
                    return "This field is required";
                  }
                  if (selectedBook == null) return "Select book first";

                  if ((int.tryParse(value ?? '') ?? 0) >=
                      (selectedBook!.pages as num)) {
                    return "This field can't more than book's total pages";
                  }
                  if ((int.tryParse(value ?? '') ?? 0) <=
                      (selectedBook!.readPage as num)) {
                    return "This field can't less than previous page";
                  }
                },
              ),
              16.height,
              Row(
                children: [
                  ElevatedButton(
                    onPressed: controller.isLoading
                        ? null
                        : () {
                            if (_form.currentState!.validate()) {
                              var res = controller.saveRead(Reading(
                                bookID: selectedBook?.id,
                                currentPage: currentC.text.toInt(),
                                previousPage: previousC.text.toInt(),
                              ));
                              // controller.isLoading = !controller.isLoading;
                            }
                          },
                    child: controller.isLoading
                        ? Container(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                                // color: clr_white,
                                ))
                        : text("Submit"),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      )),
                    ),
                  ).expand(),
                  8.width,
                  TextButton(
                    onPressed: () => Get.back(),
                    child: text("Cancel"),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(color: clr_primary, width: 1))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
