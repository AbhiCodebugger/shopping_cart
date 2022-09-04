import 'package:badges/badges.dart';
import 'package:edamama_project/controller/cart_controller.dart';
import 'package:edamama_project/controller/home_controller.dart';
import 'package:edamama_project/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[900],
          elevation: 1.0,
          title: Text(
            'Product Screen',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            GetBuilder<HomeController>(
                init: HomeController(),
                builder: (controller) {
                  return Badge(
                    badgeContent: Text(controller.itemCount.toString()),
                    position: const BadgePosition(top: 2, end: 6),
                    child: IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      tooltip: 'Open shopping cart',
                      onPressed: () {
                        Get.toNamed(RoutingName.cart_screen);
                      },
                    ),
                  );
                }),
          ],
        ),
        body: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) {
              return controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      itemCount: controller.listOfProduct.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                RoutingName.product_detail,
                                arguments: controller.listOfProduct[index].id,
                              );
                            },
                            child: Card(
                                elevation: 4.0,
                                margin: const EdgeInsets.all(6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Image.network(
                                          controller
                                              .listOfProduct[index].image!,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Text(
                                        controller.listOfProduct[index].title!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\$${controller.listOfProduct[index].price}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(color: Colors.red),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              controller.addItem(
                                                  controller
                                                      .listOfProduct[index].id
                                                      .toString(),
                                                  controller
                                                      .listOfProduct[index]
                                                      .price!,
                                                  controller
                                                      .listOfProduct[index]
                                                      .title!);
                                            },
                                            icon: const Icon(
                                              Icons.shopping_cart,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )));
                      });
            }));
  }
}
