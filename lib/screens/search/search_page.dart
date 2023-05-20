import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/izi_input.dart';
import 'package:fooding_project/base_widget/izi_loading_card.dart';
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
                          _searchView(controller),
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_3X,
                          ),
                          // find history
                          // filter
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: IZIDimensions.SPACE_SIZE_3X,
                            ),
                            child: SizedBox(
                              height: IZIDimensions.ONE_UNIT_SIZE * 60,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    // near you
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: IZIDimensions.SPACE_SIZE_2X,
                                        vertical:
                                            IZIDimensions.SPACE_SIZE_1X * 0.7,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            IZIDimensions.BORDER_RADIUS_4X),
                                        color: ColorResources.WHITE,
                                        border: Border.all(
                                            width: 1,
                                            color: ColorResources.colorMain),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Gần đây nhất',
                                              style: TextStyle(
                                                color: ColorResources.colorMain,
                                                fontFamily: NUNITO,
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    IZIDimensions.FONT_SIZE_H6,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  IZIDimensions.SPACE_SIZE_1X,
                                            ),
                                            const RotatedBox(
                                              quarterTurns: 1,
                                              child: Icon(
                                                Icons
                                                    .keyboard_arrow_right_outlined,
                                                color: ColorResources.colorMain,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: IZIDimensions.SPACE_SIZE_2X,
                                    ),
                                    // name category
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: IZIDimensions.SPACE_SIZE_2X,
                                        vertical:
                                            IZIDimensions.SPACE_SIZE_1X * 0.7,
                                      ),
                                      width: IZIDimensions.ONE_UNIT_SIZE*250,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            IZIDimensions.BORDER_RADIUS_4X),
                                        color: ColorResources.WHITE,
                                        border: Border.all(
                                            width: 1,
                                            color: ColorResources.colorMain),
                                      ),
                                      child: Center(
                                          child: 
                                          controller.isLoadDingNameCategory==false ? null : 
                                          DropdownButton(
                                        onChanged: (value) {
                                          controller.changeDropDow(value.toString());
                                        },
                                        elevation: 0,
                                        value: controller.nameCategory,
                                        isExpanded : true,
                                        underline:  Container(),
                                        icon: const RotatedBox(
                                          quarterTurns: 1,
                                          child: Icon(
                                            Icons.keyboard_arrow_right_outlined,
                                            color: ColorResources.colorMain,
                                          ),
                                        ),
                                        items: controller.listNameCategory
                                            .map((e) {
                                          return DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e.toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: IZIDimensions
                                                        .FONT_SIZE_H6,
                                                    color:
                                                        ColorResources.colorMain),
                                              ));
                                        }).toList(),
                                      )),
                                    ),
                                    SizedBox(
                                      width: IZIDimensions.SPACE_SIZE_2X,
                                    ),
                                    // filter money
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: IZIDimensions.SPACE_SIZE_2X,
                                        vertical:
                                            IZIDimensions.SPACE_SIZE_1X * 0.7,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            IZIDimensions.BORDER_RADIUS_4X),
                                        color: ColorResources.WHITE,
                                        border: Border.all(
                                            width: 1,
                                            color: ColorResources.colorMain),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Đang mở cửa',
                                              style: TextStyle(
                                                color: ColorResources.colorMain,
                                                fontFamily: NUNITO,
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    IZIDimensions.FONT_SIZE_H6,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  IZIDimensions.SPACE_SIZE_1X,
                                            ),
                                            const RotatedBox(
                                              quarterTurns: 1,
                                              child: Icon(
                                                Icons
                                                    .keyboard_arrow_right_outlined,
                                                color: ColorResources.colorMain,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
  /// listview search
  ///
  Widget _listViewSearch(SearchController controller) {
    return
     Expanded(
      child: SingleChildScrollView(
        child: Visibility(
          visible: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_2X,
              ),
               controller.isLoadingProduct==false ? const CardLoadingItem(count: 10,) : 
               controller.listProducts.isEmpty ? const DataEmpty() : 
               ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.listProducts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller
                          .gotoDetailFood(controller.listProducts[index].id!);
                    },
                    child: Container(
                      padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
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
                                  controller.listProducts[index].image!.first,
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
                                  children: [
                                    Text(
                                      controller.listProducts[index].name!,
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
                                      '${controller.formatSold(controller.listProducts[index].sold!)}',
                                      style: TextStyle(
                                        color: ColorResources.GREY,
                                        fontFamily: NUNITO,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            IZIDimensions.FONT_SIZE_DEFAULT,
                                      ),
                                    ),
                                    SizedBox(
                                      height: IZIDimensions.SPACE_SIZE_1X,
                                    ),
                                    Text(
                                      '${IZIPrice.currencyConverterVND(controller.listProducts[index].price!.toDouble())}đ',
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

  Widget _searchView(SearchController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_3X),
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: ColorResources.BLACK,
                size: IZIDimensions.ONE_UNIT_SIZE * 50,
              )),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_2X,
          ),
          Expanded(
            child: IZIInput(
              type: IZIInputType.TEXT,
              controller: controller.filter,
              placeHolder: 'Bạn thèm món gì ?',
              hintStyle: TextStyle(
                color: ColorResources.GREY,
                fontFamily: NUNITO,
                fontSize: IZIDimensions.FONT_SIZE_H6,
              ),
              suffixIcon: Visibility(
                  visible: true,
                  child: Icon(
                    Icons.delete_sweep,
                    size: IZIDimensions.ONE_UNIT_SIZE * 40,
                  )),
              borderRadius: IZIDimensions.BORDER_RADIUS_3X,
              fillColor: ColorResources.WHITE,
              padding: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_3X),
              // onChanged: (value) {
              //   controller.search(value);
              // },
              onSubmitted: (p0) {
                controller.search(p0.toString());
              },
            ),
          ),
        ],
      ),
    );
  }
}
