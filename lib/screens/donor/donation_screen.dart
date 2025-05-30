import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'doner_home_page.dart';
import 'donar_notification_screen.dart';
import 'donar_profile_screen.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  int _currentIndex = 1;

  final TextEditingController _foodItemController = TextEditingController();
  final TextEditingController _foodDescriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  double quantity = 10;
  bool isChecked = false;
  double pickupTimeSliderValue = 12.0;
  String location = "Fetching location...";
  late GoogleMapController mapController;
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      location = "Lat: ${position.latitude}, Lon: ${position.longitude}";
      _locationController.text = location;
    });
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      _currentLocation = position;
      _locationController.text = "Lat: ${position.latitude}, Lon: ${position.longitude}";
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  String getFormattedTime(double sliderValue) {
    int hours = sliderValue.toInt();
    int minutes = ((sliderValue - hours) * 60).toInt();
    String period = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    hours = hours == 0 ? 12 : hours;
    return '$hours:${minutes.toString().padLeft(2, '0')} $period';
  }

  void _submitDonation() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Success'),
        content: Text('Your food donation has been submitted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;

    setState(() => _currentIndex = index);

    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DonerHomePage()));
        break;
      case 1:
        // Stay on DonationPage
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => NotificationScreen()));
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DonorProfileScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate Food'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _foodItemController,
              decoration: InputDecoration(labelText: 'Food Item'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _foodDescriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 12),
            Text('Select Quantity (kg): ${quantity.toInt()}'),
            Slider(
              value: quantity,
              min: 1,
              max: 100,
              divisions: 99,
              label: quantity.toInt().toString(),
              onChanged: (value) => setState(() => quantity = value),
            ),
            SizedBox(height: 12),
            Text('Pickup Time: ${getFormattedTime(pickupTimeSliderValue)}'),
            Slider(
              value: pickupTimeSliderValue,
              min: 0,
              max: 23,
              divisions: 23,
              label: getFormattedTime(pickupTimeSliderValue),
              onChanged: (value) => setState(() => pickupTimeSliderValue = value),
            ),
            SizedBox(height: 12),
            Text('Pickup Date: ${selectedDate.toLocal().toString().split(' ')[0]}'),
            TextButton(
              onPressed: () => _selectDate(context),
              child: Text('Choose Date'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _locationController,
              readOnly: true,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: _currentLocation == null
                  ? Center(child: CircularProgressIndicator())
                  : GoogleMap(
                      onMapCreated: (controller) => mapController = controller,
                      initialCameraPosition: CameraPosition(
                        target: _currentLocation!,
                        zoom: 14,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId('currentLocation'),
                          position: _currentLocation!,
                          draggable: true,
                          onDragEnd: (pos) => _onMapTapped(pos),
                        ),
                      },
                      onTap: _onMapTapped,
                    ),
            ),
            SizedBox(height: 16),
            CheckboxListTile(
              title: Text('I confirm the food is safe for donation.'),
              value: isChecked,
              onChanged: (value) => setState(() => isChecked = value ?? false),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: isChecked ? _submitDonation : null,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Submit Donation'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.volunteer_activism), label: 'Donate'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notify'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
