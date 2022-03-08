import 'package:get/get.dart';

import 'package:ridbuk/app/modules/form_book/controllers/form_controller.dart';

import '../../home/controllers/home_controller.dart';

class FormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormController>(
      () => FormController(),
    );
  }
}
