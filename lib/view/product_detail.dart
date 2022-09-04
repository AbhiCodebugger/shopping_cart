import 'package:badges/badges.dart';
import 'package:edamama_project/controller/detail_controller.dart';
import 'package:edamama_project/controller/home_controller.dart';
import 'package:edamama_project/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          elevation: 1.0,
          backgroundColor: Colors.brown[900],
          title: const Text('Product Detail'),
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
                })
          ],
        ),
        body: GetBuilder<DetailController>(
            init: DetailController(),
            builder: (controller) {
              return controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(10),
                      children: [
                        SizedBox(
                          height: height * 0.4,
                          width: width,
                          child: Card(
                            elevation: 6.0,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                controller.product.image!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            // IconButton(
                            //     onPressed: controller.increment,
                            //     icon: const Icon(Icons.add)),
                            // Text(controller.quantity.toString()),
                            // IconButton(
                            //     onPressed: controller.decrement,
                            //     icon: const Icon(Icons.remove)),
                            // const Spacer(),
                            // controller.quantity == 0
                            //     ? const SizedBox()
                            //     :
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 6.0,
                                  padding: EdgeInsets.all(12),
                                  onSurface: Colors.brown[900],
                                  primary: Colors.brown[900],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                onPressed: () {
                                  homeController.addItem(
                                    controller.product.id.toString(),
                                    controller.product.price!,
                                    controller.product.title!,
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Text('Add to cart'),
                                    Icon(Icons.shopping_cart),
                                  ],
                                ))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          controller.product.title!,
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontSize: 26,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 10),
                        Text(controller.product.description!,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white)),
                      ],
                    );
            }));
  }
}
