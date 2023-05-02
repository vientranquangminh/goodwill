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

  static Future<void> deleteProduct(ProductModel productModel) {
    return _productModelRepository.delete(productModel);
  }
}
