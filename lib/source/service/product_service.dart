import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:goodwill/source/data/dto/cart_item_dto.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/data/model/purchase_history_model.dart';
import 'package:goodwill/source/data/model/transaction_model.dart';
import 'package:goodwill/source/data/repository/product_model_repository.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/service/purchase_history_service.dart';
import 'package:goodwill/source/service/transaction_service.dart';

class ProductService {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static final ProductModelRepository _productModelRepository =
      ProductModelRepository();

  static Stream<FlutterZaloPayStatus> buy(
      List<CartItemDto> items, String zpTransToken) async* {
    int totalPrice = 0;

    List<Map<String, dynamic>> invoiceItems = [];

    // Call ZaloPay API
    final stream =
        FlutterZaloPaySdk.payOrder(zpToken: zpTransToken).asBroadcastStream();
    stream.listen((status) async {
      if (status == FlutterZaloPayStatus.success) {
        for (var item in items) {
          // Decrease quantity
          bool isBuySuccess = await _productModelRepository.decreaseQuantity(
              item.productId, item.sellerId,
              buyQuantity: item.quantity);

          // Out of stock
          if (!isBuySuccess) {
            Fluttertoast.showToast(
                msg:
                    "Product ${item.title}-${item.id}-${item.category} is out of stock");
          } else {
            invoiceItems.add({
              "productId": item.productId,
              "quantity": item.quantity,
            });
            totalPrice += item.price * item.quantity;
            debugPrint('Total order price: $totalPrice');
          }
        }
        // Add 1 to transaction table
        final transactionModel = TransactionModel(
          amount: totalPrice,
          zpTransToken: zpTransToken,
          senderId: AuthService.userId,
          items: invoiceItems,
        );
        TransactionService.addTransaction(transactionModel);

        // Add 1 to purchase history
        for (var element in invoiceItems) {
          PurchaseHistoryService.addPurchaseHistory(PurchaseHistoryModel(
            productId: element["productId"],
            quantity: element["quantity"],
            createdAt: DateTime.now(),
            transactionId: zpTransToken,
          ));
        }
      }
    });
    yield* stream;
  }

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

  static Future<void> replaceProduct(ProductModel productModel) {
    return _productModelRepository.replace(productModel);
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
