import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'ngo_home_screen.dart';
import 'ngo_notification_page.dart';
import 'ngo_profile_page.dart'; // ✅ Added this line

class NgoDonationPage extends StatefulWidget {
  const NgoDonationPage({super.key});

  @override
  _NgoDonationPageState createState() => _NgoDonationPageState();
}

class _NgoDonationPageState extends State<NgoDonationPage> {
  GoogleMapController? _mapController;
  final Location _location = Location();

  LatLng _initialPosition = const LatLng(6.9271, 79.8612); // Default: Colombo

  final TextEditingController _locationController =
      TextEditingController(text: "Colombo");
  final TextEditingController _instructionController =
      TextEditingController();

  int _selectedIndex = 1; // Map is the default selected tab

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
        locationData.latitude ?? 6.9271,
        locationData.longitude ?? 79.8612,
      );
    });

    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(_initialPosition));
    }
  }

  Set<Marker> _donorMarkers() {
    return {
      const Marker(
        markerId: MarkerId('donor1'),
        position: LatLng(6.9271, 79.8612),
        infoWindow: InfoWindow(title: 'Donor 1'),
      ),
      const Marker(
        markerId: MarkerId('donor2'),
        position: LatLng(6.9285, 79.8600),
        infoWindow: InfoWindow(title: 'Donor 2'),
      ),
    };
  }

  void _onNavBarTapped(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NgoHomeScreen()),
        );
        break;
      case 1:
        // Already on Map screen
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NgoNotificationPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NgoProfilePage()),
        );
        break;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(color: Colors.white),
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
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const Text('Nearby Donors',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      hintText: 'Enter location',
                      prefixIcon: const Icon(Icons.location_on_outlined),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _instructionController,
                    decoration: InputDecoration(
                      hintText: 'Pickup Instruction?',
                      prefixIcon: const Icon(Icons.info_outline),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Direction pressed')),
                      );
                    },
                    child: const Text(
                      'Direction',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavBarTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.map_outlined, color: Colors.red),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '',
          ),
        ],
      ),
    );
  }
}
