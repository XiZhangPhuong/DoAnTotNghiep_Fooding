import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/izi_loading_card.dart';
import 'package:fooding_project/base_widget/p45_appbar.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/screens/feel_rating/feel_rating_cotroller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class FeelRatingPage extends GetView<FeelRatingController> {
  const FeelRatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FeelRatingController(),
      builder: (FeelRatingController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          appBar: const P45AppBarP(title: 'Đánh giá cảm nhận'),
          body: 
          controller.isLoadingOrder==false ? const CardLoadingItem(count: 10,) :
            controller.listOrder.isEmpty ? const DataEmpty() :
          Container(
            padding: EdgeInsets.symmetric(
              vertical: IZIDimensions.ONE_UNIT_SIZE*20
            ),
            child: 
            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.countProduct,
              itemBuilder: (context, index) {
                final itemProduct = controller.listOrder[index].listProduct!;
                return GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                    margin: EdgeInsets.only(
                        top: IZIDimensions.SPACE_SIZE_1X * 0,
                        bottom: IZIDimensions.SPACE_SIZE_2X,
                        left: IZIDimensions.SPACE_SIZE_3X,
                        right: IZIDimensions.SPACE_SIZE_3X),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
                      color: ColorResources.WHITE,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  IZIDimensions.BORDER_RADIUS_3X),
                              child: IZIImage(
                                itemProduct[index].image![0],
                                height: IZIDimensions.ONE_UNIT_SIZE * 120,
                                width: IZIDimensions.ONE_UNIT_SIZE * 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: IZIDimensions.SPACE_SIZE_3X,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                       IZIValidate.nullOrEmpty(itemProduct[index].name) ? '':
                                       itemProduct[index].name!
                                       ,
                                        style: TextStyle(
                                          color: ColorResources.BLACK,
                                          fontFamily: NUNITO,
                                          fontWeight: FontWeight.w600,
                                          fontSize: IZIDimensions.FONT_SIZE_H5,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 0.5,color: ColorResources.colorMain)
                                          ),
                                          child:  Text(
                                   'Đánh giá',
                                    style: TextStyle(
                                      color: ColorResources.colorMain,
                                      fontFamily: NUNITO,
                                      fontWeight: FontWeight.w600,
                                      fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                                    ),
                                  ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                   'x${itemProduct[index].quantity}',
                                    style: TextStyle(
                                      color: ColorResources.GREY,
                                      fontFamily: NUNITO,
                                      fontWeight: FontWeight.w600,
                                      fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                                    ),
                                  ),
                                  Text(
                                   itemProduct[index].priceDiscount==0? 
                                   '${IZIPrice.currencyConverterVND(itemProduct[index].price!.toDouble())} vnđ' :

                                     '${IZIPrice.currencyConverterVND(itemProduct[index].priceDiscount!.toDouble())} vnđ',
                                    style: TextStyle(
                                      color: ColorResources.colorMain,
                                      fontFamily: NUNITO,
                                      fontWeight: FontWeight.w600,
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
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
                );
              },
            ),
          ),
        );
      },
    );
  }
}
