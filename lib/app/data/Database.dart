import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
const userCollection = "User";
const bookCollection = "Books";

class Database {
  CollectionReference collectionReference;
  Reference storageReference;
  Database({required this.collectionReference, required this.storageReference});

  Future<String?> add(Map<String, dynamic> json) async {
    try {
      DocumentReference res = await collectionReference.add(json);
      return res.id;
    } on FirebaseException catch (e) {
      Get.snackbar(e.code, e.message ?? '');
    } catch (e) {
      Get.snackbar("Unknown Error", e.toString());
    }
  }

  // Stream<QuerySnapshot> snapshots() {
  //   return collectionReference
  //       .orderBy("dateCreated", descending: true)
  //       .snapshots();
  // }

  Future edit(Map<String, dynamic> json) async {
    try {
      return await collectionReference.doc(json["id"]).update(json);
    } on FirebaseException catch (e) {
      Get.snackbar(e.code, e.message ?? '');
      rethrow;
    }
    // catch (e) {
    //   Get.snackbar("Unknown Error", e.toString());
    //   rethrow;
    // }
  }

  Future delete(String id, {String? url}) async {
    try {
      if (url is String) {
        await storage.refFromURL(url).delete();
      }
      return await collectionReference.doc(id).delete();
    } on FirebaseException catch (e) {
      Get.snackbar(e.code, e.message ?? '');
      rethrow;
    }
    // catch (e) {
    //   Get.snackbar("Unknown Error", e.toString());
    //   rethrow;
    // }
  }

  Future<String?> upload({required String id, required File file}) async {
    try {
      String? url;
      var task = await storageReference.child(id).putFile(file);
      if (task.state == TaskState.success) {
        return await storageReference.child(id).getDownloadURL();
      }

      Get.defaultDialog(
          middleText: "An error occured when uploading photo",
          textConfirm: "Try Again");
      // task.snapshotEvents.listen((event) async {
      //   if (event.state == TaskState.success) {
      //     return await storage.child(id).getDownloadURL();
      //   }
      // });

    } on FirebaseException catch (e) {
      Get.snackbar(e.code, e.message ?? '');
      rethrow;
    } catch (e) {
      Get.snackbar("Unknown Error", e.toString());
      rethrow;
    }
  }
}
