import 'package:dog_food/constants/constants.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:dog_food/screens/home_page.dart';
import 'package:flutter/material.dart';

// Model to hold registration data
class RegistrationData {
  String dogName = '';
  String gender = 'Male';
  String breed = '';
  int years = 0;
  int months = 0;
  double weight = 0.0;
  String bodyCondition = 'Ideal';
  String name = '';
  String email = '';
  String street = '';
  String apartment = '';
  String city = '';
  String state = '';
  String zipCode = '';
  String phoneNumber = '';
}

// Page 1: Dog Information
class DogInfoPage extends StatefulWidget {
  final RegistrationData data;
  final double progress;
  const DogInfoPage({super.key, required this.data, this.progress = 0.25});

  @override
  _DogInfoPageState createState() => _DogInfoPageState();
}

class _DogInfoPageState extends State<DogInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dog Information",
        ),
        backgroundColor: DogFoodAppTheme.themeBrownColor,
      ),
      body: Padding(
        padding: allPadding16,
        child: Column(
          children: [
            LinearProgressIndicator(
              value: widget.progress,
              borderRadius: BorderRadius.circular(32),
              color: DogFoodAppTheme.menuBrownColor,
              minHeight: 32,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Dog's Name"),
              onChanged: (value) => widget.data.dogName = value,
            ),
            DropdownButtonFormField<String>(
              value: widget.data.gender,
              onChanged: (value) => setState(() => widget.data.gender = value!),
              items: ['Male', 'Female'].map((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Breed"),
              onChanged: (value) => widget.data.breed = value,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Years'),
                    onChanged: (value) =>
                        widget.data.years = int.tryParse(value) ?? 0,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Months'),
                    onChanged: (value) =>
                        widget.data.months = int.tryParse(value) ?? 0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return DogFoodAppTheme
                          .backgroundColor; // Color when pressed
                    }
                    return DogFoodAppTheme
                        .secondaryButtonColor; // Default color
                  },
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeightPage(data: widget.data, progress: 0.5),
                  ),
                );
              },
              child: const Text("Continue"),
            )
          ],
        ),
      ),
    );
  }
}

// Page 2: Weight & Body Condition
class WeightPage extends StatelessWidget {
  final RegistrationData data;
  final double progress;
  const WeightPage({super.key, required this.data, this.progress = 0.5});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weight & Condition"),
        backgroundColor: DogFoodAppTheme.themeBrownColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              borderRadius: BorderRadius.circular(32),
              color: DogFoodAppTheme.menuBrownColor,
              minHeight: 32,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Weight (kg)"),
              onChanged: (value) => data.weight = double.tryParse(value) ?? 0.0,
            ),
            DropdownButtonFormField<String>(
              value: data.bodyCondition,
              onChanged: (value) => data.bodyCondition = value!,
              items: ['Underweight', 'Ideal', 'Overweight'].map((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return DogFoodAppTheme
                          .backgroundColor; // Color when pressed
                    }
                    return DogFoodAppTheme
                        .secondaryButtonColor; // Default color
                  },
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OwnerInfoPage(data: data, progress: 0.75),
                  ),
                );
              },
              child: const Text("Continue"),
            )
          ],
        ),
      ),
    );
  }
}

// Page 3: Owner Info
class OwnerInfoPage extends StatelessWidget {
  final RegistrationData data;
  final double progress;
  const OwnerInfoPage({super.key, required this.data, this.progress = 0.75});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Owner Information"),
        backgroundColor: DogFoodAppTheme.themeBrownColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              borderRadius: BorderRadius.circular(32),
              color: DogFoodAppTheme.menuBrownColor,
              minHeight: 32,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Name"),
              onChanged: (value) => data.name = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Email"),
              onChanged: (value) => data.email = value,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return DogFoodAppTheme
                          .backgroundColor; // Color when pressed
                    }
                    return DogFoodAppTheme
                        .secondaryButtonColor; // Default color
                  },
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddressPage(data: data, progress: 1.0),
                  ),
                );
              },
              child: const Text("Continue"),
            )
          ],
        ),
      ),
    );
  }
}

// Page 4: Address & Confirmation
class AddressPage extends StatefulWidget {
  final RegistrationData data;
  final double progress;
  const AddressPage({super.key, required this.data, this.progress = 1.0});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Dog Name: ${widget.data.dogName}"),
                Text("Gender: ${widget.data.gender}"),
                Text("Breed: ${widget.data.breed}"),
                Text(
                    "Age: ${widget.data.years} years, ${widget.data.months} months"),
                Text("Weight: ${widget.data.weight} kg"),
                Text("Body Condition: ${widget.data.bodyCondition}"),
                Text("Name: ${widget.data.name}"),
                Text("Email: ${widget.data.email}"),
                Text("Street: ${widget.data.street}"),
                Text("Apartment: ${widget.data.apartment}"),
                Text("City: ${widget.data.city}"),
                Text("State: ${widget.data.state}"),
                Text("Zip Code: ${widget.data.zipCode}"),
                Text("Phone Number: ${widget.data.phoneNumber}"),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return DogFoodAppTheme
                          .backgroundColor; // Color when pressed
                    }
                    return DogFoodAppTheme
                        .secondaryButtonColor; // Default color
                  },
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: const Text("OK", style: TextStyle(color: DogFoodAppTheme.backgroundColor),),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery Address"),
        backgroundColor: DogFoodAppTheme.themeBrownColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(value: 1.0,
            borderRadius: BorderRadius.circular(32),
              color: DogFoodAppTheme.menuBrownColor,
              minHeight: 32,),
            TextFormField(
              decoration: const InputDecoration(labelText: "Street"),
              onChanged: (value) => widget.data.street = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "City"),
              onChanged: (value) => widget.data.city = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Phone Number"),
              onChanged: (value) => widget.data.phoneNumber = value,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return DogFoodAppTheme
                          .backgroundColor; // Color when pressed
                    }
                    return DogFoodAppTheme
                        .secondaryButtonColor; // Default color
                  },
                ),
              ),
              onPressed: _showConfirmationDialog,
              child: const Text("Finish"),
            )
          ],
        ),
      ),
    );
  }
}
