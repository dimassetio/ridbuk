import 'package:nb_utils/nb_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridbuk/app/data/database.dart';
import 'package:ridbuk/app/modules/auth/models/user_model.dart';
import 'package:ridbuk/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> streamAuth() => _auth.authStateChanges();

  var currUser = UserModel().obs;
  UserModel get user => currUser.value;
  set user(UserModel value) => currUser.value = value;

  var _isRegis = false.obs;
  bool get isRegis => _isRegis.value;
  set isRegis(value) => _isRegis.value = value;

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(value) => _isSaving.value = value;

  var _selectedGender = 0.obs;
  int get selectedGender => _selectedGender.value;
  set selectedGender(int value) => _selectedGender.value = value;

  Rx<DateTime?> _selectedDate = DateTime(2000).obs;
  DateTime? get selectedDate => _selectedDate.value;
  set selectedDate(DateTime? value) => _selectedDate.value = value;

  handleBirthDate(dynamic context) async {
    selectedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            initialDatePickerMode: DatePickerMode.year,
            firstDate:
                DateTime(selectedDate?.year ?? DateTime.now().year - 100),
            lastDate: DateTime.now()) ??
        selectedDate;
  }

  late Rx<User?> firebaseUser;
  final count = 0.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController confirmPasswordC = TextEditingController();
  TextEditingController nameC = TextEditingController();

  signIn() async {
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: emailC.text, password: passwordC.text)
          .then((value) => Get.toNamed(Routes.HOME));
    } on FirebaseAuthException catch (e) {
      Get.snackbar(e.code, e.message ?? '');
    } catch (e) {
      Get.snackbar("error", e.toString());
    }
  }

  signUp() async {
    try {
      isSaving = true;
      UserModel user = UserModel(
        name: nameC.text,
        birthDate: selectedDate,
        gender: selectedGender,
        dateCreated: DateTime.now(),
        email: emailC.text,
        password: passwordC.text,
      );

      _auth
          .createUserWithEmailAndPassword(
        email: emailC.text,
        password: passwordC.text,
      )
          .then((value) {
        user.id = value.user?.uid;
        if (!user.id.isEmptyOrNull) {
          firestore
              .collection(userCollection)
              .doc(user.id)
              .set(user.toJson)
              .then((value) {
            Get.toNamed(Routes.HOME);
            toast("Register Success");
          });
        }
      });
      isSaving = false;
    } on FirebaseAuthException catch (e) {
      isSaving = false;
      Get.snackbar(e.code, e.message ?? '');
    }
  }

  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailC.clear();
    passwordC.clear();
  }

  // void increment() => count.value++;
}
