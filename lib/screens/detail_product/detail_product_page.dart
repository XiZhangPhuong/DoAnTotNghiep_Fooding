
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fooding_project/screens/detail_product/detail_product_controller.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class DetailProductPage extends GetView {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DetailProductController(),
      builder:  (DetailProductController controller) {
         return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          appBar: AppBar(
            title: Text(''),
          ),
          body: Container(

          ),
         );
      },
    );
  }
}