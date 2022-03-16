import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ridbuk/app/const/images.dart';
import 'package:ridbuk/app/data/database.dart';
import 'package:ridbuk/app/data/models/book_model.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ridbuk/app/data/models/reading_model.dart';
import 'package:ridbuk/app/widgets/widgets.dart';

class HomeController extends GetxController {
  RxList<Book> rxBooks = RxList<Book>();
  List<Book> get books => rxBooks.value;
  set books(List<Book> value) => rxBooks.value = value;

  RxList<Reading> rxreadings = RxList<Reading>();
  List<Reading> get readings => rxreadings.value;
  set readings(List<Reading> value) => rxreadings.value = value;

  var _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  // Stream<List<Book>> booksStream() async* {
  //   yield* database.snapshots().map((query) {
  //     List<Book> list = [];
  //     for (var doc in query.docs) {
  //       list.add(
  //         Book.fromJson(
  //           doc,
  //         ),
  //       );
  //     }
  //     return list;
  //   });
  // }

  Future<Reading?> saveRead(Reading reading) async {
    try {
      isLoading = true;

      var res = await reading.save();
      Book book = books.firstWhere((element) => element.id == reading.bookID,
          orElse: () => Book());
      if (!book.id.isEmptyOrNull) {
        book.readPage = reading.currentPage;
        await book.save();
      }
      Get.back();
      toast("Read activity saved ");
      return res;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading = false;
    }
  }

  Future delete(Book book) async {
    if (book.id.isEmptyOrNull) {
      Get.snackbar("Error", "Book Id not found");
      return Future.value(null);
    }
    try {
      Get.defaultDialog(
        onConfirm: () async {
          try {
            await book.delete();
            Get.back();
          } catch (e) {
            print(e);
          }
        },
        textConfirm: "OK",
        textCancel: "Cancel",
        content: Column(
          children: [
            SvgPicture.asset(
              svgDelete,
              width: Get.width,
              height: 100,
            ),
            8.height,
            text("Are you sure to delete this data?"),
          ],
        ),
        title: "Confirm delete",
      );
    } on Exception catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    rxBooks.bindStream(Book().streamList());
    rxreadings.bindStream(Reading().streamAllList());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
