import 'package:dog_food/constants/constants.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'package:dart_mpesa/dart_mpesa.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  void _checkout(BuildContext context, double totalAmount, String phoneNumber) async {
    final mpesa = Mpesa(
      consumerKey: "YOUR_CONSUMER_KEY",
      consumerSecret: "YOUR_CONSUMER_SECRET",
      passKey: "YOUR_PASSKEY",
      shortCode: "YOUR_SHORTCODE",
    );

    try {
      final response = await mpesa.lipanaMpesaOnline(
        phoneNumber: phoneNumber,
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

  Future<void> _showPhoneNumberDialog(BuildContext context, double totalAmount) async {
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
                _checkout(context, totalAmount, phoneNumberController.text);
              },
            ),
          ],
        );
      },
    );
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
                  style: ElevatedButton.styleFrom(
                    padding: horizontalPadding24 + verticalPadding8,
                    backgroundColor: DogFoodAppTheme.primaryButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => _showPhoneNumberDialog(context, cartProvider.totalAmount),
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