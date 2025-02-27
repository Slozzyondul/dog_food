import 'dart:async';

import 'package:dog_food/constants/constants.dart';
import 'package:dog_food/constants/themes.dart';
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

class DogRegistration extends StatefulWidget {
  const DogRegistration._();

  static Route<RegistrationData> route(RegistrationData data) {
    return MaterialPageRoute(
      builder: (context) => const DogRegistration._(),
    );
  }

  @override
  State<DogRegistration> createState() => DogRegistrationState();
}

class DogRegistrationState extends State<DogRegistration> {
  final _data = RegistrationData();
  final _title = ValueNotifier<String>('');
  final _progress = ValueNotifier<double>(0.0);

  final _pages = <Widget>[
    const DogInfoPage(),
    const WeightPage(),
    const OwnerInfoPage(),
    const AddressPage(),
  ];

  int _pageIndex = 0;

  set title(String value) {
    _title.value = value;
  }

  @override
  void initState() {
    super.initState();
    updateProgress();
  }

  void gotoPrevPage() {
    if (_pageIndex == 0) {
      Navigator.of(context).pop(null);
    } else {
      setState(() => _pageIndex--);
      updateProgress();
    }
  }

  void gotoNextPage() {
    if (_pageIndex == _pages.length - 1) {
      Navigator.of(context).pop(_data);
    } else {
      setState(() => _pageIndex++);
      updateProgress();
    }
  }

  void updateProgress() {
    _progress.value = ((1 + _pageIndex) / _pages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: gotoPrevPage,
        ),
        title: ValueListenableBuilder(
          valueListenable: _title,
          builder: (BuildContext context, String value, Widget? child) {
            return Text(value);
          },
        ),
        backgroundColor: DogFoodAppTheme.themeBrownColor,
      ),
      body: Padding(
        padding: allPadding16,
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: _progress,
              builder: (BuildContext context, double value, Widget? child) {
                return LinearProgressIndicator(
                  value: value,
                  borderRadius: BorderRadius.circular(32),
                  color: DogFoodAppTheme.menuBrownColor,
                  minHeight: 32,
                );
              },
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                switchInCurve: Curves.fastOutSlowIn,
                switchOutCurve: Curves.fastOutSlowIn,
                child: _pages[_pageIndex],
              ),
            )
          ],
        ),
      ),
    );
  }
}

mixin DogRegistrationWizardMixin<T extends StatefulWidget> on State<T> {
  late DogRegistrationState registrationState;

  RegistrationData get data => registrationState._data;

  String get title;

  @override
  void initState() {
    super.initState();
    registrationState =
        context.findAncestorStateOfType<DogRegistrationState>()!;
    scheduleMicrotask(() {
      registrationState.title = title;
    });
  }

  void gotoNextPage() => registrationState.gotoNextPage();
}

// Page 1: Dog Information
class DogInfoPage extends StatefulWidget {
  const DogInfoPage({super.key});

  @override
  State<DogInfoPage> createState() => _DogInfoPageState();
}

class _DogInfoPageState extends State<DogInfoPage>
    with DogRegistrationWizardMixin {
  @override
  String get title => 'Dog Information';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          TextFormField(
            initialValue: data.dogName,
            decoration: const InputDecoration(labelText: "Dog's Name"),
            onChanged: (value) => data.dogName = value,
          ),
          DropdownButtonFormField<String>(
            value: data.gender,
            onChanged: (value) => setState(() => data.gender = value!),
            items: ['Male', 'Female'].map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
          ),
          TextFormField(
            initialValue: data.breed,
            decoration: const InputDecoration(labelText: 'Breed'),
            onChanged: (value) => data.breed = value,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: data.years.toString(),
                  decoration: const InputDecoration(labelText: 'Years'),
                  onChanged: (value) => data.years = int.tryParse(value) ?? 0,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  initialValue: data.months.toString(),
                  decoration: const InputDecoration(labelText: 'Months'),
                  onChanged: (value) => data.months = int.tryParse(value) ?? 0,
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
                  return DogFoodAppTheme.secondaryButtonColor; // Default color
                },
              ),
            ),
            onPressed: gotoNextPage,
            child: const Text('Continue'),
          )
        ],
      ),
    );
  }
}

// Page 2: Weight & Body Condition
class WeightPage extends StatefulWidget {
  const WeightPage({super.key});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage>
    with DogRegistrationWizardMixin {
  @override
  String get title => 'Weight & Condition';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          TextFormField(
            initialValue: data.weight.toString(),
            decoration: const InputDecoration(labelText: 'Weight (kg)'),
            onChanged: (value) => data.weight = double.tryParse(value) ?? 0.0,
          ),
          DropdownButtonFormField<String>(
            value: data.bodyCondition,
            onChanged: (value) => data.bodyCondition = value!,
            items: ['Underweight', 'Ideal', 'Overweight'].map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
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
                  return DogFoodAppTheme.secondaryButtonColor; // Default color
                },
              ),
            ),
            onPressed: gotoNextPage,
            child: const Text('Continue'),
          )
        ],
      ),
    );
  }
}

// Page 3: Owner Info
class OwnerInfoPage extends StatefulWidget {
  const OwnerInfoPage({super.key});

  @override
  State<OwnerInfoPage> createState() => _OwnerInfoPageState();
}

class _OwnerInfoPageState extends State<OwnerInfoPage>
    with DogRegistrationWizardMixin {
  @override
  String get title => 'Owner Information';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Name'),
            onChanged: (value) => data.name = value,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
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
                  return DogFoodAppTheme.secondaryButtonColor; // Default color
                },
              ),
            ),
            onPressed: gotoNextPage,
            child: const Text('Continue'),
          )
        ],
      ),
    );
  }
}

// Page 4: Address & Confirmation
class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage>
    with DogRegistrationWizardMixin {
  void _showConfirmationDialog() async {
    await showDialog(
      context: context,
      builder: (context) => RegistrationConfirmationDialog(data: data),
    );
    gotoNextPage();
  }

  @override
  String get title => 'Delivery Address';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Street'),
            onChanged: (value) => data.street = value,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'City'),
            onChanged: (value) => data.city = value,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Phone Number'),
            onChanged: (value) => data.phoneNumber = value,
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
                  return DogFoodAppTheme.secondaryButtonColor; // Default color
                },
              ),
            ),
            onPressed: _showConfirmationDialog,
            child: const Text('Finish'),
          )
        ],
      ),
    );
  }
}

class RegistrationConfirmationDialog extends StatelessWidget {
  const RegistrationConfirmationDialog({
    super.key,
    required this.data,
  });

  final RegistrationData data;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmation'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text('Dog Name: ${data.dogName}'),
            Text('Gender: ${data.gender}'),
            Text('Breed: ${data.breed}'),
            Text('Age: ${data.years} years, ${data.months} months'),
            Text('Weight: ${data.weight} kg'),
            Text('Body Condition: ${data.bodyCondition}'),
            Text('Name: ${data.name}'),
            Text('Email: ${data.email}'),
            Text('Street: ${data.street}'),
            Text('Apartment: ${data.apartment}'),
            Text('City: ${data.city}'),
            Text('State: ${data.state}'),
            Text('Zip Code: ${data.zipCode}'),
            Text('Phone Number: ${data.phoneNumber}'),
          ],
        ),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return DogFoodAppTheme.backgroundColor; // Color when pressed
                }
                return DogFoodAppTheme.secondaryButtonColor; // Default color
              },
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'OK',
            style: TextStyle(color: DogFoodAppTheme.backgroundColor),
          ),
        ),
      ],
    );
  }
}
