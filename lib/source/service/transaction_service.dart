import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodwill/source/data/model/transaction_model.dart';
import 'package:goodwill/source/data/repository/transaction_repository.dart';

class TransactionService {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static final TransactionRepository _transactionRepository =
      TransactionRepository();

  static Future<void> addTransaction(TransactionModel transactionModel) async {
    return _transactionRepository.add(transactionModel);
  }

  static Future<List<TransactionModel>?> getAllTransactions() async {
    return _transactionRepository.getAll();
  }

  static Future<List<TransactionModel>?> getAllBuyingTransactions() async {
    final query = _instance.collection('transactions').where("senderId");

    return _transactionRepository.getAllElementsFromCollectionQuery(
        query: query);
  }

  static Future<List<TransactionModel>?> getAllSellingTransactions() async {
    final query = _instance.collection('transactions').where("receiverId");

    return _transactionRepository.getAllElementsFromCollectionQuery(
        query: query);
  }

  static Stream<List<TransactionModel>?> getStreamAllTransactions() {
    return _transactionRepository.getStreamAll();
  }

  // static Future<void> updateTransaction(TransactionModel transactionModel) {
  //   return _transactionRepository.update(transactionModel);
  // }

  // static Future<void> deleteTransaction(TransactionModel transactionModel) {
  //   return _transactionRepository.delete(transactionModel);
  // }

  // static Future<void> deleteTransactionById(TransactionModel transactionModel) {
  //   return _transactionRepository.deleteById(transactionModel);
  // }
}
