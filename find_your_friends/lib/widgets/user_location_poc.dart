import 'package:find_your_friends/features/user_location/user_location_repository.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class UserLocationPoc extends StatelessWidget {
  UserLocationPoc({super.key});
  // late final GoogleMapController _controller;
  // bool _added = false;
  final UserLocationRepository _userLocationRepository =
      LocationRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _userLocationRepository.userLocation(),
      builder: (context, AsyncSnapshot<LocationData> snapshot) {
        // if (_added) {
        //   mymap(snapshot);
        // }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return GoogleMap(
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          // gestureRecognizers: Set(),
          // myLocationEnabled: true,

          mapType: MapType.normal,
          markers: {
            Marker(
                position: LatLng(
                  snapshot.data?.latitude ?? 0,
                  snapshot.data?.longitude ?? 0,
                ),
                markerId: const MarkerId('id'),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueMagenta)),
          },
          initialCameraPosition: CameraPosition(
              target: LatLng(
                snapshot.data?.latitude ?? 0,
                snapshot.data?.longitude ?? 0,
              ),
              zoom: 14.47),
          // onMapCreated: (GoogleMapController controller) async {
          //   _controller = controller;
          //   _added = true;
          // },
        );
      },
    );
  }

  // Future<void> mymap(AsyncSnapshot<LocationData> snapshot) async {
  //   await _controller
  //       .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //     target: LatLng(
  //       snapshot.data?.latitude ?? 0,
  //       snapshot.data?.longitude ?? 0,
  //     ),
  //     // zoom: await _controller.getZoomLevel(),
  //     zoom: 14.47,
  //   )));
  // }
}
