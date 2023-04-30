import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fooding_project/base_widget/custom_scrollbar_gridview.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/izi_smart_refresher.dart';
import 'package:fooding_project/base_widget/izi_text.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_price.dart';

import 'package:fooding_project/screens/home/home_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';
import 'package:slide_countdown/slide_countdown.dart';

class HomeScreenPage extends GetView<HomeController> {
  const HomeScreenPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (HomeController controller) {
        return Scaffold(
          backgroundColor: ColorResources.WHITE,
          body: SafeArea(
            child: Container(
              color: ColorResources.WHITE,
              // margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_2X),
              padding: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.SPACE_SIZE_3X,
                  vertical: IZIDimensions.SPACE_SIZE_3X),
              child: Column(
                children: [
                  // address
                  _andressCustomer(controller),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  // search
                  _searchView(controller),
                  Expanded(
                    child: IZISmartRefresher(
                      enablePullDown: true,
                      onLoading: () {
                        controller.onLoading();
                      },
                      onRefresh: () {
                        controller.onRefreshing();
                      },
                      refreshController: controller.refreshController,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // image slideshow
                            _imageSlideShow(controller),
                            // category
                            _categoryFood(controller),
                            // flash sale
                            _flashSale(controller),
                          ],
                        ),
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

  ///
  /// flastSale
  ///
  Widget _flashSale(HomeController controller) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Đang giảm giá',
                style: TextStyle(
                  color: ColorResources.titleLogin,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w600,
                  fontSize: IZIDimensions.FONT_SIZE_H5,
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_2X,
              ),
              SlideCountdownSeparated(
                duration: const Duration(hours: 5),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: ColorResources.colorMain,
                ),
                textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                    color: ColorResources.WHITE),
                height: IZIDimensions.ONE_UNIT_SIZE * 40,
                width: IZIDimensions.ONE_UNIT_SIZE * 40,
              )
            ],
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_3X,
          ),

          //
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  height: IZIDimensions.ONE_UNIT_SIZE * 320,
                  color: ColorResources.WHITE,
                  child: controller.isLoadingProduct == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : 
                        _listViewProduct(controller),
                      ),
                      SizedBox(width: 
                    IZIDimensions.SPACE_SIZE_2X,),

