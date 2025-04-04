import 'package:dog_food/classes/cart_provider.dart';
import 'package:dog_food/classes/models/best_seller_model.dart';
import 'package:dog_food/constants/constants.dart';
import 'package:dog_food/page_size/responsive_screen_helper.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BestSellerWidget extends StatelessWidget {
  const BestSellerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmall = ResponsiveHelper.isSmallScreen(context);
    final isLandscape = ResponsiveHelper.isLandscape(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isSmall ? 16 : 24,
        horizontal: isSmall ? 8 : 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Best Sellers",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          verticalMargin4,
          const Padding(
            padding: allPadding16,
            child: Text(
              overflow: TextOverflow.visible,
              "Discover our most popular picks loved by customers – shop the Best Sellers now!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          verticalMargin4,
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = isSmall
                  ? constraints.maxWidth * 0.9
                  : constraints.maxWidth * 0.45;
              final cardHeight = isLandscape
                  ? constraints.maxHeight * 0.8
                  : constraints.maxHeight * 0.6;

              return SizedBox(
                height: isSmall ? cardHeight * 2.2 : cardHeight * 1.2,
                child: isSmall
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: products.length,
                        itemBuilder: (context, index) => _buildProductCard(
                            context,
                            products[index],
                            cartProvider,
                            cardWidth,
                            cardHeight),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        itemBuilder: (context, index) => _buildProductCard(
                            context,
                            products[index],
                            cartProvider,
                            cardWidth,
                            cardHeight),
                      ),
              );
            },
          ),
        ],
      ),
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

    return Padding(
      padding: EdgeInsets.all(isSmall ? 8 : 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: EdgeInsets.all(isSmall ? 12 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: product.image.startsWith('http')
                          ? Image.network(
                              product.image,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              product.image,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: ResponsiveHelper.responsiveValue(
                            context,
                            small: 16,
                            large: 18,
                          ),
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Weight: ${product.weight}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: ResponsiveHelper.responsiveValue(
                            context,
                            small: 14,
                            large: 16,
                          ),
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Price: Ksh ${product.price.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: DogFoodAppTheme.primaryButtonColor,
                          fontSize: ResponsiveHelper.responsiveValue(
                            context,
                            small: 16,
                            large: 18,
                          ),
                        ),
                  ),
                  const Spacer(),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        cartProvider.addToCart(product.toMap());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Added to cart")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmall ? 16 : 24,
                          vertical: isSmall ? 8 : 12,
                        ),
                        backgroundColor: DogFoodAppTheme.primaryButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                          fontSize: ResponsiveHelper.responsiveValue(
                            context,
                            small: 14,
                            large: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
