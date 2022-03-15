import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ridbuk/app/data/database.dart';
import 'package:nb_utils/nb_utils.dart';

const String fID = "ID";
const String fname = "Name";
const String femail = "Email";
const String fpassword = "Password";
const String fgender = "Gender";
const String fbirthDate = "Birthdate";
const String fdateCreated = "Datecreated";
const String fimages = "Images";

class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? images;
  int? gender;
  DateTime? birthDate;
  DateTime? dateCreated;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.images,
    this.gender,
    this.birthDate,
    this.dateCreated,
  });

  UserModel fromJson(Map<String, dynamic> json) => UserModel(
        id: json[fID],
        name: json[fname],
        email: json[femail],
        password: json[fpassword],
        gender: json[fgender],
        birthDate: json[fbirthDate],
        images: json[fimages],
      );

  Map<String, dynamic> get toJson => {
        fID: id,
        fname: name,
        femail: email,
        fpassword: password,
        fgender: gender,
        fbirthDate: birthDate,
        fimages: images,
      };

  Database db = Database(
      collectionReference: firestore.collection(
        bookCollection,
      ),
      storageReference: storage.ref(bookCollection));

  Future<UserModel> save({File? file}) async {
    id.isEmptyOrNull ? id = await db.add(toJson) : await db.edit(toJson);
    if (file != null && !id.isEmptyOrNull) {
      images = await db.upload(id: id!, file: file);
      db.edit(toJson);
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

  Stream<List<UserModel>> streamList() async* {
    yield* db.collectionReference
        .orderBy(fdateCreated, descending: true)
        .snapshots()
        .map((query) {
      List<UserModel> list = [];
      for (var doc in query.docs) {
        list.add(
          fromJson(
            doc.data(),
          ),
        );
      }
      return list;
    });
  }
}
