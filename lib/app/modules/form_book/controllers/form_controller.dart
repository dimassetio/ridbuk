import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridbuk/app/data/models/book_model.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:image_picker/image_picker.dart';

class FormController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController pageC = TextEditingController();
  TextEditingController readC = TextEditingController();
  List<String> listCategory = [
    "Action and Adventure",
    "Classics",
    "Comic Book or Graphic Novel",
    "Detective and Mystery",
    "Fantasy",
    "Historical Fiction",
    "Horror",
    "Literary Fiction",
  ];
  String? selectedCategory;
  var imagePath = ''.obs;
  ImagePicker picker = ImagePicker();

  Future pickImage(ImageSource source) async {
    XFile? xfile = await picker.pickImage(source: source);
    if (xfile is XFile) {
      imagePath.value = xfile.path;
    }
  }

  modelToController(Book book) {
    nameC.text = book.name ?? '';
    pageC.text = book.pages?.toString() ?? '';
    readC.text = book.readPage?.toString() ?? '0';
    selectedCategory = book.category;
  }

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(bool value) => _isSaving.value = value;

  Future store(Book book) async {
    isSaving = true;
    book.name = nameC.text;
    book.category = selectedCategory;
    book.pages = int.tryParse(pageC.text);
    book.readPage = int.tryParse(readC.text);
    if (book.id.isEmptyOrNull) {
      book.dateCreated = DateTime.now();
    }
    try {
      await book.save(
          file: imagePath.value.isEmptyOrNull ? null : File(imagePath.value));
      toast("Data Saved Succesfully");
      print("Success");
      Get.back();
    } catch (e) {
      print(e);
    } finally {
      isSaving = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
