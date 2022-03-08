// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ridbuk/app/const/color.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ridbuk/app/const/images.dart';
import 'package:ridbuk/app/modules/auth/controllers/auth_controller.dart';
import 'package:ridbuk/app/data/models/book_model.dart';
import 'package:ridbuk/app/routes/app_pages.dart';
import 'package:ridbuk/app/widgets/widgets.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  AuthController authC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: clr_background,
        notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.home,
                  size: 30,
                )),
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.AUTH);
                },
                icon: Icon(
                  Icons.person,
                  size: 30,
                  color: clr_grey,
                )),
          ],
        ),
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
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  16.height,
                  ListTile(
                    visualDensity: VisualDensity(),
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 36,
                      ),
                      radius: 40,
                    ),
                    title: text(
                      "Hai",
                      color: Colors.white,
                    ),
                    subtitle: text(
                      authC.firebaseUser.value?.email ?? "Email",
                      color: Colors.white,
                    ),
                    trailing: Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
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
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            IconButton(
                              onPressed: () {
                                Get.toNamed(Routes.FORMBOOK);
                              },
                              icon: Icon(
                                Icons.add_circle_outline_outlined,
                                color: Colors.white,
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
                                        text("No Book Found",
                                            color: Colors.white),
                                        TextButton(
                                            onPressed: () =>
                                                Get.toNamed(Routes.FORMBOOK),
                                            child: text(
                                              "Add your first book!",
                                              color: Colors.white,
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
                              ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: 15,
                                itemBuilder: (context, index) => Container(
                                  color: clr_primary
                                      .withOpacity(index % 2 == 1 ? 0.2 : 0.1),
                                  child: ListTile(
                                    // .withOpacity(index % 2 == 1 ? 0.2 : 0.4),
                                    leading: SvgPicture.asset(
                                      svgCover,
                                      height: 30,
                                    ),
                                    title: text("Book Name",
                                        fontWeight: FontWeight.w400),
                                    subtitle: text("Sat, 26 Feb 2020, 12.15"),
                                    trailing: Card(
                                      color: clr_secondary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        child:
                                            text("1-20", color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ),
                      ],
                    ),
                  )
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
                        color: Colors.white,
                      )),
                ),
                TextButton.icon(
                    onPressed: () {
                      Get.toNamed(Routes.FORMBOOK, arguments: book);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    label: text("Edit", color: Colors.white)),
                TextButton.icon(
                    onPressed: () {
                      controller.delete(book);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    label: text("Delete", color: Colors.white)),
              ],
            )
        ],
      ),
    );
  }
}
