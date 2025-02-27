import 'package:dog_food/classes/cart_provider.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:dog_food/keys/keys.dart';
import 'package:dog_food/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Add this import

void main() {
  // Initialize Google Sign-In
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: kGoogleClientId,
    scopes: [
      'https://www.googleapis.com/auth/spreadsheets',
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/userinfo.email',
      'openid',
    ],
  );

  // Initialize MPESA
  MpesaFlutterPlugin.setConsumerKey(kConsumerKey);
  MpesaFlutterPlugin.setConsumerSecret(kConsumerSecret);

  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Run the app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        Provider<GoogleSignIn>.value(value: googleSignIn), // Provide GoogleSignIn instance
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: DogFoodAppTheme.themeBrownColor,
      debugShowCheckedModeBanner: false,
      title: 'Dog Food',
      theme: ThemeData.light(useMaterial3: false),
      home: const HomePage(),
    );
  }
}