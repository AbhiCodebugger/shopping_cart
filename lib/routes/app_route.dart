import 'package:edamama_project/bindings/cart_binding.dart';
import 'package:edamama_project/bindings/detail_binding.dart';
import 'package:edamama_project/bindings/home_binding.dart';
import 'package:edamama_project/view/cart_screen.dart';
import 'package:edamama_project/view/home_screen.dart';
import 'package:edamama_project/view/product_detail.dart';
import 'package:get/get.dart';

class AppRoute {
  AppRoute._();
  static final routes = [
    GetPage(
      name: '/',
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/product_detail',
      page: () => const ProductDetail(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: '/cart_screen',
      page: () => const CartScreen(),
      // binding: CartBinding(),
    ),
  ];
}

class RoutingName {
  static String home_screen = "/";
  static String product_detail = "/product_detail";
  static String cart_screen = "/cart_screen";
}
