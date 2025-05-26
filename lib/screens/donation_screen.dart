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

  // Get current location function
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
  //Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
  //Location services are not enabled,request to enable them 
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return;
      }
    }
   //Fetch current position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      location = "Lat: ${position.latitude}, Lon: ${position.longitude}";
      _locationController.text = location;//pre-fill manual location input with fetched location
    });
  }
}
  // Function to format the slider value to time format
  String getFormattedTime(double sliderValue) {
    int hours = sliderValue.toInt();
    int minutes = ((sliderValue - hours) * 60).toInt();
    String period = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    hours = hours == 0 ? 12 : hours; // Fix for 12 AM/PM representation

    return '$hours:$minutes $period';
  }

  // Method to select location by tapping on map
  void _onMapTapped(LatLng position) {
    setState(() {
      _currentLocation = position;
      isLocationSelected = true;
      _locationController.text = "Lat: ${position.latitude}, Lon: ${position.longitude}";
    });
  }

  // Date picker function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ) ?? selectedDate;
    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Fetch current location when the page is created
  }



