import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodwill/source/data/model/article_model.dart';
import 'package:goodwill/source/data/repository/article_repository.dart';

class ArticleService {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static final ArticleRepository _articleModelRepository = ArticleRepository();

  static Future<void> addArticle(ArticleModel articleModel) async {
    return _articleModelRepository.add(articleModel);
  }

  static Future<List<ArticleModel>?> getAllArticles() async {
    return _articleModelRepository.getAll();
  }

  static Stream<List<ArticleModel>?> getStreamAllArticles() {
    return _articleModelRepository.getStreamAll();
  }

  static Future<List<ArticleModel>?> getAllArticlesFrom(String ownerId) async {
    CollectionReference collectionReference =
        _instance.collection('users').doc(ownerId).collection('articles');

    return _articleModelRepository.getAll(collectionRef: collectionReference);
  }

  static Stream<List<ArticleModel>?> getStreamAllArticlesFrom(String ownerId) {
    CollectionReference collectionReference =
        _instance.collection('users').doc(ownerId).collection('articles');

    return _articleModelRepository.getStreamAll(
        collectionRef: collectionReference);
  }

  static Future<void> updateArticle(ArticleModel articleModel) {
    return _articleModelRepository.update(articleModel);
  }

  static Future<void> deleteArticle(ArticleModel articleModel) {
    return _articleModelRepository.delete(articleModel);
  }
}