                    // view all list products                 
                      GestureDetector(
                        onTap:  () {
                          
                        },
                        child: Container(
                          height: IZIDimensions.ONE_UNIT_SIZE * 320,
                          width: IZIDimensions.ONE_UNIT_SIZE * 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(IZIDimensions.SPACE_SIZE_2X),
                            border: Border.all(width: 0.3,color: ColorResources.colorMain)
                          ),
                          child: Center(
                            child: Text('Xem tất cả',style: TextStyle(
                              color: ColorResources.colorMain,
                              fontSize: IZIDimensions.FONT_SIZE_H6,
                              fontFamily: NUNITO,
                              fontWeight: FontWeight.w500
                            ),),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  ///
  ///  list view products
  ///
  Widget _listViewProduct(HomeController controller) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: controller.listProducts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            controller.gotoDetailFood(controller.listProducts[index].id!);
          },
          child: Card(
            elevation: 1,
            child: Container(
              width: IZIDimensions.ONE_UNIT_SIZE * 230,
              margin: EdgeInsets.only(right: IZIDimensions.SPACE_SIZE_3X),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(IZIDimensions.BORDER_RADIUS_5X),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
                    child: IZIImage(
                      controller.listProducts[index].image!.first,
                      height: IZIDimensions.ONE_UNIT_SIZE * 200,
                      width: IZIDimensions.ONE_UNIT_SIZE * 230,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_2X),
                    child: Text(
                      controller.listProducts[index].name!,
                      style: TextStyle(
                        color: ColorResources.titleLogin,
                        fontFamily: NUNITO,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_2X),
                    child: Text(
                      '${IZIPrice.currencyConverterVND((controller.listProducts[index].price!.toDouble()))}đ',
                      style: TextStyle(
                        color: ColorResources.colorMain,
                        fontFamily: NUNITO,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        fontSize: IZIDimensions.FONT_SIZE_DEFAULT * 0.9,
                      ),
                      maxLines: 2,
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

  ///
  /// Category Food
  ///
  Widget _categoryFood(
    HomeController controller,
  ) {
    return Container(
      margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_3X),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Danh mục',
            style: TextStyle(
              color: ColorResources.titleLogin,
              fontFamily: NUNITO,
              fontWeight: FontWeight.w600,
              fontSize: IZIDimensions.FONT_SIZE_H5,
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_3X,
          ),
          SizedBox(
            height: IZIDimensions.iziSize.height * .34,
            child: controller.isLoadingCategory
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomScrollbar(
                    itemCount: controller.listCategory.length,
                    alignment: Alignment.bottomCenter,
                    thumbColor: Colors.red,
                    strokeWidth:
                        (IZIDimensions.iziSize.width * 0.246).ceilToDouble(),
                    strokeHeight:
                        (IZIDimensions.iziSize.width * 0.045).ceilToDouble(),
                    scrollbarMargin: const EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_3X * 0),
                    child: (index) => GestureDetector(
                          onTap: () {
                            controller.gotoSearchPage(
                                controller.listCategory[index].name!);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: IZIDimensions.SPACE_SIZE_2X),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      IZIDimensions.BORDER_RADIUS_7X),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      IZIDimensions.BORDER_RADIUS_7X),
                                  child: IZIImage(
                                    controller.listCategory[index].thumnail!,
                                    width: IZIDimensions.ONE_UNIT_SIZE * 90,
                                    height: IZIDimensions.ONE_UNIT_SIZE * 90,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              IZIText(
                                text: controller.listCategory[index].name!,
                                maxLine: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                  color: const Color(0xff464647),
                                ),
                              ),
                            ],
                          ),
                        )),
          ),
        ],
      ),
    );
  }

  ///
  /// image slide show
  ///
  Container _imageSlideShow(HomeController controller) {
    return Container(
      margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_3X),
      child: ImageSlideshow(
        indicatorColor: ColorResources.colorMain,
        indicatorRadius: 4,
        isLoop: true,
        children: List.generate(
            controller.listImageSlider.length,
            (index) => ClipRRect(
                  borderRadius:
                      BorderRadius.circular(IZIDimensions.BORDER_RADIUS_5X),
                  child: IZIImage(controller.listImageSlider[index]),
                )),
      ),
    );
  }

  ///
  /// search view
  ///
  Widget _searchView(HomeController controller) {
    return GestureDetector(
      onTap: () {
        controller.gotoSearchPage('');
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: IZIDimensions.SPACE_SIZE_3X,
          horizontal: IZIDimensions.SPACE_SIZE_2X,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
          color: ColorResources.BACK_GROUND,
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: ColorResources.BLACK,
              size: IZIDimensions.ONE_UNIT_SIZE * 30,
            ),
            SizedBox(
              width: IZIDimensions.SPACE_SIZE_1X,
            ),
            Text(
              'Bạn muốn ăn gì hôm nay ? ',
              style: TextStyle(
                color: ColorResources.GREY,
                fontFamily: NUNITO,
                fontWeight: FontWeight.w400,
                fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// _andressCustomer
  ///
  Row _andressCustomer(HomeController controller) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          color: ColorResources.colorMain,
          size: IZIDimensions.ONE_UNIT_SIZE * 35,
        ),
        SizedBox(
          width: IZIDimensions.SPACE_SIZE_2X,
        ),
        Expanded(
          child: Text(
            controller.street,
            maxLines: 1,
            style: TextStyle(
              color: ColorResources.titleLogin,
              fontFamily: NUNITO,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
              fontSize: IZIDimensions.FONT_SIZE_H6,
            ),
          ),
        ),
        SizedBox(
          width: IZIDimensions.SPACE_SIZE_1X,
        ),
        Icon(
          Icons.keyboard_arrow_right,
          color: ColorResources.GREY,
          size: IZIDimensions.ONE_UNIT_SIZE * 35,
        ),
      ],
    );
  }
}
