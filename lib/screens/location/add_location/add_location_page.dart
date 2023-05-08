import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_input.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/screens/home/home_controller.dart';
import 'package:fooding_project/screens/location/add_location/add_location_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import '../../../helper/izi_dimensions.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/color_resources.dart';

class AddLocationPage extends StatelessWidget {
  const AddLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorResources.colorMain,
        elevation: 0,
        title: Text(
          "Thêm địa chỉ",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: IZIDimensions.FONT_SIZE_SPAN * 1.2,
          ),
        ),
        leading: GestureDetector(
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
        actions: [
          GetBuilder(
            init: AddLocationController(),
            builder: (AddLocationController controller) => GestureDetector(
              onTap: () {
                controller.addLocation();
              },
              child: Center(
                child: Text(
                  "Lưu",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_5X,
          ),
        ],
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(IZIDimensions.ONE_UNIT_SIZE * 5),
          child: Container(),
        ),
      ),
      body: GetBuilder(
        init: AddLocationController(),
        builder: (controller) => Column(
          children: [
            Padding(
              padding: EdgeInsets.all(
                IZIDimensions.SPACE_SIZE_1X,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  IZIInput(
                    type: IZIInputType.TEXT,
                    borderRadius: IZIDimensions.SPACE_SIZE_2X,
                    textInputAction: TextInputAction.next,
                    placeHolder: 'Nhập tên của bạn',
                    controller: controller.nameEditingController,
                    hintStyle: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                    ),
                  ),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  IZIInput(
                    textInputAction: TextInputAction.next,
                    type: IZIInputType.PHONE,
                    borderRadius: IZIDimensions.SPACE_SIZE_2X,
                    controller: controller.phoneEditingController,
                    placeHolder: 'Nhập số điện thoại',
                    hintStyle: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                    ),
                  ),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  IZIInput(
                    isReadOnly: true,
                    type: IZIInputType.TEXT,
                    borderRadius: IZIDimensions.SPACE_SIZE_2X,
                    textInputAction: TextInputAction.next,
                    controller: controller.addressEditingController,
                    placeHolder: 'Chọn địa chỉ',
                    hintStyle: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PlacePicker(
                apiKey: APIGG,
                region: 'VN',
                onPlacePicked: (result) async {
                  if (!IZIValidate.nullOrEmpty(result.formattedAddress) &&
                      !IZIValidate.nullOrEmpty(result.geometry)) {
                    controller.addressEditingController.text =
                        result.formattedAddress!;
                    controller.latLong =
                        "${result.geometry!.location.lat};${result.geometry!.location.lng}";
                  }
                },
                initialPosition: IZIValidate.nullOrEmpty(currentLocation)
                    ? const LatLng(16.0746543, 108.2202951)
                    : LatLng(
                        currentLocation!.latitude, currentLocation!.longitude),
                resizeToAvoidBottomInset:
                    true, // only works in page mode, less flickery, remove if wrong offsets
              ),
            ),
          ],
        ),
      ),
    );
  }
}
