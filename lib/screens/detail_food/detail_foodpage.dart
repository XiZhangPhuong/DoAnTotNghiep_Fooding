import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/screens/detail_food/detail_foodcontroller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class DetailFoodPage extends GetView<DetailFoodController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DetailFoodController(),
      builder: (DetailFoodController controller) {
        return Scaffold(
          bottomSheet: Container(
            height: IZIDimensions.ONE_UNIT_SIZE * 80,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
              color: ColorResources.colorMain,
            ),
            child: Center(
              child: Text(
                'Thêm giỏ hàng',
                style: TextStyle(
                  color: ColorResources.WHITE,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w600,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                ),
              ),
            ),
          ),
          backgroundColor: ColorResources.BACK_GROUND,
          body: Container(
              margin: EdgeInsets.only(bottom: IZIDimensions.ONE_UNIT_SIZE * 50),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ImageSlideshow(
                        height: IZIDimensions.ONE_UNIT_SIZE * 400,
                        indicatorColor: ColorResources.colorMain,
                        indicatorRadius: 4,
                        isLoop: true,
                        children: List.generate(
                            controller.listImageSlider.length,
                            (index) => ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      IZIDimensions.BORDER_RADIUS_2X),
                                  child: IZIImage(
                                      controller.listImageSlider[index]),
                                )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cơm gà xối mở Thu Phượng',
                              style: TextStyle(
                                color: ColorResources.titleLogin,
                                fontFamily: NUNITO,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w700,
                                fontSize: IZIDimensions.FONT_SIZE_H4,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.clickFavorite();
                              },
                              child: Icon(Icons.favorite_border,
                                  size: IZIDimensions.ONE_UNIT_SIZE * 40,
                                  color: controller.isCheckFavorite
                                      ? ColorResources.colorMain
                                      : ColorResources.BLACK),
                            ),
                          ],
                        ),
                        Text(
                          '102 Phan Châu Trinh-Hải Châu-Đà Nẵng',
                          style: TextStyle(
                            color: ColorResources.GREY,
                            fontFamily: NUNITO,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                            fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                          ),
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        RatingStars(
                          value: 4.5,
                          starCount: 5,
                          starSize: IZIDimensions.ONE_UNIT_SIZE * 30,
                          starColor: Colors.yellow,
                          onValueChanged: (value) {},
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        Row(
                          children: [
                            Container(
                              height: IZIDimensions.ONE_UNIT_SIZE * 10,
                              width: IZIDimensions.ONE_UNIT_SIZE * 10,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorResources.colorMain),
                            ),
                            SizedBox(
                              width: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            Text(
                              'Đang mở cửa : 8:30 - 22:30',
                              style: TextStyle(
                                color: ColorResources.GREY,
                                fontFamily: NUNITO,
                                fontWeight: FontWeight.w400,
                                fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '120.000 vnđ',
                              style: TextStyle(
                                color: ColorResources.colorMain,
                                fontFamily: NUNITO,
                                fontWeight: FontWeight.w600,
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: IZIDimensions.ONE_UNIT_SIZE * 50,
                          width: IZIDimensions.iziSize.width,
                          child: const Divider(),
                        ),

                        // các món của cửa hàng
                        Text(
                          'Có thể bạn thích',
                          style: TextStyle(
                            color: ColorResources.BLACK,
                            fontFamily: NUNITO,
                            fontWeight: FontWeight.w600,
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                          ),
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        Container(
                          height: IZIDimensions.ONE_UNIT_SIZE * 150,
                          color: ColorResources.WHITE,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Card(
                                  elevation: 1,
                                  child: Container(
                                    width: IZIDimensions.iziSize.width*0.9,
                                    margin: EdgeInsets.only(
                                        right: IZIDimensions.SPACE_SIZE_3X),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          IZIDimensions.BORDER_RADIUS_5X),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              IZIDimensions.BORDER_RADIUS_3X),
                                          child: IZIImage(
                                            'https://images.foody.vn/res/g100001/1000000008/prof/s280x175/foody-upload-api-foody-mobile-dd-200414154651.jpg',
                                            height:
                                                IZIDimensions.ONE_UNIT_SIZE *
                                                    150,
                                            width: IZIDimensions.ONE_UNIT_SIZE *
                                                150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left:
                                                        IZIDimensions.SPACE_SIZE_2X),
                                                child: Text(
                                                  'Cơm chiên trứng',
                                                  style: TextStyle(
                                                    color: ColorResources.titleLogin,
                                                    fontFamily: NUNITO,
                                                    fontWeight: FontWeight.w600,
                                                    overflow: TextOverflow.ellipsis,
                                                    fontSize:
                                                        IZIDimensions.FONT_SIZE_H6,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left:
                                                        IZIDimensions.SPACE_SIZE_2X),
                                                child: Text(
                                                  'Đã bán 1.2k',
                                                  style: TextStyle(
                                                    color: ColorResources.GREY,
                                                    fontFamily: NUNITO,
                                                    fontWeight: FontWeight.w400,
                                                    overflow: TextOverflow.ellipsis,
                                                    fontSize: IZIDimensions
                                                        .FONT_SIZE_SPAN_SMALL,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left:
                                                        IZIDimensions.SPACE_SIZE_2X),
                                                child: Text(
                                                  '255000 vnđ',
                                                  style: TextStyle(
                                                    color: ColorResources.colorMain,
                                                    fontFamily: NUNITO,
                                                    fontWeight: FontWeight.w600,
                                                    overflow: TextOverflow.ellipsis,
                                                    fontSize: IZIDimensions
                                                        .FONT_SIZE_SPAN_SMALL,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
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
