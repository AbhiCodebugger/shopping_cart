import 'package:edamama_project/model/cart_item.dart';
import 'package:edamama_project/model/product.dart';
import 'package:edamama_project/service/api_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<Product> listOfProduct = <Product>[];
  List<Product> cartItems = <Product>[];
  Map<String, CartItem> _cartItem = {};

  Map<String, CartItem> get items => {..._cartItem};

  final ApiService _apiService = ApiService();
  bool isLoading = false;
  var selectedProduct = {};
  var isAddedToCart = false.obs;
  var cartProducts = <CartItem>[].obs;

  getProduct() async {
    isLoading = true;
    listOfProduct = await _apiService.fetchProduct();
    isLoading = false;
    print("LoP : $listOfProduct");
    update();
  }

  int get itemCount {
    return _cartItem.length;
  }

  double get total {
    var total = 0.0;
    _cartItem.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  addItem(String productID, double price, String title) {
    if (_cartItem.containsKey(productID)) {
      _cartItem.update(
          productID,
          (existingItem) => CartItem(
                id: existingItem.id,
                title: existingItem.title,
                price: existingItem.price,
                quantity: existingItem.quantity + 1,
              ));
    } else {
      _cartItem.putIfAbsent(
          productID,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    update();
  }

  @override
  void onInit() {
    getProduct();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
