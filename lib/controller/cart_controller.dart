import 'package:edamama_project/model/cart_item.dart';
import 'package:edamama_project/model/product.dart';
import 'package:edamama_project/service/api_service.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final ApiService _apiService = ApiService();
  int quantity = 0;
  bool isLoading = false;
  Map<String, CartItem> cartItem = {};

  double get totalAmount {
    var total = 0.0;
    cartItem.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  int get itemCount {
    return cartItem.isEmpty ? 0 : cartItem.length;
  }

  void addItem(Product product) {
    if (cartItem.containsKey(product.id)) {
      cartItem.update(
          product.id.toString(),
          (value) => CartItem(
                id: value.id,
                title: value.title,
                price: value.price,
                quantity: value.quantity + 1,
              ));
    }
  }

  increment() {
    if (quantity >= 10) {
      return Get.snackbar(
          'Limit Reached', 'You Can\t Add More Than 10 products');
    } else {
      quantity++;
    }
    update();
  }

  decrement() {
    if (quantity <= 0) {
      return Get.snackbar('Error', 'You Can\'t Remove 0 products');
    } else {
      quantity--;
    }
    update();
  }
}
