import 'package:find_your_friends/features/group_location/bloc/group_location_bloc.dart';
import 'package:find_your_friends/features/group_location/group_location_repository.dart';
import 'package:find_your_friends/pages/standard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/group_location.dart';
import '../utils/constants.dart';

class GroupDetailView extends StatelessWidget {
  GroupDetailView({super.key});

  final GroupLocationRepository _groupLocationRepository =
      GroupLocationRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return StandardPage(
        widget: BlocConsumer<GroupLocationBloc, GroupLocationState>(
          builder: (context, state) {
            return StreamBuilder(
                stream: _groupLocationRepository.listenToGroupLocation(
                    context.read<GroupLocationBloc>().state.groupId),
                builder:
                    (context, AsyncSnapshot<List<GroupLocation>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data!.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return GoogleMap(
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    mapType: MapType.normal,
                    markers: {
                      ...snapshot.data!.map((e) {
                        return Marker(
                            markerId: MarkerId(e.userName!),
                            position: LatLng(e.userLocation!.latitude!,
                                e.userLocation!.longitude!),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueMagenta));
                      })
                    },
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                          snapshot.data?.first.userLocation?.latitude ?? 0,
                          snapshot.data?.first.userLocation?.longitude ?? 0,
                        ),
                        zoom: 14.47),
                  );
                });
          },
          listener: (context, state) {
            if (state is GroupLocationErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(Constants.textFixIssues)));
            }
          },
        ),
        title: 'Group Detail View');
  }
}
