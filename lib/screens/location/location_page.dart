import 'package:flutter/material.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/screens/components/button_app.dart';
import 'package:fooding_project/screens/location/location_controller.dart';
import 'package:fooding_project/screens/widgets/app_bar.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class LocationPage extends GetView {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND,
      appBar: AppBarFooding(
        title: "Địa chỉ nhận hàng",
      ),
      body: GetBuilder(
        init: LocationController(),
        builder: (LocationController controller) {
          return controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IZIValidate.nullOrEmpty(controller.user.idLocation)
                          ? const SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: IZIDimensions.SPACE_SIZE_3X,
                                    vertical: IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                  child: Text(
                                    "Địa chỉ mặc định",
                                    style: TextStyle(
                                      color: ColorResources.GREY,
                                      fontWeight: FontWeight.w500,
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: IZIDimensions.SPACE_SIZE_2X,
                                ),
                                Container(
                                  color: ColorResources.WHITE,
                                  padding: EdgeInsets.all(
                                    IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                  child: _itemProfile(controller),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_3X,
                          vertical: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Text(
                          "Địa chỉ đã lưu",
                          style: TextStyle(
                            color: ColorResources.GREY,
                            fontWeight: FontWeight.w500,
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                          ),
                        ),
                      ),
                      Container(
                        width: IZIDimensions.iziSize.width,
                        color: ColorResources.WHITE,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.locations.length,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                controller
                                    .chooseAddress(controller.locations[index]);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(
                                  IZIDimensions.SPACE_SIZE_2X,
                                ),
                                child: Column(
                                  children: [
                                    _itemLocation(controller, index),
                                    SizedBox(
                                      height: IZIDimensions.SPACE_SIZE_1X,
                                    ),
                                    if (index !=
                                        controller.locations.length - 1)
                                      Divider(
                                        height: 1,
                                        color: ColorResources.GREY
                                            .withOpacity(0.5),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: IZIDimensions.iziSize.height * 0.08,
                      )
                    ],
                  ),
                );
        },
      ),
      bottomSheet: MediaQuery.of(context).viewInsets.bottom > 0
          ? const SizedBox()
          : GetBuilder(
              builder: (LocationController controller) => controller.isLoading
                  ? const SizedBox()
                  : Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(
                        bottom: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      width: IZIDimensions.iziSize.width,
                      height: IZIDimensions.ONE_UNIT_SIZE * 90,
                      child: Center(
                        child: ButtonFooding(
                          text: "Thêm địa chỉ",
                          ontap: () {
                            controller.changeAddLocationPage();
                          },
                          border: IZIDimensions.BORDER_RADIUS_4X,
                        ),
                      ),
                    ),
            ),
    );
  }

  Widget _itemLocation(LocationController controller, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.location_on,
          color: ColorResources.colorMain,
        ),
        SizedBox(
          width: IZIDimensions.SPACE_SIZE_2X,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.locations[index].address ?? "Không xác định",
                maxLines: 2,
                style: TextStyle(
                  height: 1.5,
                  fontFamily: NUNITO,
                  color: ColorResources.BLACK,
                  fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                controller.locations[index].name ?? "Không xác định",
                maxLines: 1,
                style: TextStyle(
                    height: 1.5,
                    fontFamily: NUNITO,
                    color: ColorResources.LIGHT_GREY,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis),
              ),
              Text(
                controller.locations[index].phone ?? "Không xác định",
                maxLines: 1,
                style: TextStyle(
                    height: 1.5,
                    fontFamily: NUNITO,
                    color: ColorResources.LIGHT_GREY,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
        SizedBox(
          width: IZIDimensions.SPACE_SIZE_2X,
        ),
        GestureDetector(
          onTap: () {
            controller.changeEditLocationPage(index);
          },
          child: Text(
            "Sửa",
            style: TextStyle(
              color: Colors.blue[400],
            ),
          ),
        )
      ],
    );
  }

  Widget _itemProfile(LocationController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.location_on,
          color: ColorResources.colorMain,
        ),
        SizedBox(
          width: IZIDimensions.SPACE_SIZE_2X,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.defaultLocation.address ?? "Không xác định",
                maxLines: 2,
                style: TextStyle(
                  height: 1.5,
                  fontFamily: NUNITO,
                  color: ColorResources.BLACK,
                  fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                controller.defaultLocation.name ?? "Không xác định",
                maxLines: 1,
                style: TextStyle(
                    height: 1.5,
                    fontFamily: NUNITO,
                    color: ColorResources.LIGHT_GREY,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis),
              ),
              Text(
                controller.defaultLocation.phone ?? "Không xác định",
                maxLines: 1,
                style: TextStyle(
                    height: 1.5,
                    fontFamily: NUNITO,
                    color: ColorResources.LIGHT_GREY,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
