import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/data/repository/product_model_repository.dart';

class ProductService {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static final ProductModelRepository _postModelRepository =
      ProductModelRepository();

  static Future<List<ProductModel>?> getAllProducts() async {
    return _postModelRepository.getAll();
  }

  static Future<List<ProductModel>?> getAllProductsFrom(String ownerId) async {
    CollectionReference collectionReference =
        _instance.collection('users').doc(ownerId).collection('products');

    return _postModelRepository.getAll(collectionRef: collectionReference);
  }
}
