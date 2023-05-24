import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/data/repository/basic_repository.dart';
import 'package:goodwill/source/service/auth_service.dart';

class ProductModelRepository extends BasicRepository<ProductModel> {
  final CollectionReference _productsCollectionRef =
      FirebaseFirestore.instance.collection("products");

  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection("users");

  List<DocumentReference> _getNewDocumentRefs({String? userId}) {
    DocumentReference productsDocRef = _productsCollectionRef.doc();
    String id = productsDocRef.id;

    DocumentReference userProductsDocRef = _userCollectionRef
        .doc(userId ?? AuthService.userId)
        .collection('products')
        .doc(id);

    return [productsDocRef, userProductsDocRef];
  }

  List<DocumentReference> _getDocumentRefs(String id, {String? userId}) {
    DocumentReference productsDocRef = _productsCollectionRef.doc(id);
    DocumentReference userProductsDocRef = _userCollectionRef
        .doc(userId ?? AuthService.userId)
        .collection('products')
        .doc(id);

    return [productsDocRef, userProductsDocRef];
  }

  @override
  Future<void> add(ProductModel element) {
    List<DocumentReference> docRefs = _getNewDocumentRefs();
    element.id = docRefs[0].id;

    return addWithDocRefs(element, docRefs: docRefs);
  }

  @override
  Future<void> delete(ProductModel element) {
    return deleteWithDocRefs(docRefs: _getDocumentRefs(element.id!));
  }

  @override
  ProductModel Function(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) fromFirestore() {
    return ProductModel.fromFirestore;
  }

  @override
  ProductModel fromMap(Map<String, dynamic> map) {
    return ProductModel.fromMap(map);
  }

  @override
  Future<void> update(ProductModel element) {
    return updateWithDocRefs(element, docRefs: _getDocumentRefs(element.id!));
  }

  Future<void> replace(ProductModel element) {
    return replaceWithDocRefs(element, docRefs: _getDocumentRefs(element.id!));
  }

  Future<bool> decreaseQuantity(String productId, String ownerId,
      {int buyQuantity = 1}) async {
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      final docRefs = _getDocumentRefs(productId, userId: ownerId);
      final result = await transaction.get(docRefs[0]);

      int quantity = result.get("quantity");
      if (quantity - buyQuantity < 0) {
        return false;
      }
      quantity -= buyQuantity;
      for (var docRef in docRefs) {
        transaction.update(docRef, {"quantity": quantity});
      }

      return true;
    });
  }

  /// This function will return the PostModel object
  /// from collection reference given
  ///
  /// params:
  /// * elementId: documentId in that collection
  /// * collectionRef: Where you want to get all objects
  /// If null, the default collection reference will be: root.collection('products')
  @override
  Future<ProductModel?> get(String elementId,
      {CollectionReference? collectionRef}) {
    return getElementFromCollectionRef(elementId,
        collectionRef:
            (collectionRef != null) ? collectionRef : _productsCollectionRef);
  }

  @override
  Stream<ProductModel?> getStream(String elementId,
      {CollectionReference? collectionRef}) {
    return getStreamElementFromCollectionRef(elementId,
        collectionRef:
            (collectionRef != null) ? collectionRef : _productsCollectionRef);
  }

  /// This function will return all PostModel objects
  /// from collection reference given
  ///
  /// params:
  /// * collectionRef: Where you want to get all objects
  /// If null, the default collection reference will be: root.collection('products')
  @override
  Future<List<ProductModel>?> getAll({CollectionReference? collectionRef}) {
    return getAllElementsFromCollectionQuery(
        query: (collectionRef != null)
            ? collectionRef.where("quantity", isGreaterThan: 0)
            : _productsCollectionRef.where("quantity", isGreaterThan: 0));
  }

  @override
  Stream<List<ProductModel>?> getStreamAll(
      {CollectionReference<Object?>? collectionRef, Query<Object?>? query}) {
    if (query != null) {
      return getStreamAllElementsFromQuery(
          query: query.where("quantity", isGreaterThan: 0));
    } else {
      return getStreamAllElementsFromQuery(
          query: (collectionRef != null)
              ? collectionRef.where("quantity", isGreaterThan: 0)
              : _productsCollectionRef.where("quantity", isGreaterThan: 0));
    }
  }

  @override
  Future<void> deleteById(String elementId) {
    return deleteWithDocRefs(docRefs: _getDocumentRefs(elementId));
  }
}
