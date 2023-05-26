import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fooding_project/base_widget/p45_appbar.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/screens/SHIPPER/chart_shipper/chart_shipper_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class ChartShipperPage extends GetView<ChartShipperController> {
  const ChartShipperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ChartShipperController(),
      builder: (ChartShipperController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          appBar: const P45AppBarP(title: 'Thống kê chi tiết'),
          body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_3X,
              vertical: IZIDimensions.SPACE_SIZE_3X,
            ),
            child: Container(
              height: IZIDimensions.ONE_UNIT_SIZE*50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${controller.listComment.length} đánh giá | ${controller.average}',
                    style: TextStyle(
                      color: ColorResources.BLACK,
                      fontWeight: FontWeight.w600,
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontFamily: NUNITO,
                    ),
                  ),
                  SizedBox(width: IZIDimensions.SPACE_SIZE_2X,),
                  RatingStars(
                    maxValue: 1,
                    value: 1,
                    starCount: 1,
                    starSize: IZIDimensions.ONE_UNIT_SIZE * 30,
                    starColor: Colors.yellow,
                    maxValueVisibility: false,
                    valueLabelVisibility: false,
                    onValueChanged: (value) {},
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {

                      controller.showDialogEvaluate();
                    },
                    child: Text(
                      'Xem đánh giá',
                      style: TextStyle(
                        color: ColorResources.colorMain,
                        fontWeight: FontWeight.w600,
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        fontFamily: NUNITO,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
