import 'package:get/get.dart';
import 'package:ridbuk/app/modules/form_book/bindings/form_binding.dart';
import 'package:ridbuk/app/modules/form_book/views/form_view.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.FORMBOOK,
      page: () => FormView(),
      binding: FormBinding(),
    ),
  ];
}
