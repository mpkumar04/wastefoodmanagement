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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // Handle back navigation
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Donate',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Food Item Input
            TextField(
              controller: _foodItemController,
              decoration: InputDecoration(
                labelText: 'Food Item (s)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),

            // Food Description Input
            TextField(
              controller: _foodDescriptionController,
              decoration: InputDecoration(
                labelText: 'Food Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),

            // Pickup Day Date Picker
            Row(
              children: [
                Text('Pickup Day: ${selectedDate.toLocal()}'.split(' ')[0]),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),  // Call the _selectDate method
                ),
              ],
            ),
            SizedBox(height: 12),

            // Location: Allow both manual input and fetching current location
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      labelText: 'Enter your location',
                      border: OutlineInputBorder(),
                    ),
                    // This allows the user to manually input the location
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.location_on),
                  onPressed: _getCurrentLocation, // Fetch current location
                ),
              ],
            ),
            SizedBox(height: 12),

            // Google Map to select location manually
            SizedBox(
              height: 200,
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: _currentLocation,
                  zoom: 14,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('currentLocation'),
                    position: _currentLocation,
                    infoWindow: InfoWindow(title: "Selected Location"),
                  ),
                },
                onTap: _onMapTapped, // Set location on tap
              ),
            ),
            SizedBox(height: 12),

            // Pickup Time Slider (Editable like progress bar)
            Text('Pickup Time: ${getFormattedTime(pickupTimeSliderValue)}'),
            Slider(
              value: pickupTimeSliderValue,
              min: 10.0,  // Min value for 10:00 AM
              max: 21.0,  // Max value for 9:00 PM
              divisions: 11,  // 11 divisions representing the hours from 10 AM to 9 PM
              label: getFormattedTime(pickupTimeSliderValue),  // Format the label to show time
              onChanged: (double value) {
                setState(() {
                  pickupTimeSliderValue = value;  // Update the slider value
                });
              },
            ),
            SizedBox(height: 12),

            // Quantity Slider
            Text('Quantity: ${quantity.toStringAsFixed(0)}'),
            Slider(
              value: quantity,
              min: 1,
              max: 100,
              divisions: 100,
              label: quantity.round().toString(),
              onChanged: (double value) {
                setState(() {
                  quantity = value;
                });
              },
            ),
            SizedBox(height: 12),

            // Photo Picker (Placeholder)
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add_a_photo),
                  onPressed: () {
                    // Logic for picking a photo
                  },
                ),
                Text('Photo'),
              ],
            ),
            SizedBox(height: 12),

            // Checkbox for Terms
            CheckboxListTile(
              title: Text("I assure that food quality and hygiene has been maintained."),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            SizedBox(height: 20),



