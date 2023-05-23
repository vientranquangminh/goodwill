import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodwill/source/data/model/cart_item_model.dart';
import 'package:goodwill/source/data/repository/basic_repository.dart';
import 'package:goodwill/source/service/auth_service.dart';

class CartItemRepository extends BasicRepository<CartItemModel> {
  final CollectionReference _cartCollectionRef = FirebaseFirestore.instance
      .collection("users")
      .doc(AuthService.userId!)
      .collection('cart');

  List<DocumentReference> _getNewDocumentRefs() {
    DocumentReference cartItemDocRef = _cartCollectionRef.doc();

    return [cartItemDocRef];
  }

  List<DocumentReference> _getDocumentRefs(String id) {
    DocumentReference cartItemDocRef = _cartCollectionRef.doc(id);

    return [cartItemDocRef];
  }

  @override
  Future<void> add(CartItemModel element) {
    List<DocumentReference> docRefs = _getNewDocumentRefs();
    element.id = docRefs[0].id;

    return addWithDocRefs(element, docRefs: docRefs);
  }

  @override
  Future<void> delete(CartItemModel element) {
    return deleteWithDocRefs(element, docRefs: _getDocumentRefs(element.id!));
  }

  @override
  Future<void> deleteById(CartItemModel element) {
    return deleteWithDocRefId(element, docRefs: _getDocumentRefs(element.id!));
  }

  @override
  CartItemModel Function(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) fromFirestore() {
    return CartItemModel.fromFirestore;
  }

  @override
  CartItemModel fromMap(Map<String, dynamic> map) {
    return CartItemModel.fromMap(map);
  }

  @override
  Future<CartItemModel?> get(String elementId,
      {CollectionReference<Object?>? collectionRef}) {
    return getElementFromCollectionRef(elementId,
        collectionRef:
            (collectionRef != null) ? collectionRef : _cartCollectionRef);
  }

  @override
  Future<List<CartItemModel>?> getAll(
      {CollectionReference<Object?>? collectionRef}) {
    return getAllElementsFromCollectionRef(
        collectionRef:
            (collectionRef != null) ? collectionRef : _cartCollectionRef);
  }

  @override
  Stream<CartItemModel?> getStream(String elementId,
      {CollectionReference<Object?>? collectionRef}) {
    return getStreamElementFromCollectionRef(elementId,
        collectionRef:
            (collectionRef != null) ? collectionRef : _cartCollectionRef);
  }

  @override
  Stream<List<CartItemModel>?> getStreamAll(
      {CollectionReference<Object?>? collectionRef}) {
    return getStreamAllElementsFromCollectionRef(
        collectionRef:
            (collectionRef != null) ? collectionRef : _cartCollectionRef);
  }

  @override
  Future<void> update(CartItemModel element) {
    return updateWithDocRefs(element, docRefs: _getDocumentRefs(element.id!));
  }
}
