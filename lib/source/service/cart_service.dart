import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodwill/source/data/model/cart_item_model.dart';
import 'package:goodwill/source/data/repository/cart_item_repository.dart';
import 'package:goodwill/source/service/auth_service.dart';

class CartService {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static final CartItemRepository _cartItemRepository = CartItemRepository();

  static Future<bool> _isProductAddedToCart(String productId) async {
    final ref = await _instance
        .collection('users')
        .doc(AuthService.userId)
        .collection('cart')
        .where('productId', isEqualTo: productId)
        .get();
    return ref.docs.isNotEmpty;
  }

  static Future<void> addCartItem(CartItemModel cartItemModel) async {
    if (await _isProductAddedToCart(cartItemModel.productId!)) {
      return;
    }
    _cartItemRepository.add(cartItemModel);
  }

  static Future<List<CartItemModel>?> getAllCartItems() async {
    return _cartItemRepository.getAll();
  }

  static Stream<List<CartItemModel>?> getStreamAllCartItems() {
    return _cartItemRepository.getStreamAll();
  }

  static Future<void> updateCartItem(CartItemModel cartItemModel) {
    return _cartItemRepository.update(cartItemModel);
  }

  static Future<void> deleteCartItem(CartItemModel cartItemModel) {
    return _cartItemRepository.delete(cartItemModel);
  }

  static Future<void> deleteCartItemById(String cartItemModelId) {
    return _cartItemRepository.deleteById(cartItemModelId);
  }
}
