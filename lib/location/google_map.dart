import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatelessWidget {

final double lat;
final double long;

MapSample(this.lat, this.long);
 final Completer<GoogleMapController> _controller = Completer();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(lat, long),
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),

    );
  }


}