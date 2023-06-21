import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(33.5836,-7.6425);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  Set<Marker> _createMarker(){
    return<Marker>[
      Marker(
          markerId: MarkerId('home'),
          position:LatLng(33.5836,-7.6425),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'Current Location')
      )
    ].toSet();
  }
  Set<Circle> _circles = Set.from([Circle(
      circleId: CircleId('Infection'),
      center: LatLng(33.5836,-7.6425),
      radius: 450,
      fillColor: Colors.pinkAccent.withAlpha(70),
      strokeColor: Colors.pinkAccent
  )]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'),
          actions: [
            ElevatedButton.icon(
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.exit_to_app),
                label: Text('signOut'))
          ]),
      body: GoogleMap(
        markers: _createMarker(),circles: _circles,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0,
        ),
      ),
    );
  }
}