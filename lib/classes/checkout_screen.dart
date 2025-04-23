import 'dart:convert';

import 'package:dog_food/constants/constants.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_paypal/flutter_paypal.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Future<void> _checkout(double totalAmount, String phoneNumber) async {
    if (!RegExp(r'^2547\d{8}$').hasMatch(phoneNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid phone number. Use format: 2547XXXXXXXX")),
      );
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

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

// paypal mehod

  void _startPayPalPayment(double totalAmount) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UsePaypal(
          sandboxMode: true,
          clientId:
              "AX6P1vJ75eNqQz08mGQLee4_DYIkFDtmxD_thZSmvJ55ByeUtiozFc5D5FK9DM4unXBLZ05h-cAFK2K5",
          secretKey:
              "AX6P1vJ75eNqQz08mGQLee4_DYIkFDtmxD_thZSmvJ55ByeUtiozFc5D5FK9DM4unXBLZ05h-cAFK2K5",
          returnURL: "success.snippetcoder.com",
          cancelURL: "cancel.snippetcoder.com",
          transactions: [
            {
              "amount": {
                "total": totalAmount.toStringAsFixed(2),
                "currency": "USD",
                "details": {
                  "subtotal": totalAmount.toStringAsFixed(2),
                  "shipping": '0',
                  "shipping_discount": 0,
                },
              },
              "description": "Payment for dog food items.",
              "item_list": {
                "items": [
                  {
                    "name": "Dog food order",
                    "quantity": 1,
                    "price": totalAmount.toStringAsFixed(2),
                    "currency": "USD",
                  }
                ],
              },
            }
          ],
          note: "Thanks for shopping with us!",
          onSuccess: (Map params) async {
            debugPrint("PayPal Success: $params");
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Payment successful!")),
            );
          },
          onError: (error) {
            debugPrint("PayPal Error: $error");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Payment error occurred.")),
            );
          },
          onCancel: () {
            debugPrint("PayPal Cancelled");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Payment cancelled.")),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showPaypalDialog(double totalAmount) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pay with PayPal'),
          content: Text(
              'Proceed to PayPal to complete the payment of \$${totalAmount.toStringAsFixed(2)}?'),
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
                Navigator.of(context).pop(); // Close dialog first
                _startPayPalPayment(totalAmount); // Now kick off PayPal flow
              },
            ),
          ],
        );
      },
    );
  }

// //stripe payment method
//   Future<void> _showStripeDialog(double totalAmount) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Stripe Payment'),
//           content: Text('Proceed to pay \$${totalAmount.toStringAsFixed(2)} using Stripe?'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('Proceed'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 // TODO: Call backend to create Stripe payment intent and confirm payment
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Processing Stripe payment...')),
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

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
                  onPressed: () => _showPaypalDialog(cartProvider.totalAmount),
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
