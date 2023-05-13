import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goodwill/source/data/model/basic_model.dart';

abstract class BasicRepository<E extends BasicModel> {
  Future<void> add(E element);
  Future<E?> get(String elementId, {CollectionReference? collectionRef});
  Stream<E?> getStream(String elementId, {CollectionReference? collectionRef});
  Future<List<E>?> getAll({CollectionReference? collectionRef});
  Stream<List<E>?> getStreamAll({CollectionReference? collectionRef});
  Future<void> update(E element);
  Future<void> delete(E element);
  Future<void> deleteById(E element);

  E Function(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) fromFirestore();
  E fromMap(Map<String, dynamic> map);

  Future<void> addWithDocRefs(E element,
      {required List<DocumentReference> docRefs}) async {
    for (var docRef in docRefs) {
      element.id = docRef.id;
      final data = element.toMap();

      await docRef
          .set(data)
          .then((value) =>
              debugPrint('${E.runtimeType.toString()} ${element.id} added'))
          .onError((error, stackTrace) {
        debugPrint('Error $error');
        debugPrint('Stack $stackTrace');
      });
    }
  }

  Future<E?> getElementFromCollectionRef(String elementId,
      {required CollectionReference collectionRef}) async {
    final docRef = collectionRef.doc(elementId).withConverter(
        fromFirestore: fromFirestore(), toFirestore: (E e, _) => e.toMap());
    final docSnap = await docRef.get();
    final element = docSnap.data();
    if (element == null) {
      debugPrint('No document with docId-$elementId found');
    }

    return element;
  }

  Stream<E?> getStreamElementFromCollectionRef(String elementId,
      {required CollectionReference collectionRef}) {
    final docRef = collectionRef.doc(elementId).withConverter(
        fromFirestore: fromFirestore(), toFirestore: (E e, _) => e.toMap());
    final docSnaps = docRef.snapshots();
    final stream = docSnaps.map((doc) => doc.data());

    return stream;
  }

  Future<List<E>?> getAllElementsFromCollectionRef(
      {required CollectionReference collectionRef}) async {
    final QuerySnapshot querySnapshot = await collectionRef.get();

    return querySnapshot.docs.map((queryDocumentSnapshot) {
      Map<String, dynamic> data =
          queryDocumentSnapshot.data() as Map<String, dynamic>;
      return fromMap(data);
    }).toList();
  }

  Stream<List<E>?> getStreamAllElementsFromCollectionRef(
      {required CollectionReference collectionRef}) {
    final colletionRef = collectionRef.withConverter(
        fromFirestore: fromFirestore(), toFirestore: (E e, _) => e.toMap());
    final stream = colletionRef.snapshots().map(
        (querySnapshot) => querySnapshot.docs.map((e) => e.data()).toList());
    return stream;
  }

  Future<List<E>?> getAllElementsFromCollectionQuery(
      {required Query query}) async {
    final QuerySnapshot querySnapshot = await query.get();

    return querySnapshot.docs.map((queryDocumentSnapshot) {
      Map<String, dynamic> data =
          queryDocumentSnapshot.data() as Map<String, dynamic>;
      return fromMap(data);
    }).toList();
  }

  Stream<List<E>?> getStreamAllElementsFromQuery({required Query query}) {
    final colletionRef = query.withConverter(
        fromFirestore: fromFirestore(), toFirestore: (E e, _) => e.toMap());
    final stream = colletionRef.snapshots().map(
        (querySnapshot) => querySnapshot.docs.map((e) => e.data()).toList());
    return stream;
  }

  Future<E?> getSingleElementsFromCollectionQuery(
      {required Query query}) async {
    final QuerySnapshot querySnapshot = await query.get();

    return fromMap(querySnapshot.docs.first.data() as Map<String, dynamic>);
  }

  Future<void> updateWithDocRefs(E element,
      {required List<DocumentReference> docRefs}) async {
    for (var docRef in docRefs) {
      element.id = docRef.id;
      final data = element.toMap();

      await docRef
          .update(data)
          .then((value) =>
              debugPrint('${E.runtimeType.toString()} ${element.id} updated'))
          .onError((error, stackTrace) {
        debugPrint('Error $error');
        debugPrint('Stack $stackTrace');
      });
    }
  }

  Future<void> deleteWithDocRefs(E element,
      {required List<DocumentReference> docRefs}) async {
    for (var docRef in docRefs) {
      await docRef
          .delete()
          .then((value) => debugPrint('${element.id} deleted'))
          .onError((error, stackTrace) {
        debugPrint('Error $error');
        debugPrint('Stack $stackTrace');
      });
    }
  }

  Future<void> deleteWithDocRefId(E element,
      {required List<DocumentReference> docRefs}) async {
    for (var docRef in docRefs) {
      element.id = docRef.id;
      docRef
          .delete()
          .then((value) =>
              debugPrint('${E.runtimeType.toString()} $element.id deleted'))
          .onError((error, stackTrace) {
        debugPrint('Error $error');
        debugPrint('Stack $stackTrace');
      });
    }
  }
}
