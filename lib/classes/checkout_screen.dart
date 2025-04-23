import 'dart:convert';
import 'package:dog_food/constants/constants.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final currencySymbol = NumberFormat.simpleCurrency(name: "KES").currencySymbol;
  final _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isProcessingPayment = false;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _processMpesaPayment(double totalAmount, String phoneNumber) async {
    if (!mounted) return;

    setState(() => _isProcessingPayment = true);

    try {
      // Live environment
      const url = "https://slozzy.pythonanywhere.com/pay";
      // Local test environment
      // const url = "http://127.0.0.1:5000/pay";

      final response = await http
          .post(
            Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "phone_number": phoneNumber,
              "amount": totalAmount,
            }),
          )
          .timeout(const Duration(seconds: 30));

      final data = jsonDecode(response.body);

      if (!mounted) return;

      if (response.statusCode == 200 && data["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Payment initiated successfully!")),
        );
        // Optionally clear cart after successful payment
        Provider.of<CartProvider>(context, listen: false).clearCart();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment failed: ${data["error"] ?? "Unknown error"}")),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessingPayment = false);
      }
    }
  }

  Future<void> _showPaymentMethodDialog(double totalAmount) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pay $currencySymbol${totalAmount.toStringAsFixed(2)}'),
          content: const Text('Choose your payment method'),
          actions: [
            TextButton(
              child: const Text('M-Pesa'),
              onPressed: () {
                Navigator.of(context).pop();
                _showMpesaPhoneNumberDialog(totalAmount);
              },
            ),
            TextButton(
              child: const Text('PayPal'),
              onPressed: () {
                Navigator.of(context).pop();
                _showPaypalConfirmation(totalAmount);
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMpesaPhoneNumberDialog(double totalAmount) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter M-Pesa Phone Number'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                hintText: "2547XXXXXXXX",
                labelText: "Phone Number",
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter phone number';
                }
                if (!RegExp(r'^254[17]\d{8}$').hasMatch(value)) {
                  return 'Enter valid Kenyan number (2547XXXXXXXX)';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Pay'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                  _processMpesaPayment(totalAmount, _phoneNumberController.text);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _processPayPalPayment(double totalAmount) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UsePaypal(
          sandboxMode: true,
          clientId:
              "AX6P1vJ75eNqQz08mGQLee4_DYIkFDtmxD_thZSmvJ55ByeUtiozFc5D5FK9DM4unXBLZ05h-cAFK2K5",
          secretKey:
              "EGHg19ko_SzK__6mL2yuouGZXz51gpaQlWXuhPUXlNhOwJydA_DwquRSWlfXXr7j3Pwf6it8IgMq0ksF",
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
            Provider.of<CartProvider>(context, listen: false).clearCart();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Payment successful!")),
            );
          },
          onError: (error) {
            debugPrint("PayPal Error: $error");
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Payment error occurred.")),
            );
          },
          onCancel: () {
            debugPrint("PayPal Cancelled");
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Payment cancelled.")),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showPaypalConfirmation(double totalAmount) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm PayPal Payment'),
          content: Text('Proceed to pay \$${totalAmount.toStringAsFixed(2)} via PayPal?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                _processPayPalPayment(totalAmount);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCartItem(Map<String, dynamic> product, int index, CartProvider cartProvider) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: product['image'].toString().startsWith('http')
            ? Image.network(
                product['image'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
              )
            : Image.asset(
                product['image'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
        title: Text(product['description']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Price: $currencySymbol${product['price']}"),
            if (product['weight'] != null) Text("Weight: ${product['weight']}"),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle, color: Colors.red),
          onPressed: () => cartProvider.removeFromCart(index),
        ),
      ),
    );
  }

  Widget _buildPaymentButton(String text, VoidCallback? onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: horizontalPadding24 + verticalPadding8,
        backgroundColor: DogFoodAppTheme.primaryButtonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final totalAmount = cartProvider.totalAmount;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Checkout")),
        backgroundColor: DogFoodAppTheme.themeBrownColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: cartProvider.cartItems.isEmpty
                ? const Center(child: Text("Your cart is empty"))
                : ListView.builder(
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) => _buildCartItem(
                      cartProvider.cartItems[index],
                      index,
                      cartProvider,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Total: $currencySymbol${totalAmount.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildPaymentButton(
                  'Proceed to Payment',
                  totalAmount > 0 ? () => _showPaymentMethodDialog(totalAmount) : null,
                ),
                if (_isProcessingPayment) ...[
                  const SizedBox(height: 16),
                  const CircularProgressIndicator(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
