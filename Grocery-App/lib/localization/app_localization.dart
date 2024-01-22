import 'package:get/get.dart';
import 'en_us/en_us_translations.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Islamabad and Peshawar Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GoogleMapController mapController;
  late Location location;
  LatLng islamabadLatLng = LatLng(33.6844, 73.0479); // Islamabad coordinates
  LatLng peshawarLatLng = LatLng(33.6844, 71.5430);   // Peshawar coordinates

  @override
  void initState() {
    super.initState();
    location = Location();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Islamabad and Peshawar Maps'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: islamabadLatLng,
              zoom: 12.0,
            ),
            markers: {
              Marker(
                markerId: MarkerId('Islamabad'),
                position: islamabadLatLng,
                infoWindow: InfoWindow(title: 'Islamabad'),
              ),
              Marker(
                markerId: MarkerId('Peshawar'),
                position: peshawarLatLng,
                infoWindow: InfoWindow(title: 'Peshawar'),
              ),
            },
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: ElevatedButton(
              onPressed: () async {
                LocationData currentLocation = await location.getLocation();
                mapController.animateCamera(
                  CameraUpdate.newLatLng(LatLng(
                    currentLocation.latitude!,
                    currentLocation.longitude!,
                  )),
                );
              },
              child: Text('My Location'),
            ),
          ),
        ],
      ),
    );
  }
}
