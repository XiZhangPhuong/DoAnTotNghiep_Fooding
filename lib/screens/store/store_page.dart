
import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/screens/store/store_controller.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class StorePage extends GetView<StoreController> {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StoreController(),
      builder: (StoreController controller) {
        return 
        Scaffold(
            backgroundColor: ColorResources.BACK_GROUND,
            body: controller.isLoadDingStore==false ? const Center(child: CircularProgressIndicator(),) : 
            Column(
              children: [
                 IZIImage(
                  IZIValidate.nullOrEmpty(controller.storeResponse.avatar) ? '' :
                  controller.storeResponse.avatar!,
                  height: IZIDimensions.ONE_UNIT_SIZE*300,
                 )
              ],
            ),
        );
      },
    );
  }
}