import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTaxi extends StatefulWidget {
  @override
  _AddTaxiState createState() => _AddTaxiState();
}

class _AddTaxiState extends State<AddTaxi> {
  final _formKey = GlobalKey<FormState>();

  String _driverName = '';
  String _driverContactNo = '';
  String _vehicleName = '';
  String _licenceNo = '';
  String _driverProfilePhoto = '';
  String _vehiclePhoto = '';
  double _fareFees = 0.0;
  String _location = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Taxi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Driver Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter driver name.';
                  }
                  return null;
                },
                onChanged: (value) {
                  _driverName = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Driver Contact No.'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter driver contact no.';
                  }
                  return null;
                },
                onChanged: (value) {
                  _driverContactNo = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Vehicle Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter vehicle name.';
                  }
                  return null;
                },
                onChanged: (value) {
                  _vehicleName = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Licence No.'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter licence no.';
                  }
                  return null;
                },
                onChanged: (value) {
                  _licenceNo = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Driver Profile Photo URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter driver profile photo URL.';
                  }
                  return null;
                },
                onChanged: (value) {
                  _driverProfilePhoto = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Vehicle Photo URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter vehicle photo URL.';
                  }
                  return null;
                },
                onChanged: (value) {
                  _vehiclePhoto = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Fare Fees'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter fare fees.';
                  }
                  return null;
                },
                onChanged: (value) {
                  _fareFees = double.parse(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Vehicle Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location.';
                  }
                  return null;
                },
                onChanged: (value) {
                  _location = value;
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addTaxiToFirestore();
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Taxi'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addTaxiToFirestore() {
    FirebaseFirestore.instance.collection('taxi_fees').add({
      'driver_name': _driverName,
      'driver_contact_no': _driverContactNo,
      'vehicle_name': _vehicleName,
      'licence_no': _licenceNo,
      'driver_photo_url': _driverProfilePhoto,
      'taxi_picture_url': _vehiclePhoto,
      'fees_per_km': _fareFees,
      'location': _location,
      'type': _vehicleName,
    });
  }
}