import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackbuld/controllers/product_controller.dart';
import 'package:stackbuld/widgets/add_product_dialog.dart';
import 'package:stackbuld/widgets/product_widget.dart';

class ProductListView extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final List<String> categories = [
    'All',
    'Electronics',
    'Clothing',
    'Books',
    'Home',
    'Toys'
  ]; // Define your categories

  ProductListView({super.key});

  void _showPriceFilterDialog(BuildContext context) {
    final minController = TextEditingController();
    final maxController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter by Price Range'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: minController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Min Price',
                ),
              ),
              TextField(
                controller: maxController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Max Price',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                final minPrice = double.tryParse(minController.text) ?? 0;
                final maxPrice =
                    double.tryParse(maxController.text) ?? double.infinity;
                productController.filterByPrice(minPrice, maxPrice);
                Get.back();
              },
              child: const Text('Apply'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Filter Widgets
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    hint: const Text('Category'),
                    onChanged: (value) {
                      if (value == null) return;
                      if (value == 'All') {
                        productController.filterByCategory('');
                      } else {
                        productController.filterByCategory(value);
                      }
                    },
                    items: categories
                        .map((category) => DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () => _showPriceFilterDialog(context),
                ),
              ],
            ),
          ),
          // Product Grid
          Expanded(
            child: Obx(
              () {
                if (productController.filteredProducts.isEmpty) {
                  return const Center(child: Text('No products available'));
                }
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.builder(
                      itemCount: productController.filteredProducts.length,
                      itemBuilder: (context, index) => ProductWidget(
                        product: productController.filteredProducts[index],
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio: 1,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(const AddProductDialog());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
