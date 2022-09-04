import 'package:edamama_project/model/product.dart';
import 'package:edamama_project/service/api_service.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final ApiService _apiService = ApiService();
  late int id;
  int quantity = 0;
  Product product = Product();
  var prod = {};
  bool isLoading = false;

  // addProduct(Prod product) {
  //   print('add');
  //   if (prod.containsKey(product)) {
  //     prod[product]++;
  //     print(prod);
  //   } else {
  //     prod[product] = 1;
  //   }
  //   Get.toNamed(RoutingName.cart_screen);
  //   update();
  // }

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

  getProductByID() async {
    isLoading = true;
    product = await _apiService.fetchParticularProduct(id);
    print("LoP : $product");
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    id = Get.arguments;
    print(id);
    getProductByID();
    super.onInit();
  }
}
