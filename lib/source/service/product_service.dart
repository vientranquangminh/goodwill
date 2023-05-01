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

  static Future<List<ProductModel>?> getAllProductsFrom(String ownerId) async {
    CollectionReference collectionReference =
        _instance.collection('users').doc(ownerId).collection('products');

    return _productModelRepository.getAll(collectionRef: collectionReference);
  }
}
