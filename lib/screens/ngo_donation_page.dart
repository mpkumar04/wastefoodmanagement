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

