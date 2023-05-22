import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodwill/source/data/model/purchase_history_model.dart';
import 'package:goodwill/source/data/repository/purchase_history_repository.dart';

class PurchaseHistoryService {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static final PurchaseHistoryRepository _purchaseHistoryRepository =
      PurchaseHistoryRepository();

  static Future<void> addPurchaseHistory(
      PurchaseHistoryModel purchaseHistoryModel) async {
    return _purchaseHistoryRepository.add(purchaseHistoryModel);
  }

  static Future<List<PurchaseHistoryModel>?> getAllPurchaseHistory() async {
    return _purchaseHistoryRepository.getAll();
  }

  static Stream<List<PurchaseHistoryModel>?> getStreamAllPurchaseHistory() {
    return _purchaseHistoryRepository.getStreamAll();
  }

  static Future<void> updatePurchaseHistory(
      PurchaseHistoryModel purchaseHistoryModel) {
    return _purchaseHistoryRepository.update(purchaseHistoryModel);
  }

  static Future<void> deletePurchaseHistory(
      PurchaseHistoryModel purchaseHistoryModel) {
    return _purchaseHistoryRepository.delete(purchaseHistoryModel);
  }

  static Future<void> deletePurchaseHistoryById(
      PurchaseHistoryModel purchaseHistoryModel) {
    return _purchaseHistoryRepository.deleteById(purchaseHistoryModel);
  }
}
