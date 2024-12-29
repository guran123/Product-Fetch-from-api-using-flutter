import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: UserForm(),
  debugShowCheckedModeBanner: false));
}

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _gender;
  String? _country;
  String? _state;
  String? _city;

  // Sample dropdown data
  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _countries = ['India', 'USA', 'Canada'];
  final Map<String, List<String>> _states = {
    'India': ['Maharashtra', 'Punjab', 'Delhi'],
    'USA': ['California', 'Texas', 'New York'],
    'Canada': ['Ontario', 'Quebec', 'Alberta'],
  };
  final Map<String, List<String>> _cities = {
    'Maharashtra': ['Mumbai', 'Pune'],
    'Punjab': ['Amritsar', 'Ludhiana'],
    'California': ['Los Angeles', 'San Francisco'],
    // Add more cities for each state...
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Registration Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name field
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Email field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    final emailRegex = RegExp(r"^[^@]+@[^@]+\.[^@]+");
                    if (!emailRegex.hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Phone field
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: "Phone"),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your phone number";
                    }
                    if (value.length != 10) {
                      return "Phone number must be 10 digits";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Gender dropdown
                DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: InputDecoration(labelText: "Gender"),
                  items: _genders
                      .map((gender) => DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                  validator: (value) =>
                  value == null ? "Please select a gender" : null,
                ),
                SizedBox(height: 16),

                // Country dropdown
                DropdownButtonFormField<String>(
                  value: _country,
                  decoration: InputDecoration(labelText: "Country"),
                  items: _countries
                      .map((country) => DropdownMenuItem(
                    value: country,
                    child: Text(country),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _country = value;
                      _state = null;
                      _city = null;
                    });
                  },
                  validator: (value) =>
                  value == null ? "Please select a country" : null,
                ),
                SizedBox(height: 16),

                // State dropdown
                if (_country != null)
                  DropdownButtonFormField<String>(
                    value: _state,
                    decoration: InputDecoration(labelText: "State"),
                    items: _states[_country]!
                        .map((state) => DropdownMenuItem(
                      value: state,
                      child: Text(state),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _state = value;
                        _city = null;
                      });
                    },
                    validator: (value) =>
                    value == null ? "Please select a state" : null,
                  ),
                SizedBox(height: 16),

                // City dropdown
                if (_state != null)
                  DropdownButtonFormField<String>(
                    value: _city,
                    decoration: InputDecoration(labelText: "City"),
                    items: _cities[_state]!
                        .map((city) => DropdownMenuItem(
                      value: city,
                      child: Text(city),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _city = value;
                      });
                    },
                    validator: (value) =>
                    value == null ? "Please select a city" : null,
                  ),
                SizedBox(height: 16),

                // Submit button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Form submitted successfully")),
                        );
                      }
                    },
                    child: Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
