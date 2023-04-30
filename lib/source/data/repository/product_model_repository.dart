import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/data/repository/basic_repository.dart';
import 'package:goodwill/source/service/auth_service.dart';

class ProductModelRepository extends BasicRepository<ProductModel> {
  final CollectionReference _productsCollectionRef =
      FirebaseFirestore.instance.collection("products");

  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection("users");

  List<DocumentReference> _getNewDocumentRefs() {
    DocumentReference productsDocRef = _productsCollectionRef.doc();
    String id = productsDocRef.id;

    DocumentReference userProductsDocRef = _userCollectionRef
        .doc(AuthService.userId)
        .collection('products')
        .doc(id);

    return [productsDocRef, userProductsDocRef];
  }

  List<DocumentReference> _getDocumentRefs(String id) {
    DocumentReference productsDocRef = _productsCollectionRef.doc(id);
    DocumentReference userProductsDocRef = _userCollectionRef
        .doc(AuthService.userId)
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
    return deleteWithDocRefs(element, docRefs: _getDocumentRefs(element.id!));
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

  /// This function will return all PostModel objects
  /// from collection reference given
  ///
  /// params:
  /// * collectionRef: Where you want to get all objects
  /// If null, the default collection reference will be: root.collection('products')
  @override
  Future<List<ProductModel>?> getAll({CollectionReference? collectionRef}) {
    return getAllElementsFromCollectionRef(
        collectionRef:
            (collectionRef != null) ? collectionRef : _productsCollectionRef);
  }
}
