import 'package:dog_food/classes/cart_provider.dart';
import 'package:dog_food/classes/models/best_seller_model.dart';
import 'package:dog_food/constants/constants.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BestSellerWidget extends StatelessWidget {
  const BestSellerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Padding(
      padding: verticalPadding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Best Sellers",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          verticalMargin8,
          Text(
            "Discover our most popular picks loved by customers – shop the Best Sellers now!",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          verticalMargin16,
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final imageUrl = product['image']!;

                return Padding(
                  padding: horizontalPadding8,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SizedBox(
                      width: 200, // Width of each card
                      child: Padding(
                        padding: allPadding12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: imageUrl.startsWith('http')
                                  ? Image.network(
                                      imageUrl,
                                      height: 100,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      imageUrl,
                                      height: 100,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            verticalMargin12,
                            Center(
                              child: Text(
                                product['description']!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            verticalMargin8,
                            Center(
                              child: Text(
                                "Weight: ${product['weight']!}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            const SizedBox(height: 4),
                            verticalMargin8,
                            Center(
                              child: Text(
                                "Price: Ksh ${product['price'].toStringAsFixed(2)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color:
                                            DogFoodAppTheme.primaryButtonColor),
                              ),
                            ),
                            const Spacer(),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  cartProvider.addToCart(product);

                                  if (ScaffoldMessenger.maybeOf(context) !=
                                      null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("added to cart"),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      horizontalPadding24 + verticalPadding8,
                                  backgroundColor:
                                      DogFoodAppTheme.primaryButtonColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text("Add to Cart"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
