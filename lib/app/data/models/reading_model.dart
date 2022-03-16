import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ridbuk/app/data/database.dart';
import 'package:nb_utils/nb_utils.dart';

class Reading {
  String? id;
  String? bookID;
  int? previousPage;
  int? currentPage;
  DateTime? dateCreated;

  Reading(
      {this.id,
      this.bookID,
      this.previousPage,
      this.currentPage,
      this.dateCreated});

  Reading.fromJson(DocumentSnapshot snapshot) {
    Map<String, dynamic>? json = snapshot.data();
    id = json?['id'];
    bookID = json?['bookID'];
    previousPage = json?['previousPage'];
    currentPage = json?['currentPage'];
    dateCreated = (json?['date_created'] as Timestamp?)?.toDate();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['bookID'] = bookID;
    data['previousPage'] = previousPage;
    data['currentPage'] = currentPage;
    data['date_created'] = dateCreated;
    return data;
  }

  Database get db => Database(
      collectionReference: firestore
          .collection(bookCollection)
          .doc(bookID)
          .collection(readingCollection),
      storageReference: storage.ref(bookCollection).child(readingCollection));
  Future<Reading> save() async {
    if (id.isEmptyOrNull) {
      dateCreated = DateTime.now();
      id = await db.add(toJson());
    } else
      await db.edit(toJson());

    return this;
  }

  Future delete() async {
    if (id.isEmptyOrNull) {
      Get.snackbar("Error", "Invalid documents Id");
      return;
    }
    return await db.delete(id!);
  }

  Stream<List<Reading>> streamAllList() async* {
    yield* firestore
        .collectionGroup(readingCollection)
        .where("date_created", isGreaterThanOrEqualTo: DateTime(2020))
        .where("id", isNull: true)
        .orderBy("date_created", descending: true)
        .snapshots()
        .map((query) {
      List<Reading> list = [];
      print("List");
      for (var doc in query.docs) {
        print(doc.reference);
        print(doc.data());
        list.add(
          Reading.fromJson(
            doc,
          ),
        );
      }
      print("List length ${list.length}");
      return list;
    });
  }

  Stream<List<Reading>> streamListFromBook() async* {
    yield* db.collectionReference
        .orderBy("date_created", descending: true)
        .snapshots()
        .map((query) {
      List<Reading> list = [];
      for (var doc in query.docs) {
        list.add(
          Reading.fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }
}
