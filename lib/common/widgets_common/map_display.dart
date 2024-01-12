import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';

class MapDisplay extends StatefulWidget {
  final double lat;
  final double lng;
  final String title;
  const MapDisplay({Key? key, required this.lat, required this.lng, required this.title}) : super(key: key);

  @override
  State<MapDisplay> createState() => _MapDisplayState();
}

class _MapDisplayState extends State<MapDisplay> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      // borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      child: GoogleMap(
          liteModeEnabled: Platform.isAndroid, //Using light mode on android, ios does not support light mode
          onTap: (latLng) async{
            final availableMaps = await MapLauncher.installedMaps;
            await availableMaps.first.showMarker(coords: Coords(widget.lat, widget.lng), title: widget.title);
            // Navigator.push(context, MaterialPageRoute(builder: (context) => MapFullDisplay(lat: widget.lat, lng: widget.lng, title: widget.title)));
          },
          markers: Set<Marker>.of({
            const MarkerId('1'): Marker(
                markerId: const MarkerId('1'),
                position: LatLng(widget.lat, widget.lng),
              infoWindow: InfoWindow(title: widget.title)
            )}.values),
          initialCameraPosition: CameraPosition(
        target: LatLng(widget.lat, widget.lng),
        zoom: 16
      )),
    );
  }
}

//
// class MapFullDisplay extends StatefulWidget {
//   final double lat;
//   final double lng;
//   final String title;
//   const MapFullDisplay({Key? key, required this.lat, required this.lng, required this.title}) : super(key: key);
//
//   @override
//   State<MapFullDisplay> createState() => _MapFullDisplayState();
// }
//
// class _MapFullDisplayState extends State<MapFullDisplay> {
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
//       child: GoogleMap(
//           markers: Set<Marker>.of({
//             const MarkerId('1'): Marker(
//                 markerId: const MarkerId('1'),
//                 position: LatLng(widget.lat, widget.lng),
//                 infoWindow: InfoWindow(title: widget.title)
//             )}.values),
//           initialCameraPosition: CameraPosition(
//               target: LatLng(widget.lat, widget.lng),
//               zoom: 16
//           )),
//     );
//   }
// }