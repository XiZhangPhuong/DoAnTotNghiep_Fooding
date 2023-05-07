import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/p45_appbar.dart';
import 'package:fooding_project/base_widget/p45_button.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/screens/evaluate/evaluate_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class EvaluatePage extends GetView<EvaluateController> {
  const EvaluatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: EvaluateController(),
      builder: (EvaluateController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          appBar: const P45AppBarP(title: 'Đánh giá sản phẩm'),
          floatingActionButton: P45Button(
            title: 'Gửi đánh giá',
            onPressed: () {},
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Container(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
                color: ColorResources.WHITE,
                padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              IZIDimensions.SPACE_SIZE_2X),
                          child: IZIImage(
                            'https://cdn.tgdd.vn/2022/07/CookRecipe/Avatar/mi-xao-hai-san-thumbnail.jpg',
                            height: IZIDimensions.ONE_UNIT_SIZE * 150,
                            width: IZIDimensions.ONE_UNIT_SIZE * 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: IZIDimensions.SPACE_SIZE_3X,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mì sào hải sản',
                                style: TextStyle(
                                  color: ColorResources.BLACK,
                                  fontFamily: NUNITO,
                                  fontWeight: FontWeight.w600,
                                  fontSize: IZIDimensions.FONT_SIZE_H5,
                                ),
                              ),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              Text(
                                'Mì',
                                style: TextStyle(
                                  color: ColorResources.GREY,
                                  fontFamily: NUNITO,
                                  fontWeight: FontWeight.w600,
                                  fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                                ),
                              ),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              Text(
                                '12.000 vnđ',
                                style: TextStyle(
                                  color: ColorResources.colorMain,
                                  fontFamily: NUNITO,
                                  fontWeight: FontWeight.w600,
                                  fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_3X,
              ),
              // evaluate
              Expanded(
                child: Container(
                  height: IZIDimensions.iziSize.height,
                  width: IZIDimensions.iziSize.width,
                  padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
                  color: ColorResources.WHITE,
                  child: Column(
                    children: [
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      RatingStars(
                        value: 4.5,
                        starCount: 5,
                        starSpacing: 4,
                        starSize: IZIDimensions.ONE_UNIT_SIZE * 50,
                        starColor: Colors.yellow,
                        valueLabelVisibility: false,
                        onValueChanged: (value) {
                          print(value);
                        },
                      ),
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_3X,
                      ),
                      //

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.thumb_up,
                                color: Colors.blue,
                                size: IZIDimensions.ONE_UNIT_SIZE * 45,
                              ),
                              Text(
                                'Hài lòng',
                                maxLines: 1,
                                style: TextStyle(
                                  color: ColorResources.GREY,
                                  fontFamily: NUNITO,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.thumb_down,
                                color: Colors.grey,
                                size: IZIDimensions.ONE_UNIT_SIZE * 45,
                              ),
                              Text(
                                'Không hài lòng',
                                maxLines: 1,
                                style: TextStyle(
                                  color: ColorResources.GREY,
                                  fontFamily: NUNITO,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                      //
                      ,
                      _textFiled(controller),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin:
                            EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_2X),
                        padding:
                            EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_2X),
                        child: Row(
                          children: [
                            Container(
                              height: IZIDimensions.ONE_UNIT_SIZE * 180,
                              width: IZIDimensions.ONE_UNIT_SIZE * 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    IZIDimensions.SPACE_SIZE_3X),
                                color: ColorResources.GREY.withOpacity(0.1),
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.add_a_photo,
                                size: IZIDimensions.ONE_UNIT_SIZE * 50,
                                color: ColorResources.GREY,
                              )),
                            ),
                            SizedBox(
                              width: IZIDimensions.SPACE_SIZE_3X,
                            ),
                            Container(
                              height: IZIDimensions.ONE_UNIT_SIZE * 180,
                              width: IZIDimensions.ONE_UNIT_SIZE * 180,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorResources.GREY.withOpacity(0.5),
                                  width: 1,
                                  style: BorderStyle.solid
                                ),
                                borderRadius: BorderRadius.circular(
                                    IZIDimensions.SPACE_SIZE_3X),
                          
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_4X,
                      ),
                      const Divider(),
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      Text(
                        'Chia sẻ cảm nhận, đánh giá để cửa hàng chúng tôi ngày càng hoàn thiện hơn. \nRất cảm ơn quý khách hàng đã lựa chọn cửa hàng chúng tôi trong hàng ngàn cửa hàng ngoài kia',
                        maxLines: 2,
                        style: TextStyle(
                          color: ColorResources.GREY,
                          fontFamily: NUNITO,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        );
      },
    );
  }
}

///
/// text field evaluat
///

Container _textFiled(EvaluateController controller) {
  return Container(
    color: ColorResources.WHITE,
    padding: EdgeInsets.symmetric(
      vertical: IZIDimensions.SPACE_SIZE_4X,
      horizontal: IZIDimensions.SPACE_SIZE_3X,
    ),
    child: TextField(
      keyboardType: TextInputType.multiline,
      onChanged: (val) {},
      decoration: InputDecoration(
        hintText: 'Đánh giá của bạn',
        hintStyle: TextStyle(color: ColorResources.GREY.withOpacity(1)),
        contentPadding: EdgeInsets.symmetric(
            vertical: IZIDimensions.ONE_UNIT_SIZE * 50,
            horizontal: IZIDimensions.ONE_UNIT_SIZE * 50),
        fillColor: ColorResources.GREY.withOpacity(0.1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_5X),
        ),
      ),
    ),
  );
}