import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final TextEditingController _foodItemController = TextEditingController();
  final TextEditingController _foodDescriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController(); // For manual location input
  DateTime selectedDate = DateTime.now();
  double quantity = 10;
  bool isChecked = false;
  double pickupTimeSliderValue = 12.0; // Default value for 12:00 PM
  String location = "Fetching location..."; // Initial placeholder for location
  late GoogleMapController mapController;
  late LatLng _currentLocation;
  bool isLocationSelected = false;

