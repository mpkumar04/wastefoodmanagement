import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class NgoDonationPage extends StatefulWidget {
  const NgoDonationPage({super.key});

  @override
  _NgoDonationPageState createState() => _NgoDonationPageState();
}

class _NgoDonationPageState extends State<NgoDonationPage> {
  GoogleMapController? _mapController;
  final Location _location = Location();

  LatLng _initialPosition = LatLng(6.9271, 79.8612); // Default: Colombo

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  void _determinePosition() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) serviceEnabled = await _location.requestService();

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
    }
    if (permissionGranted != PermissionStatus.granted) return;

    LocationData locationData = await _location.getLocation();

    setState(() {
      _initialPosition = LatLng(
          locationData.latitude ?? 6.9271, locationData.longitude ?? 79.8612);
    });

    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(_initialPosition));
    }
  }

  Set<Marker> _donorMarkers() {
    // Sample donor locations (replace with Firebase data later)
    return {
      Marker(
          markerId: MarkerId('donor1'),
          position: LatLng(6.9271, 79.8612),
          infoWindow: InfoWindow(title: 'Donor 1')),
      Marker(
          markerId: MarkerId('donor2'),
          position: LatLng(6.9285, 79.8600),
          infoWindow: InfoWindow(title: 'Donor 2')),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        backgroundColor: Colors.red,
        leading: BackButton(),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 14,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: _donorMarkers(),
              onMapCreated: (controller) => _mapController = controller,
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Text('Nearby Donors',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'Colombo',
                      prefixIcon: Icon(Icons.location_on_outlined),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'Pickup Instruction?',
                      prefixIcon: Icon(Icons.info_outline),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      // TODO: Implement directions or pickup logic
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Direction pressed')));
                    },
                    child: Text('Direction'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}