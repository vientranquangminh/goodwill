import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodwill/source/data/model/article_model.dart';
import 'package:goodwill/source/data/repository/basic_repository.dart';
import 'package:goodwill/source/service/auth_service.dart';

class ArticleRepository extends BasicRepository<ArticleModel> {
  final CollectionReference _articlesCollectionRef =
      FirebaseFirestore.instance.collection("articles");

  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection("users");

  List<DocumentReference> _getNewDocumentRefs() {
    DocumentReference articlesDocRef = _articlesCollectionRef.doc();
    String id = articlesDocRef.id;

    DocumentReference userArticlesDocRef = _userCollectionRef
        .doc(AuthService.userId)
        .collection('articles')
        .doc(id);

    return [articlesDocRef, userArticlesDocRef];
  }

  List<DocumentReference> _getDocumentRefs(String id) {
    DocumentReference articlesDocRef = _articlesCollectionRef.doc(id);
    DocumentReference userArticlesDocRef = _userCollectionRef
        .doc(AuthService.userId)
        .collection('articles')
        .doc(id);

    return [articlesDocRef, userArticlesDocRef];
  }

  @override
  Future<void> add(ArticleModel element) {
    List<DocumentReference> docRefs = _getNewDocumentRefs();
    element.id = docRefs[0].id;

    return addWithDocRefs(element, docRefs: docRefs);
  }

  @override
  Future<void> delete(ArticleModel element) {
    return deleteWithDocRefs(docRefs: _getDocumentRefs(element.id!));
  }

  @override
  Future<void> deleteById(String elementId) {
    return deleteWithDocRefs(docRefs: _getDocumentRefs(elementId));
  }

  @override
  ArticleModel Function(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) fromFirestore() {
    return ArticleModel.fromFirestore;
  }

  @override
  ArticleModel fromMap(Map<String, dynamic> map) {
    return ArticleModel.fromMap(map);
  }

  @override
  Future<ArticleModel?> get(String elementId,
      {CollectionReference<Object?>? collectionRef}) {
    return getElementFromCollectionRef(elementId,
        collectionRef:
            (collectionRef != null) ? collectionRef : _articlesCollectionRef);
  }

  @override
  Stream<ArticleModel?> getStream(String elementId,
      {CollectionReference<Object?>? collectionRef}) {
    return getStreamElementFromCollectionRef(elementId,
        collectionRef:
            (collectionRef != null) ? collectionRef : _articlesCollectionRef);
  }

  @override
  Future<List<ArticleModel>?> getAll(
      {CollectionReference<Object?>? collectionRef}) {
    return getAllElementsFromCollectionRef(
        collectionRef:
            (collectionRef != null) ? collectionRef : _articlesCollectionRef);
  }

  @override
  Stream<List<ArticleModel>?> getStreamAll(
      {CollectionReference<Object?>? collectionRef, Query<Object?>? query}) {
    if (query != null) {
      return getStreamAllElementsFromQuery(query: query);
    } else {
      return getStreamAllElementsFromCollectionRef(
          collectionRef:
              (collectionRef != null) ? collectionRef : _articlesCollectionRef);
    }
  }

  @override
  Future<void> update(ArticleModel element) {
    return updateWithDocRefs(element, docRefs: _getDocumentRefs(element.id!));
  }
}
