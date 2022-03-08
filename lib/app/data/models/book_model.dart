import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ridbuk/app/data/database.dart';
import 'package:nb_utils/nb_utils.dart';

class Book {
  String? id;
  String? name;
  String? category;
  int? pages;
  int? readPage;
  String? images;
  DateTime? dateCreated;

  Book(
      {this.id,
      this.name,
      this.category,
      this.pages,
      this.readPage,
      this.images,
      this.dateCreated});

  Book.fromJson(DocumentSnapshot snapshot) {
    Map<String, dynamic>? json = snapshot.data();
    id = snapshot.id;
    name = json?['name'];
    category = json?['category'];
    pages = json?['pages'];
    readPage = json?['readPage'];
    images = json?['images'];
    dateCreated = (json?['dateCreated']).toDate();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category'] = category;
    data['pages'] = pages;
    data['readPage'] = readPage;
    data['images'] = images;
    data['dateCreated'] = dateCreated;
    return data;
  }

  Database db = Database(
      collectionReference: firestore.collection(
        bookCollection,
      ),
      storageReference: storage.ref(bookCollection));

  Future<Book> save({File? file}) async {
    id.isEmptyOrNull ? id = await db.add(toJson()) : await db.edit(toJson());
    if (file != null && !id.isEmptyOrNull) {
      images = await db.upload(id: id!, file: file);
      db.edit(toJson());
    }
    return this;
  }

  Future delete() async {
    if (id.isEmptyOrNull) {
      Get.snackbar("Error", "Invalid documents Id");
      return;
    }
    return await db.delete(id!, url: images);
  }

  Stream<List<Book>> streamList() async* {
    yield* db.collectionReference
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((query) {
      List<Book> list = [];
      for (var doc in query.docs) {
        list.add(
          Book.fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }
}
