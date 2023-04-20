import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_tabbar.dart';
import 'package:fooding_project/screens/profile/status_order/status_order_controller.dart';
import 'package:fooding_project/screens/widgets/app_bar.dart';
import 'package:get/get.dart';

import '../../../utils/color_resources.dart';

class StatusOrderPage extends GetView {
  const StatusOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFooding(
        title: "Trạng thái đơn hàng",
      ),
      body: GetBuilder(
        init: StatusOrderController(),
        builder: (controller) => SingleChildScrollView(
          child: Column(
            children: [
              IZITabBar(
                currentIndex: controller.choiceItem,
                colorUnderLine: const Color(0xffF8775C),
                items: controller.timeList1,
                onTapChangedTabbar: (val) {
                  controller.onChoiceItem(val);
                },
                colorText: const Color(0xffF8775C),
                disbleColorText: ColorResources.BLACK,
              ),
              Text("Test 1"),
            ],
          ),
        ),
      ),
    );
  }
}
