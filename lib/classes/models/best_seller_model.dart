class Product {
  final String image;
  final String description;
  final String weight;
  final double price;

  Product({
    required this.image,
    required this.description,
    required this.weight,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'description': description,
      'weight': weight,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      weight: map['weight'] ?? '',
      price: (map['price'] as num).toDouble(),
    );
  }
}

final List<Product> products = [
  Product(
    image: 'assets/images/real-meat.png',
    description: 'Product 1',
    weight: '500g',
    price: 1.00,
  ),
  Product(
    image: 'assets/assets/images/affordable.png',
    description: 'Product 2',
    weight: '1kg',
    price: 2.00,
  ),
  Product(
    image: 'assets/assets/images/banner1.png',
    description: 'Product 3',
    weight: '750g',
    price: 3.00,
  ),
  Product(
    image: 'assets/assets/images/chicken-kibble.png',
    description: 'Product 4',
    weight: '500g',
    price: 700.00,
  ),
  Product(
    image: 'assets/assets/images/lamb-kibble.png',
    description: 'Product 5',
    weight: '1kg',
    price: 1800.00,
  ),
  Product(
    image: 'assets/assets/images/real-meat.png',
    description: 'Product 6',
    weight: '750g',
    price: 1500.00,
  ),
  Product(
    image: 'assets/assets/images/affordable.png',
    description: 'Product 7',
    weight: '500g',
    price: 350.00,
  ),
];