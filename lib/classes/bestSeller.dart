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
        final double cardWidth =
            isSmall ? MediaQuery.of(context).size.width * 0.8 : 300;
        //isSmall ? constraints.maxWidth * 0.1 : constraints.maxWidth * 0.3;

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
                padding: allPadding16,
                child: Text(
                  "Discover our most popular picks loved by customers – shop the Best Sellers now!",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              verticalMargin4,
              isSmall
                  // carousel for phones
                  ? SizedBox(
                      height: cardHeight + 40, // extra room for buttons/text
                      child: PageView.builder(
                        itemCount: products.length,
                        controller: PageController(viewportFraction: 0.85),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: _buildProductCard(
                            context,
                            products[index],
                            cartProvider,
                            cardWidth,
                            cardHeight,
                          ),
                        ),
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
        shadowColor: DogFoodAppTheme.menuBrownColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: product.image.startsWith('http')
                    ? Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: Colors.grey),
                      )
                    : Image.asset(
                        product.image,
                        fit: BoxFit.cover,
                      ),
              ),

              // Dark overlay for better text visibility
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                      stops: const [0.5, 1.0],
                    ),
                  ),
                ),
              ),

              // Content
              Center(
                child: Padding(
                  padding: allPadding8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Product Title
                      Text(
                        product.description,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isSmall ? 16 : 18,
                                  color: Colors.black,
                                ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      verticalMargin2,

                      // Product Weight
                      Text(
                        "Weight: ${product.weight}",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: isSmall ? 14 : 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),

                      verticalMargin2,

                      // Product Price
                      Text(
                        "Price: Ksh ${product.price.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: DogFoodAppTheme.primaryButtonColor,
                              fontSize: isSmall ? 14 : 16,
                              fontWeight: FontWeight.bold,
                            ),
                      ),

                      verticalMargin2,
                      // Add to Cart Button
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: ElevatedButton(
                          onPressed: () {
                            cartProvider.addToCart(product.toMap());
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Added to cart")),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: DogFoodAppTheme.primaryButtonColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: const Text("Add to Cart"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
