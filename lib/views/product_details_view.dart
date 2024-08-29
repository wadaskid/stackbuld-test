import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:stackbuld/models/product.dart';

class ProductDetailsView extends StatelessWidget {
  final Product product;

  const ProductDetailsView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            SizedBox(
              width: double.infinity,
              height: screenSize.width > 600 ? 300 : 250,
              child: product.imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : const Placeholder(),
            ),
            const SizedBox(height: 16),

            // Product Name
            Text(
              product.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),

            // Product Description
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
            const SizedBox(height: 16),

            // Product Price
            Text(
              'Price: \$${product.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            // Product Category
            Text(
              'Category: ${product.category}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
