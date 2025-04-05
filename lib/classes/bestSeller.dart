import 'package:dog_food/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dog_food/classes/cart_provider.dart';
import 'package:dog_food/classes/models/best_seller_model.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:dog_food/page_size/responsive_screen_helper.dart';

class BestSellerWidget extends StatelessWidget {
  const BestSellerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmall = ResponsiveHelper.isSmallScreen(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double cardWidth = isSmall
            ? constraints.maxWidth * 0.1
            : constraints.maxWidth * 0.2;

        final double cardHeight = isSmall ? 400 : 400;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: isSmall ? 16 : 24,
            horizontal: isSmall ? 16 : 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Best Sellers",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              verticalMargin2,
              const Padding(
                padding:allPadding16,
                child: Text(
                  "Discover our most popular picks loved by customers – shop the Best Sellers now!",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              verticalMargin12,
              isSmall
                  // vertical list for phones
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      itemBuilder: (context, index) => _buildProductCard(
                        context,
                        products[index],
                        cartProvider,
                        cardWidth,
                        cardHeight,
                      ),
                    )
                  // grid-style wrap for web/tablet/large screens
                  : Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: products
                          .map((product) => _buildProductCard(
                                context,
                                product,
                                cartProvider,
                                cardWidth,
                                cardHeight,
                              ))
                          .toList(),
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    Product product,
    CartProvider cartProvider,
    double width,
    double height,
  ) {
    final isSmall = ResponsiveHelper.isSmallScreen(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Card(
        color: Colors.white10,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AspectRatio(
                    aspectRatio: 16 / 4,
                    child: product.image.startsWith('http')
                        ? Image.network(product.image, fit: BoxFit.cover)
                        : Image.asset(product.image, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 12),
                // Product Title
                Text(
                  product.description,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: isSmall ? 16 : 18,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Product Weight
                Text(
                  "Weight: ${product.weight}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                      ),
                ),
                const SizedBox(height: 8),
                // Product Price
                Text(
                  "Price: Ksh ${product.price.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: DogFoodAppTheme.primaryButtonColor,
                        fontSize: 16,
                      ),
                ),
                verticalMargin2,
                // Add to Cart Button
                ElevatedButton(
                  onPressed: () {
                    cartProvider.addToCart(product.toMap());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Added to cart")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DogFoodAppTheme.primaryButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text("Add to Cart"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
