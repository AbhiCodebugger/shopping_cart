import 'package:edamama_project/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[900],
        elevation: 1.0,
        title: const Text('Cart Screen'),
      ),
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: controller.items.length,
                              itemBuilder: ((context, index) {
                                return Card(
                                  color: Colors.brown[200],
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  elevation: 2.0,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(8),
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.brown[900],
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: FittedBox(
                                          child: Text(
                                            "\$${controller.items.values.toList()[index].price.toString()}",
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Text(controller.items.values
                                        .toList()[index]
                                        .title),
                                    trailing: Text(
                                        "${controller.items.values.toList()[index].quantity.toString()} X"),
                                  ),
                                );
                              }))),
                      Card(
                        margin: const EdgeInsets.all(12),
                        color: Colors.brown[200],
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'Total amount :',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Chip(
                                  backgroundColor: Colors.brown[900],
                                  label: Text(
                                    "\$${controller.total.toString()}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
          }),
    );
  }
}
