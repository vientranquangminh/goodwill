import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodwill/source/data/model/purchase_history_model.dart';
import 'package:goodwill/source/data/repository/basic_repository.dart';
import 'package:goodwill/source/service/auth_service.dart';

class PurchaseHistoryRepository extends BasicRepository<PurchaseHistoryModel> {
  final CollectionReference _historyCollectionRef = FirebaseFirestore.instance
      .collection("users")
      .doc(AuthService.userId!)
      .collection('purchaseHistory');

  List<DocumentReference> _getNewDocumentRefs() {
    DocumentReference cartItemDocRef = _historyCollectionRef.doc();

    return [cartItemDocRef];
  }

  List<DocumentReference> _getDocumentRefs(String id) {
    DocumentReference cartItemDocRef = _historyCollectionRef.doc(id);

    return [cartItemDocRef];
  }

  @override
  Future<void> add(PurchaseHistoryModel element) {
    List<DocumentReference> docRefs = _getNewDocumentRefs();
    element.id = docRefs[0].id;

    return addWithDocRefs(element, docRefs: docRefs);
  }

  @override
  Future<void> delete(PurchaseHistoryModel element) {
    return deleteWithDocRefs(docRefs: _getDocumentRefs(element.id!));
  }

  @override
  Future<void> deleteById(String elementId) {
    return deleteWithDocRefs(docRefs: _getDocumentRefs(elementId));
  }

  @override
  PurchaseHistoryModel Function(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) fromFirestore() {
    return PurchaseHistoryModel.fromFirestore;
  }

  @override
  PurchaseHistoryModel fromMap(Map<String, dynamic> map) {
    return PurchaseHistoryModel.fromMap(map);
  }

  @override
  Future<PurchaseHistoryModel?> get(String elementId,
      {CollectionReference<Object?>? collectionRef}) {
    return getElementFromCollectionRef(elementId,
        collectionRef:
            (collectionRef != null) ? collectionRef : _historyCollectionRef);
  }

  @override
  Future<List<PurchaseHistoryModel>?> getAll(
      {CollectionReference<Object?>? collectionRef}) {
    return getAllElementsFromCollectionQuery(
        query: (collectionRef != null)
            ? collectionRef.orderBy("createdAt", descending: true)
            : _historyCollectionRef.orderBy("createdAt", descending: true));
  }

  @override
  Stream<PurchaseHistoryModel?> getStream(String elementId,
      {CollectionReference<Object?>? collectionRef}) {
    return getStreamElementFromCollectionRef(elementId,
        collectionRef:
            (collectionRef != null) ? collectionRef : _historyCollectionRef);
  }

  @override
  Stream<List<PurchaseHistoryModel>?> getStreamAll(
      {CollectionReference<Object?>? collectionRef}) {
    return getStreamAllElementsFromQuery(
        query: (collectionRef != null)
            ? collectionRef.orderBy("createdAt", descending: true)
            : _historyCollectionRef.orderBy("createdAt", descending: true));
  }

  @override
  Future<void> update(PurchaseHistoryModel element) {
    return updateWithDocRefs(element, docRefs: _getDocumentRefs(element.id!));
  }
}
