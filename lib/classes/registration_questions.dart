import 'package:dog_food/constants/constants.dart';
import 'package:flutter/material.dart';

class RegistrationJourney extends StatefulWidget {
  @override
  _RegistrationJourneyState createState() => _RegistrationJourneyState();
}

class _RegistrationJourneyState extends State<RegistrationJourney> {
  int _currentStep = 0;
  String _dogName = '';
  String _gender = 'Male';
  String _breed = '';
  int _years = 0;
  int _months = 0;
  double _weight = 0.0;
  String _bodyCondition = 'Ideal';
  final List<String> _selectedRecipes = [];
  String _name = '';
  String _email = '';
  String _street = '';
  String _apartment = '';
  String _city = '';
  String _state = '';
  String _zipCode = '';
  String _phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
      padding: verticalPadding16,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 2) {
              setState(() {
                _currentStep += 1;
              });
            } else {
              // Process the final submission
              print('Dog Name: $_dogName');
              print('Gender: $_gender');
              print('Breed: $_breed');
              print('Age: $_years years and $_months months');
              print('Weight: $_weight');
              print('Body Condition: $_bodyCondition');
              print('Selected Recipes: $_selectedRecipes');
              print('Name: $_name');
              print('Email: $_email');
              print('Street: $_street');
              print('Apartment: $_apartment');
              print('City: $_city');
              print('State: $_state');
              print('Zip Code: $_zipCode');
              print('Phone Number: $_phoneNumber');
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep -= 1;
              });
            }
          },
          steps: [
            Step(
              title: const Text('About Your Dog'),
              content: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Dog's Name"),
                    onChanged: (value) {
                      setState(() {
                        _dogName = value;
                      });
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                    items: ['Male', 'Female'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Breed"),
                    onChanged: (value) {
                      setState(() {
                        _breed = value;
                      });
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: 'Years'),
                          onChanged: (value) {
                            setState(() {
                              _years = int.tryParse(value) ?? 0;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: 'Months'),
                          onChanged: (value) {
                            setState(() {
                              _months = int.tryParse(value) ?? 0;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Step(
              title: const Text('Weight & Body Condition'),
              content: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Weight (kg)"),
                    onChanged: (value) {
                      setState(() {
                        _weight = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _bodyCondition,
                    onChanged: (value) {
                      setState(() {
                        _bodyCondition = value!;
                      });
                    },
                    items: ['Underweight', 'Ideal', 'Overweight'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Step(
              title: const Text('Select Recipes'),
              content: Column(
                children: [
                  CheckboxListTile(
                    title: const Text('Chicken Cuisine \$8'),
                    value: _selectedRecipes.contains('Chicken Cuisine'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          _selectedRecipes.add('Chicken Cuisine');
                        } else {
                          _selectedRecipes.remove('Chicken Cuisine');
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Pork Potluck \$10'),
                    value: _selectedRecipes.contains('Pork Potluck'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          _selectedRecipes.add('Pork Potluck');
                        } else {
                          _selectedRecipes.remove('Pork Potluck');
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Step(
              title: const Text('Your Details'),
              content: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Name"),
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Email"),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Step(
              title: const Text('Delivery Address'),
              content: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Street"),
                    onChanged: (value) {
                      setState(() {
                        _street = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Apartment/Unit"),
                    onChanged: (value) {
                      setState(() {
                        _apartment = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "City"),
                    onChanged: (value) {
                      setState(() {
                        _city = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "State"),
                    onChanged: (value) {
                      setState(() {
                        _state = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Zip Code"),
                    onChanged: (value) {
                      setState(() {
                        _zipCode = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Phone Number"),
                    onChanged: (value) {
                      setState(() {
                        _phoneNumber = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}