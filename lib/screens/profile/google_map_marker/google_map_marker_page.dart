import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';

import 'package:fooding_project/screens/profile/google_map_marker/google_map_marker_controller.dart';
import 'package:fooding_project/utils/images_path.dart';
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
                        ),
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
                        Positioned(
                          bottom: 50,
                          left: 20,
                          right: 20,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (index == 0) {
                                        controller.ggMapcontroller!.moveCamera(
                                            CameraUpdate.newLatLng(controller
                                                .markerCustomer!.position));
                                      } else if (index == 1) {
                                        controller.ggMapcontroller!.moveCamera(
                                            CameraUpdate.newLatLng(controller
                                                .markerStore!.position));
                                      } else if (index == 2) {
                                        controller.ggMapcontroller!.moveCamera(
                                            CameraUpdate.newLatLng(controller
                                                .markerShiper!.position));
                                      }
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      margin: EdgeInsets.only(right: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IZIImage(
                                            index == 0
                                                ? ImagesPath.user_googleMap
                                                : index == 1
                                                    ? ImagesPath.store_googlemap
                                                    : ImagesPath
                                                        .delivery_gggolemap,
                                            width: 60,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            index == 0
                                                ? "Bạn"
                                                : index == 1
                                                    ? "Cửa hàng"
                                                    : "Người giao hàng",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )),
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
