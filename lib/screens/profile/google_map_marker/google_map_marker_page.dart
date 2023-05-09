import 'package:flutter/material.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';

import 'package:fooding_project/screens/profile/google_map_marker/google_map_marker_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapMarkerPage extends GetView {
  const GoogleMapMarkerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder(
          init: GoogleMapMarkerController(),
          builder: (GoogleMapMarkerController controller) {
            return SizedBox(
              height: IZIDimensions.iziSize.height,
              width: IZIDimensions.iziSize.width,
              child: controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: controller.markerCustomer!.position,
                        zoom: 14.4746,
                      ),
                      markers: {
                        controller.markerCustomer!,
                        controller.markerStore!
                      },
                      myLocationButtonEnabled: false,
                      onMapCreated: (GoogleMapController googleMapController) {
                        controller.ggMapcontroller = googleMapController;
                      },
                    ),
            );
          },
        ),
      ),
    );
  }
}
