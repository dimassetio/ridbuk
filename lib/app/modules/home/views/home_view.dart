// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ridbuk/app/const/color.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ridbuk/app/const/images.dart';
import 'package:ridbuk/app/data/models/reading_model.dart';
import 'package:ridbuk/app/modules/auth/controllers/auth_controller.dart';
import 'package:ridbuk/app/data/models/book_model.dart';
import 'package:ridbuk/app/widgets/read_form.dart';
import 'package:ridbuk/app/routes/app_pages.dart';
import 'package:ridbuk/app/widgets/bottom_bar.dart';
import 'package:ridbuk/app/widgets/widgets.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  AuthController authC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            // textCancel: "Cancel",

            contentPadding: EdgeInsets.zero,
            barrierDismissible: false,
            content: ReadForm(),
            title: "Reading Form",
          );
        },
        child: Icon(
          Icons.add,
          color: clr_white,
          size: 30,
        ),
      ),
      bottomNavigationBar: BotBar(
        authC: authC,
        index: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [clr_secondary, clr_primary],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          SafeArea(
            child: Container(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  16.height,
                  ListTile(
                    visualDensity: VisualDensity(),
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: clr_white,
                      child: Icon(
                        Icons.person,
                        size: 36,
                      ),
                      radius: 40,
                    ),
                    title: text(
                      "Hai",
                      color: clr_white,
                    ),
                    subtitle: text(
                      authC.firebaseUser.value?.email ?? "Email",
                      color: clr_white,
                    ),
                    trailing: Icon(
                      Icons.notifications_outlined,
                      color: clr_white,
                      size: 40,
                    ).paddingRight(16),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text("Book List",
                                color: clr_white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            IconButton(
                              onPressed: () {
                                Get.toNamed(Routes.FORMBOOK);
                              },
                              icon: Icon(
                                Icons.add_circle_outline_outlined,
                                color: clr_white,
                                // size: 30,
                              ),
                            )
                          ],
                        ),
                        16.height,
                        Container(
                          height: 200,
                          alignment: Alignment.centerLeft,
                          child: Obx(() => controller.books.length < 1
                              ? Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        text("No Book Found", color: clr_white),
                                        TextButton(
                                            onPressed: () =>
                                                Get.toNamed(Routes.FORMBOOK),
                                            child: text(
                                              "Add your first book!",
                                              color: clr_white,
                                            ))
                                      ]),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.books.length,
                                  physics: ScrollPhysics(),
                                  itemBuilder: (context, index) => BookCard(
                                    book: controller.books[index],
                                  ).paddingRight(16),
                                )),
                        ),
                        16.height,

                        // Expanded(
                        //   child:
                        Container(
                          // height: Get.height,
                          // width: Get.width,
                          decoration: boxDecorationDefault(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(12),
                                child:
                                    text("Recent Activity", color: clr_primary),
                              ),
                              Obx(
                                () => Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    // itemCount: 100,
                                    itemCount: controller.readings.length,
                                    itemBuilder: (context, index) {
                                      Reading reading =
                                          controller.readings[index];
                                      Book? book = controller.books
                                          .firstWhereOrNull((element) =>
                                              element.id ==
                                              controller
                                                  .readings[index].bookID);
                                      return Container(
                                        color: clr_primary.withOpacity(
                                            index % 2 == 1 ? 0.2 : 0.1),
                                        child: ListTile(
                                          // .withOpacity(index % 2 == 1 ? 0.2 : 0.4),
                                          leading:
                                              book?.images.isEmptyOrNull ?? true
                                                  ? SvgPicture.asset(
                                                      svgCover,
                                                      height: 30,
                                                    )
                                                  : Image.network(
                                                      book!.images!,
                                                      height: 30,
                                                    ),
                                          title: text(book?.name ?? "Book Name",
                                              fontWeight: FontWeight.w400),
                                          // subtitle: text(DateFormat()),
                                          trailing: Card(
                                            color: clr_secondary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4, horizontal: 8),
                                              child: text(
                                                  "${reading.previousPage}-${reading.currentPage}",
                                                  color: clr_white),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).expand(),
                        // ),
                      ],
                    ),
                  ).expand()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookCard extends GetView<HomeController> {
  BookCard({required this.book});
  Book book;

  @override
  Widget build(BuildContext context) {
    RxBool showEdit = false.obs;
    return Obx(
      () => Stack(
        children: [
          InkWell(
            onTap: () => showEdit.value = !showEdit.value,
            child: BoxContainer(
              width: 150,
              height: 200,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: book.images.isEmptyOrNull
                      ? SvgPicture.asset(
                          svgCover,
                          height: 60,
                        )
                      : Image.network(
                          book.images!,
                          height: 60,
                        ),
                ),
                16.height,
                text(book.name ?? "Book Name", color: clr_primary),
                8.height,
                text(book.category ?? "Book Category",
                    color: clr_primary, fontSize: 12),
                // 8.height,
                text("${book.readPage}/${book.pages} Page",
                    color: clr_primary, fontSize: 12),
                8.height,
                text(
                    NumberFormat.percentPattern('id')
                        .format((book.readPage ?? 0) / (book.pages ?? 0)),
                    color: clr_primary),
                2.height,
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: LinearProgressIndicator(
                    value: (book.readPage ?? 0) / (book.pages ?? 0),
                    minHeight: 10,
                    backgroundColor: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          if (showEdit.value)
            BoxContainer(
              width: 150,
              height: 200,
              padding: 0,
              crossAxis: CrossAxisAlignment.center,
              color: clr_primary.withOpacity(0.7),
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        showEdit.value = !showEdit.value;
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: clr_white,
                      )),
                ),
                TextButton.icon(
                    onPressed: () {
                      Get.toNamed(Routes.FORMBOOK, arguments: book);
                      showEdit.value = false;
                    },
                    icon: Icon(
                      Icons.edit,
                      color: clr_white,
                    ),
                    label: text("Edit", color: clr_white)),
                TextButton.icon(
                    onPressed: () {
                      controller.delete(book);
                      showEdit.value = false;
                    },
                    icon: Icon(
                      Icons.delete,
                      color: clr_white,
                    ),
                    label: text("Delete", color: clr_white)),
              ],
            )
        ],
      ),
    );
  }
}
