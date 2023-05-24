import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/izi_input.dart';
import 'package:fooding_project/base_widget/izi_loading_card.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/screens/search_new/search_new_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class SearchNewPage extends GetView<SearchNewController> {
  const SearchNewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SearchNewController(),
      builder: (SearchNewController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          body: Column(
            children: [
              _searchView(controller),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      IZIValidate.nullOrEmpty(controller.filterSearch) ? 
                      _listViewHistorySearch(controller)
                      : _listViewSearch(controller),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

///
/// searchView
///
Widget _searchView(SearchNewController controller) {
  return 
  Container(
    padding: EdgeInsets.only(
        top: IZIDimensions.ONE_UNIT_SIZE * 80,
        bottom: IZIDimensions.SPACE_SIZE_2X),
    color: ColorResources.colorMain,
    child: Padding(
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
              controller: controller.txtfilter,
              type: IZIInputType.TEXT,
              placeHolder: 'Bạn thèm món gì ?',
              hintStyle: TextStyle(
                color: ColorResources.GREY,
                fontFamily: NUNITO,
                fontSize: IZIDimensions.FONT_SIZE_H6,
              ),
              suffixIcon: Visibility(
                  visible:
                      IZIValidate.nullOrEmpty(controller.search) ? false : true,
                  child: GestureDetector(
                    onTap: () {
                      controller.deleteText();
                    },
                    child: Icon(
                      Icons.close,
                      size: IZIDimensions.ONE_UNIT_SIZE * 40,
                      color: ColorResources.colorMain,
                    ),
                  )),
              borderRadius: IZIDimensions.BORDER_RADIUS_3X,
              fillColor: ColorResources.WHITE,
              padding: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_3X),
              onChanged: (value) {
                controller.onTextChanged(value);
              },
              onSubmitted: (p0) {
                controller.onSubmitted(p0.toString());
              },
            ),
          ),
        ],
      ),
    ),
  );
}

///
/// listview history search
///
Widget _listViewHistorySearch(SearchNewController controller) {
  return
  !IZIValidate.nullOrEmpty(controller.filterSearch) ? Container() :
   Container(
    height: IZIDimensions.iziSize.height,
    color: ColorResources.WHITE,
    padding: EdgeInsets.symmetric(
      vertical: IZIDimensions.SPACE_SIZE_2X,
      horizontal: IZIDimensions.SPACE_SIZE_3X,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tìm kiếm gần đây',
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w600,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.deleteAllSeach();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_4X,
                    vertical: IZIDimensions.SPACE_SIZE_1X * 0.5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(IZIDimensions.SPACE_SIZE_5X),
                    color: const Color(0xff677275),
                  ),
                  child: Text(
                    'Xóa',
                    style: TextStyle(
                      color: ColorResources.WHITE,
                      fontFamily: NUNITO,
                      fontWeight: FontWeight.w500,
                      fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        controller.listHistorySearch.isEmpty ? const DataEmpty() : 
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.listHistorySearch.length,
          itemBuilder: (context, index) {
        return GestureDetector(
           behavior: HitTestBehavior.opaque,
          onTap: () {
            controller.onClickItemHistorySearch(controller.listHistorySearch[index]);
          },
          child: Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_3X,
            ),
            padding: EdgeInsets.only(
              left: IZIDimensions.SPACE_SIZE_1X,
              right: IZIDimensions.SPACE_SIZE_3X,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.listHistorySearch[index],
                  style: TextStyle(
                    color: ColorResources.GREY,
                    fontFamily: NUNITO,
                    fontWeight: FontWeight.w600,
                    fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.deleteItemSearch(controller.listHistorySearch[index]);
                  },
                  child: Icon(Icons.close,size: IZIDimensions.ONE_UNIT_SIZE*30,color: ColorResources.GREY,),
                ),
              ],
            ),
          ),
        );
          },
        )
      ],
    ),
  );
}


 ///
  /// listview search
  ///
  Widget _listViewSearch(SearchNewController controller) {
    return  IZIValidate.nullOrEmpty(controller.filterSearch) ? Container() : 
     GestureDetector(
      onHorizontalDragEnd:(details) {
        if(details.velocity.pixelsPerSecond.dx>0){
          controller.filterSearch=='';
          controller.update();
        }else{
          controller.filterSearch = '';
          controller.update();
        }
      },
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
          
          Container(
            padding: EdgeInsets.only(
              top: IZIDimensions.SPACE_SIZE_2X,
              left: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Text(
              'Tìm thấy ${controller.listProductSearch.length} món ăn',
              style: TextStyle(
                color: ColorResources.BLACK,
                fontFamily: NUNITO,
                fontWeight: FontWeight.w600,
                fontSize: IZIDimensions.FONT_SIZE_H6,
              ),
            ),
          ),
         
            controller.isLoadingProductSearch==false ? const DataEmpty() : 
            controller.listProductSearch.isEmpty ? const DataEmpty() : 
            ListView.builder(
             shrinkWrap: true,
             physics: const NeverScrollableScrollPhysics(),
             itemCount: controller.listProductSearch.length,
             itemBuilder: (context, index) {
               return GestureDetector(
                 onTap: () {
                   controller.gotoDetailFood(controller.listProductSearch[index].id!);               
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
                               controller.listProductSearch[index].image!.first,
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
                                   controller.listProductSearch[index].name!,
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
                                   controller.formatSold(controller.listProductSearch[index].sold!),
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
                                  controller.listProductSearch[index].priceDiscount==0 ? 
                                  '${IZIPrice.currencyConverterVND(controller.listProductSearch[index].price!.toDouble())}đ' : 
                                   '${IZIPrice.currencyConverterVND(controller.listProductSearch[index].priceDiscount!.toDouble())}đ',
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
     );
  }
