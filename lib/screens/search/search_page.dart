import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/izi_input.dart';
import 'package:fooding_project/base_widget/izi_loading_card.dart';
import 'package:fooding_project/base_widget/p45_appbar.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/screens/search/search_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class SearchPage extends GetView<SearchController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SearchController(),
      builder: (SearchController controller) {
        return controller.isLoadingProduct == false
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                backgroundColor: ColorResources.BACK_GROUND,
                appBar: const P45AppBarP(title: 'Danh mục sản phẩm'),
                body: GestureDetector(
                  onTap: () {},
                  child: SafeArea(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: IZIDimensions.SPACE_SIZE_5X,
                      ),
                      child: Column(
                        children: [
                          // search

                          // find history
                          // filter
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: IZIDimensions.SPACE_SIZE_3X,
                            ),
                            child: Row(
                              
                              children: [
                                // all store
                            
                                // name category
                                Flexible (child: _filterName(controller)),
                                SizedBox(
                                  width: IZIDimensions.SPACE_SIZE_2X,
                                ),
                                // filter money
                                Flexible (child: _filterSoft(controller)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_3X,
                          ),
                          // listview search
                          _listViewSearch(controller)
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  

  ///
  /// filter Soft
  ///
  Widget _filterSoft(SearchController controller) {
    return GestureDetector(
      onTap: () {
        controller.clickSoftt();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_2X,
          vertical: IZIDimensions.SPACE_SIZE_1X * 0.7,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_4X),
          color: ColorResources.WHITE,
          border: Border.all(width: 0.8, color: ColorResources.colorMain),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  controller.filterSoft,
                  style: TextStyle(
                    color: ColorResources.colorMain,
                    fontFamily: NUNITO,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                    fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                  ),
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_1X,
              ),
              const RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: ColorResources.colorMain,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

///
/// filter namecateory
///
  Widget _filterName(SearchController controller) {
    return GestureDetector(
      onTap: () {
        controller.clickNameCategory();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_2X,
          vertical: IZIDimensions.SPACE_SIZE_1X * 0.7,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_4X),
          color: ColorResources.WHITE,
          border: Border.all(width: 0.8, color: ColorResources.colorMain),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  controller.filterNameCategory,
                  style: TextStyle(
                    color: ColorResources.colorMain,
                    fontFamily: NUNITO,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                    fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                  ),
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_1X,
              ),
              const RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: ColorResources.colorMain,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// all store
  ///
  Widget _allStore(SearchController controller) {
    return GestureDetector(
      onTap: () {
        controller.clickAllStoreShowBottomSheet();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_2X,
          vertical: IZIDimensions.SPACE_SIZE_1X * 0.7,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_4X),
          color: ColorResources.WHITE,
          border: Border.all(width: 0.8, color: ColorResources.colorMain),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  controller.filterNameStore,
                  style: TextStyle(
                    color: ColorResources.colorMain,
                    fontFamily: NUNITO,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                    fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                  ),
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_1X,
              ),
              const RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: ColorResources.colorMain,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// listview search
  ///
  Widget _listViewSearch(SearchController controller) {
    return Expanded(
      child: SingleChildScrollView(
        child: Visibility(
          visible: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_2X,
              ),
              controller.isLoadingProduct == false
                  ? const CardLoadingItem(
                      count: 10,
                    )
                  : controller.listProducts.isEmpty
                      ? const  CardLoadingItem(
                      count: 10,
                    )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.listProducts.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                controller.gotoDetailFood(
                                    controller.listProducts[index].id!);
                              },
                              child: Container(
                                padding:
                                    EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                                margin: EdgeInsets.only(
                                    top: IZIDimensions.SPACE_SIZE_1X * 0,
                                    bottom: IZIDimensions.SPACE_SIZE_2X,
                                    left: IZIDimensions.SPACE_SIZE_3X,
                                    right: IZIDimensions.SPACE_SIZE_3X),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      IZIDimensions.BORDER_RADIUS_3X),
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
                                            controller.listProducts[index]
                                                .image!.first,
                                            height:
                                                IZIDimensions.ONE_UNIT_SIZE *
                                                    120,
                                            width: IZIDimensions.ONE_UNIT_SIZE *
                                                120,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          width: IZIDimensions.SPACE_SIZE_3X,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller
                                                    .listProducts[index].name!,
                                                style: TextStyle(
                                                  color: ColorResources.BLACK,
                                                  fontFamily: NUNITO,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: IZIDimensions
                                                      .FONT_SIZE_H5,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    IZIDimensions.SPACE_SIZE_1X,
                                              ),
                                              Text(
                                                controller.formatSold(controller
                                                    .listProducts[index].sold!),
                                                style: TextStyle(
                                                  color: ColorResources.GREY,
                                                  fontFamily: NUNITO,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: IZIDimensions
                                                      .FONT_SIZE_DEFAULT,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    IZIDimensions.SPACE_SIZE_1X,
                                              ),
                                              Text(
                                                controller.listProducts[index].priceDiscount== 0  ? 
                                                '${IZIPrice.currencyConverterVND(controller.listProducts[index].price!.toDouble())}đ' :
                                                '${IZIPrice.currencyConverterVND(controller.listProducts[index].priceDiscount!.toDouble())}đ'
                                                ,
                                                style: TextStyle(
                                                  color:
                                                      ColorResources.colorMain,
                                                  fontFamily: NUNITO,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: IZIDimensions
                                                      .FONT_SIZE_H6,
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
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// find history
  ///
  Widget _findHistory(SearchController controller) {
    return Container(
      width: IZIDimensions.iziSize.width,
      padding: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_3X,
        horizontal: IZIDimensions.SPACE_SIZE_3X,
      ),
      color: ColorResources.WHITE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lịch sử tìm kiếm',
            style: TextStyle(
              color: ColorResources.BLACK,
              fontFamily: NUNITO,
              fontWeight: FontWeight.w600,
              fontSize: IZIDimensions.FONT_SIZE_H6,
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Wrap(
            runSpacing: IZIDimensions.SPACE_SIZE_2X,
            spacing: IZIDimensions.SPACE_SIZE_2X,
            children: [
              ...controller.listHistory.map((e) {
                return Container(
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: IZIDimensions.SPACE_SIZE_1X,
                  //   vertical: IZIDimensions.SPACE_SIZE_1X,
                  // ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
                    color: ColorResources.GREY.withOpacity(0.5),
                  ),
                  child: Center(
                    child: Text(
                      e.toString(),
                      style: TextStyle(
                        color: ColorResources.GREY,
                        fontFamily: NUNITO,
                        fontWeight: FontWeight.w600,
                        fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                      ),
                    ),
                  ),
                );
              })
            ],
          )
        ],
      ),
    );
  }

 
}
