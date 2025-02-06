import 'package:dog_food/classes/cart_provider.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:dog_food/keys/keys.dart';
import 'package:dog_food/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:provider/provider.dart';

void main() {
  MpesaFlutterPlugin.setConsumerKey(kConsumerKey);
  MpesaFlutterPlugin.setConsumerSecret(kConsumerSecret);

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(ChangeNotifierProvider(
    child: const MyApp(),
    create: (context) => CartProvider(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
