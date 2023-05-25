import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/data/repository/product_model_repository.dart';

class ProductService {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static final ProductModelRepository _productModelRepository =
      ProductModelRepository();

  static Future<void> addProduct(ProductModel productModel) async {
    return _productModelRepository.add(productModel);
  }

  static Future<ProductModel?> get(String productId) async {
    return _productModelRepository.get(productId);
  }

  static Stream<ProductModel?> getStream(String productId) {
    return _productModelRepository.getStream(productId);
  }

  static Future<List<ProductModel>?> getAllProducts() async {
    return _productModelRepository.getAll();
  }

  static Stream<List<ProductModel>?> getStreamAllProductsS() {
    return _productModelRepository.getStreamAll();
  }

  static Future<List<ProductModel>?> getAllProductsFrom(String ownerId) async {
    CollectionReference collectionReference =
        _instance.collection('users').doc(ownerId).collection('products');

    return _productModelRepository.getAll(collectionRef: collectionReference);
  }

  static Stream<List<ProductModel>?> getStreamAllProductsFrom(String ownerId) {
    CollectionReference collectionReference =
        _instance.collection('users').doc(ownerId).collection('products');

    return _productModelRepository.getStreamAll(
        collectionRef: collectionReference);
  }

  static Future<List<ProductModel>?> getProductsWithCategory(
      {String? category}) {
    if (category == null) {
      return getAllProducts();
    }

    final query =
        _instance.collection("products").where("category", isEqualTo: category);

    return _productModelRepository.getAllElementsFromCollectionQuery(
        query: query);
  }

  static Future<void> updateProduct(ProductModel productModel) {
    return _productModelRepository.update(productModel);
  }

  static Future<void> deleteProduct(ProductModel productModel) {
    return _productModelRepository.delete(productModel);
  }

  static Future<void> deleteProductById(String productModelId) async {
    return _productModelRepository.deleteById(productModelId);
  }

  static Stream<List<ProductModel>?> getProductsByCondition(String category) {
    if (category == 'All') {
      CollectionReference collectionReference =
          _instance.collection('products');
      return _productModelRepository.getStreamAll(
          collectionRef: collectionReference);
    } else {
      Query query = _instance
          .collection('products')
          .where('category', isEqualTo: category);
      return _productModelRepository.getStreamAll(query: query);
    }
  }
}
