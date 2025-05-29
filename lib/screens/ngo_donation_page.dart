import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class NgoDonationPage extends StatefulWidget {
  const NgoDonationPage({super.key});

  @override
  State<NgoDonationPage> createState() => _NgoDonationPageState();
}
late GoogleMapController mapController;
final LatLng _center = const LatLng(6.9271, 79.8612); // Example: Colombo, Sri Lanka

void _onMapCreated(GoogleMapController controller) {
  mapController = controller;
}
Container(
  height: 120,
  decoration: const BoxDecoration(
    color: Color(0xFFE53935),
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ),
  ),
  child: SafeArea(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          'Map',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ),
),
Expanded(
  child: GoogleMap(
    onMapCreated: _onMapCreated,
    initialCameraPosition: CameraPosition(
      target: _center,
      zoom: 13.0,
    ),
    myLocationEnabled: true,
    myLocationButtonEnabled: true,
    zoomControlsEnabled: false,
  ),
),
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 5,
        offset: Offset(0, -2),
      ),
    ],
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Nearby Donors",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
TextField(
  decoration: InputDecoration(
    hintText: "Colombo",
    prefixIcon: Icon(Icons.location_on),
    suffixIcon: Icon(Icons.filter_list),
    filled: true,
    fillColor: Colors.grey[200],
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
),
TextField(
  decoration: InputDecoration(
    hintText: "Pickup Instruction?",
    prefixIcon: Icon(Icons.notes),
    filled: true,
    fillColor: Colors.grey[200],
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
),
SizedBox(
  width: double.infinity,
  height: 50,
  child: ElevatedButton(
    onPressed: () {
      // Handle direction click
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFE53935),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: const Text(
      'Direction',
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  ),
),

