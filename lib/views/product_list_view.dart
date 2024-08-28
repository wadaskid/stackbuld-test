import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackbuld/controllers/product_controller.dart';

class ProductListView extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Catalog')),
      body: Obx(() {
        if (productController.products.isEmpty) {
          return const Center(child: Text('No products available'));
        }
        return ListView.builder(
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            final product = productController.products[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('\$${product.price.toString()}'),
              onTap: () {},
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
