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
    image: 'assets/assets/images/1.png',
    description: 'Product 1',
    weight: '500g',
    price: 1.00,
  ),
  Product(
    image: 'assets/assets/images/2.png',
    description: 'Product 2',
    weight: '1kg',
    price: 2.00,
  ),
  Product(
    image: 'assets/assets/images/3.png',
    description: 'Product 3',
    weight: '750g',
    price: 3.00,
  ),
  Product(
    image: 'assets/assets/images/4.png',
    description: 'Product 4',
    weight: '500g',
    price: 700.00,
  ),
  Product(
    image: 'assets/assets/images/5.png',
    description: 'Product 5',
    weight: '1kg',
    price: 1800.00,
  ),
  Product(
    image: 'assets/assets/images/6.png',
    description: 'Product 6',
    weight: '750g',
    price: 1500.00,
  ),
  // Product(
  //   image: 'assets/assets/images/7.png',
  //   description: 'Product 7',
  //   weight: '500g',
  //   price: 350.00,
  // ),
  // Product(
  //   image: 'assets/assets/images/8.png',
  //   description: 'Product 8',
  //   weight: '500g',
  //   price: 350.00,
  // ),
  // Product(
  //   image: 'assets/assets/images/9.png',
  //   description: 'Product 9',
  //   weight: '500g',
  //   price: 350.00,
  // ),
];