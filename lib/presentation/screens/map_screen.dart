import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();
  final _kGooglePlex = const CameraPosition(
    target: LatLng(0, 0),
  );

  static final Marker userMarker = Marker(
    markerId: MarkerId('userMaker'),
    infoWindow: InfoWindow(title: 'Plex'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(37.42796133580664, -122.085749655962),
  );

  static final Marker bikeMarker = Marker(
    markerId: const MarkerId('bikeMarker'),
    infoWindow: const InfoWindow(title: 'Bike'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position:const LatLng(37.43296265331129, -122.08832357078792),
  );

  static const CameraPosition defaultPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Map"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: {userMarker, bikeMarker},
        initialCameraPosition: defaultPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.go('/login');
        },
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),*/
    );
  }

  /*Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/
}
