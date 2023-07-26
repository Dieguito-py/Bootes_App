import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatelessWidget {

  const Map({super.key});
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 283,
      child: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(0, -0.99),
            child: Container(
              width: 353,
              height: 260,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(28)),
                boxShadow: [BoxShadow(
                  color: Colors.black26,
                  offset: Offset(2, 4),
                  blurRadius: 6.0,
                  spreadRadius: 2.0,
                )]
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: GoogleMap(
                  markers:  {
                    const Marker(
                      markerId: MarkerId('CubeSat'),
                      position: LatLng(-26.877166022192867, -52.42342188194635)
                      
                    )
                  },
                  mapType: MapType.satellite,
                  zoomControlsEnabled: false,
                  padding: const EdgeInsets.all(2),
                  initialCameraPosition: const CameraPosition(
                    // add variaveis lat e log aqui
                    target: LatLng(-26.877166022192867, -52.42342188194635),
                    zoom: 15.0,
                    
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}