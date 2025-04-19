import 'dart:convert';

import 'package:dog_food/constants/constants.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'package:http/http.dart' as http;

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Future<void> _checkout(double totalAmount, String phoneNumber) async {
    //live environment
    const url = "https://slozzy.pythonanywhere.com/pay";
    //local environment test
    //const url = "http://127.0.0.1:5000/pay";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "phone_number": phoneNumber,
          "amount": totalAmount,
        }),
      );

      final data = jsonDecode(response.body);

      if (!mounted) return;

      if (response.statusCode == 200 && data["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Payment initiated successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment failed: ${data["error"] ?? "Unknown error"}")),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  Future<void> _showPhoneNumberDialog(double totalAmount) async {
    final phoneNumberController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Phone Number'),
          content: TextField(
            controller: phoneNumberController,
            decoration: const InputDecoration(hintText: "2547XXXXXXXX"),
            keyboardType: TextInputType.phone,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Proceed'),
              onPressed: () {
                Navigator.of(context).pop();
                _checkout(totalAmount, phoneNumberController.text);
              },
            ),
          ],
        );
      },
    );
  }

  // void _startCardPayment(double totalAmount) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text("Card payment coming soon...")),
  //   );
  //   // TODO: Call backend to create Stripe payment intent and confirm payment
  // }

  void _startPayPalPayment(double totalAmount) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("PayPal payment coming soon...")),
    );
    // TODO: Open PayPal checkout in a WebView or redirect to payment page
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Checkout")),
        backgroundColor: DogFoodAppTheme.themeBrownColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final product = cartProvider.cartItems[index];
                return ListTile(
                  leading: product['image'].toString().startsWith('http')
                      ? Image.network(
                          product['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, StackTrace? StackTrace) =>
                              const Icon(Icons.broken_image),
                        )
                      : Image.asset(
                          product['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                  title: Text(product['description']),
                  subtitle: Text("Price: ${product['price']} \nWeight: ${product['weight']}"),
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
                  style: ElevatedButton.styleFrom(
                    padding: horizontalPadding24 + verticalPadding8,
                    backgroundColor: DogFoodAppTheme.primaryButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => _showPhoneNumberDialog(cartProvider.totalAmount),
                  child: const Text("Pay with M-Pesa"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: horizontalPadding24 + verticalPadding8,
                    backgroundColor: DogFoodAppTheme.primaryButtonColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => _startPayPalPayment(cartProvider.totalAmount),
                  child: const Text("Pay with PayPal"),
                ),
                // const SizedBox(height: 10),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     padding: horizontalPadding24 + verticalPadding8,
                //     backgroundColor: DogFoodAppTheme.primaryButtonColor,
                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                //   ),
                //   onPressed: () => _startCardPayment(cartProvider.totalAmount),
                //   child: const Text("Pay with Mastercard / Visa"),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
