import 'dart:convert';
import 'dart:developer';
import 'package:edamama_project/model/product.dart';
import 'package:http/http.dart' as http;

const BASE_URL = 'https://fakestoreapi.com';

class ApiService {
  Future<List<Product>> fetchProduct() async {
    var url = Uri.parse('$BASE_URL/products');
    var response = await http.get(url);
    print(response);
    try {
      if (response.statusCode == 200) {
        print(response);
        final product = productFromJson(response.body);
        log(product.toString());
        return product;
      } else {
        return [];
      }
    } catch (e) {
      print("catch Error : ${e.toString()}");
      return [];
    }
  }

  Future<Product> fetchParticularProduct(int id) async {
    var url = Uri.parse("$BASE_URL/products/$id");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var product = Product.fromJson(json.decode(response.body));
      log(product.toString());
      return product;
    } else {
      return Product();
    }
  }
}
