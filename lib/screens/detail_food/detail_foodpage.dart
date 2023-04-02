import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/screens/detail_food/detail_foodcontroller.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class DetailFoodPage extends GetView<DetailFoodController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DetailFoodController(),
      builder: (DetailFoodController controller) {
        return Scaffold(
        //  appBar: _appBar(),
          backgroundColor: ColorResources.BACK_GROUND,
          body: Container(
              margin: EdgeInsets.only(bottom: IZIDimensions.ONE_UNIT_SIZE * 50),
              child: Column(
                children: [
                  IZIImage(
                    'https://images.foody.vn/res/g109/1086127/prof/s640x400/foody-upload-api-foody-mobile-sa-786d0887-210713161816.jpeg',
                    height: IZIDimensions.ONE_UNIT_SIZE * 300,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_3X),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Com chien Thu Phuong',
                          style: TextStyle(
                            color: ColorResources.BLACK,
                            fontFamily: 'Nunito',
                            fontSize: IZIDimensions.FONT_SIZE_H4,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            
                          },
                          child: Icon(Icons.favorite,color: 
                          controller.isCheckFavorite==false? ColorResources.BLACK : ColorResources.RED2
                          ,),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }

  ///
  /// appBar
  ///
  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Chi tiết cửa hàng',
        style: TextStyle(
          color: ColorResources.WHITE,
          fontFamily: 'Nunito',
          fontSize: IZIDimensions.FONT_SIZE_H6,
          fontWeight: FontWeight.w700,
        ),
      ),
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            size: IZIDimensions.ONE_UNIT_SIZE * 40,
          )),
    );
  }
}
