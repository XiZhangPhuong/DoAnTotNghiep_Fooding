import 'package:flutter/material.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';

import 'package:fooding_project/screens/profile/google_map_marker/google_map_marker_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/color_resources.dart';

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
                  : Stack(
                      children: [
                        Positioned(
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                left: IZIDimensions.SPACE_SIZE_2X,
                                top: IZIDimensions.SPACE_SIZE_1X,
                                right: IZIDimensions.SPACE_SIZE_1X,
                                bottom: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              height: IZIDimensions.ONE_UNIT_SIZE * 100,
                              width: IZIDimensions.ONE_UNIT_SIZE * 50,
                              decoration: const BoxDecoration(
                                color: ColorResources.WHITE,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: IZIDimensions.SPACE_SIZE_1X * 1.5,
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: ColorResources.colorTextTabbar,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: controller.markerCustomer!.position,
                              zoom: 14.4746,
                            ),
                            markers: {
                              controller.markerCustomer!,
                              controller.markerStore!,
                              controller.markerShiper!,
                            },
                            myLocationButtonEnabled: false,
                            onMapCreated:
                                (GoogleMapController googleMapController) {
                              controller.ggMapcontroller = googleMapController;
                            },
                          ),
                        )
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
