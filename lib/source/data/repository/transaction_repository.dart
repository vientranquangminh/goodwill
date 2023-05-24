import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodwill/source/data/model/transaction_model.dart';
import 'package:goodwill/source/data/repository/basic_repository.dart';

class TransactionRepository extends BasicRepository<TransactionModel> {
  final CollectionReference _transactionCollectionRef =
      FirebaseFirestore.instance.collection("transactions");

  List<DocumentReference> _getNewDocumentRefs() {
    DocumentReference transactionDocRef = _transactionCollectionRef.doc();

    return [transactionDocRef];
  }

  List<DocumentReference> _getDocumentRefs(String id) {
    DocumentReference transactionDocRef = _transactionCollectionRef.doc(id);

    return [transactionDocRef];
  }

  @override
  Future<void> add(TransactionModel element) {
    List<DocumentReference> docRefs = _getNewDocumentRefs();
    element.id = docRefs[0].id;

    return addWithDocRefs(element, docRefs: docRefs);
  }

  @override
  Future<void> delete(TransactionModel element) {
    return deleteWithDocRefs(docRefs: _getDocumentRefs(element.id!));
  }

  @override
  Future<void> deleteById(String elementId) {
    return deleteWithDocRefs(docRefs: _getDocumentRefs(elementId));
  }

  @override
  TransactionModel Function(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) fromFirestore() {
    return TransactionModel.fromFirestore;
  }

  @override
  TransactionModel fromMap(Map<String, dynamic> map) {
    return TransactionModel.fromMap(map);
  }

  @override
  Future<TransactionModel?> get(String elementId,
      {CollectionReference<Object?>? collectionRef}) {
    return getElementFromCollectionRef(elementId,
        collectionRef: (collectionRef != null)
            ? collectionRef
            : _transactionCollectionRef);
  }

  @override
  Future<List<TransactionModel>?> getAll(
      {CollectionReference<Object?>? collectionRef}) {
    return getAllElementsFromCollectionRef(
        collectionRef: (collectionRef != null)
            ? collectionRef
            : _transactionCollectionRef);
  }

  @override
  Stream<TransactionModel?> getStream(String elementId,
      {CollectionReference<Object?>? collectionRef}) {
    return getStreamElementFromCollectionRef(elementId,
        collectionRef: (collectionRef != null)
            ? collectionRef
            : _transactionCollectionRef);
  }

  @override
  Stream<List<TransactionModel>?> getStreamAll(
      {CollectionReference<Object?>? collectionRef}) {
    return getStreamAllElementsFromCollectionRef(
        collectionRef: (collectionRef != null)
            ? collectionRef
            : _transactionCollectionRef);
  }

  @override
  Future<void> update(TransactionModel element) {
    return updateWithDocRefs(element, docRefs: _getDocumentRefs(element.id!));
  }
}
