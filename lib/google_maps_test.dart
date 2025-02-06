import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleMapWidget extends StatefulWidget {
  final double latitude;
  final double longitude;
  const GoogleMapWidget(
      {super.key, required this.latitude, required this.longitude});

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("this places location"),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.latitude, widget.longitude),
            zoom: 14.0,
          ),
          markers: {
            Marker(
              markerId: MarkerId('landmark'),
              position: LatLng(widget.latitude, widget.longitude),
              infoWindow: InfoWindow(title: 'Landmark'),
              onTap: () async {
                final url =
                    'https://www.google.com/maps/dir/?api=1&destination=${widget.latitude},${widget.longitude}';
                // Handle map click: open the URL in the browser
                if (await canLaunchUrl(url as Uri)) {
                  await launchUrl(url as Uri);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
          },
        ));
  }
}
