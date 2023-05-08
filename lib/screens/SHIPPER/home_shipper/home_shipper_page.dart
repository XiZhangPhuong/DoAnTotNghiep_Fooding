import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/izi_loading_card.dart';
import 'package:fooding_project/base_widget/p45_appbar.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/screens/SHIPPER/home_shipper/home_shipper_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class HomeShipperPage extends GetView<HomeShipperController> {
  const HomeShipperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeShipperController(),
      builder: (HomeShipperController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          floatingActionButton: _checkOline(controller),
          appBar: controller.isLoadingOrder == false
              ? const P45AppBarP(
                  title: 'Đơn hàng mới',
                  isShowLeadingIcon: false,
                )
              : null,
          body: controller.isLoadingOrder == false
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                         
                    ],
                  ),
                ),
        );
      },
    );
  }
}

///
/// listview product
///
Widget _listviewProducts(HomeShipperController controller) {
  return controller.isLoadingOrder == false
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: controller.orderResponse!.listProduct!.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(IZIDimensions.SPACE_SIZE_3X),
                    child: IZIImage(
                      controller
                          .orderResponse!.listProduct![index].image!.first,
                      height: IZIDimensions.ONE_UNIT_SIZE * 150,
                      width: IZIDimensions.ONE_UNIT_SIZE * 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.orderResponse!.listProduct![index].name!,
                        style: TextStyle(
                          color: ColorResources.BLACK,
                          fontFamily: NUNITO,
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_H5,
                        ),
                      ),
                      Text(
                        controller
                            .orderResponse!.listProduct![index].nameCategory!,
                        style: TextStyle(
                          color: ColorResources.GREY,
                          fontFamily: NUNITO,
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            );
          },
        );
}

///
/// floatitng button check oline
///
Widget _checkOline(HomeShipperController controller) {
  return GestureDetector(
    onTap: () {
      controller.clickTickOline();
    },
    child: Container(
      height: IZIDimensions.ONE_UNIT_SIZE * 200,
      width: IZIDimensions.ONE_UNIT_SIZE * 200,
      padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: controller.isCheckOline ? ColorResources.colorMain : null,
      ),
      child: Center(
          child: Icon(
        Icons.power_settings_new,
        size: IZIDimensions.ONE_UNIT_SIZE * 150,
        color: controller.isCheckOline
            ? ColorResources.WHITE
            : ColorResources.BLACK,
      )),
    ),
  );
}
