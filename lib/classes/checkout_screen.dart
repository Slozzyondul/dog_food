import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'package:dart_mpesa/dart_mpesa.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  void _checkout(BuildContext context, double totalAmount) async {
    final mpesa = Mpesa(
      consumerKey: "YOUR_CONSUMER_KEY",
      consumerSecret: "YOUR_CONSUMER_SECRET",
      passKey: "YOUR_PASSKEY",
      shortCode: "YOUR_SHORTCODE",
    );

    try {
      final response = await mpesa.lipanaMpesaOnline(
        phoneNumber: "2547XXXXXXXX",
        amount: totalAmount,
        callBackURL: "https://your-callback-url.com",
        accountReference: "Dog Food Order",
        transactionDesc: "Buying Dog Food", 
      );

      if (response.responseCode == "0") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Payment successful!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment failed: ${response.errorMessage}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final product = cartProvider.cartItems[index];
                return ListTile(
                  title: Text(product['description']),
                  subtitle: Text("Price: ${product['price']}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () => cartProvider.removeFromCart(index),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("Total: KES ${cartProvider.totalAmount}",
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _checkout(context, cartProvider.totalAmount),
                  child: const Text("Pay with M-Pesa"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
