import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  // Marcadores
  final markers = <Marker>{
    Marker(
      markerId: MarkerId('userMarker'),
      infoWindow: InfoWindow(title: 'Plex', snippet: 'Usuario ubicación'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(37.42796133580664, -122.085749655962),
    ),
    Marker(
      markerId: MarkerId('bikeMarker'),
      infoWindow: InfoWindow(title: 'Bike', snippet: 'Bicicleta ubicación'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position: LatLng(37.43296265331129, -122.08832357078792),
    ),
  };

  static const CameraPosition defaultPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        centerTitle: true,
        title: Text("Map", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              return context.pop();
            }
            context.go('/');
          },
          icon: Icon(LineAwesomeIcons.angle_left, size: 30, color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            markers: markers,
            initialCameraPosition: defaultPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: (LatLng latLng) {
              // Aquí puedes implementar funcionalidades al tocar una zona del mapa
            },
          ),
          // Tarjeta deslizante en la parte inferior (opcional)
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Card(
              elevation: 8,
              child: ListTile(
                title: Text("Toca un marcador para más detalles"),
                subtitle: Text("Información del lugar seleccionado"),
                trailing: Icon(LineAwesomeIcons.map_marker),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _gotoDefaultPosition,
        child: Icon(LineAwesomeIcons.compass),
        tooltip: "Centrar en la posición por defecto",
      ),
    );
  }

  Future<void> _gotoDefaultPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(defaultPosition));
  }
}
