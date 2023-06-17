import 'package:flutter/widgets.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:get/get.dart';

class HomeWorkController extends GetxController {
  List<Map<String, dynamic>> listQuestion = [
    {
      'avatar': ImagesPath.logoApp,
      'fullName': 'Lê Hữu Trác',
      'class': 'Lớp 12',
      'subject': 'Sinh học',
      'score': '50 điểm',
      'time': 'Khoảng 1 tiếng trước',
      'asking': true,
      'content': 'Nhà cái Trung Quốc',
      'listAvatarReply': [
        'ImagesPath.emptyCart',
        'ImagesPath.logoApp',
        'ImagesPath.logoApp'
      ],
    },
    {
      'avatar': ImagesPath.emptyCart,
      'fullName': 'Phạm Văn Phương',
      'class': 'Lớp 11',
      'subject': 'Tin học',
      'score': '40 điểm',
      'time': '30 phút',
      'asking': false,
      'content': 'Đánh ghen',
      'listAvatarReply': [
        'ImagesPath.logoApp',
        'ImagesPath.logoApp',
        'ImagesPath.emptyCart'
      ],
    },
    {
      'avatar': ImagesPath.logoApp,
      'fullName': 'Lê Thị Thu Phượng',
      'class': 'Lớp 9',
      'subject': 'Công nghệ',
      'score': '50 điểm',
      'time': 'Khoảng 1 tiếng trước',
      'asking': true,
      'content': 'Dệt may là gì ?',
      'listAvatarReply': [
        'ImagesPath.logoApp',
        'ImagesPath.emptyCart',
        'ImagesPath.logoApp'
      ],
    },
  ];
  List<String> listLanguage = [
    'Việt Nam',
    'Hàn Quốc',
    'Nhật Bản',
    'Đài Loan',
    'Đức',
    'Nhật Bản'
  ];
  String itemLanguage = '';

  ///
  /// click choose language
  ///
  void clickChooseLanguage() {}

  ///
  /// show Dialog language
  ///
  void showDiaLogLanGuaGe() {
    Get.bottomSheet(Container(
      height: IZIDimensions.iziSize.height / 1.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(IZIDimensions.SPACE_SIZE_3X),
            topRight: Radius.circular(IZIDimensions.SPACE_SIZE_3X),
          ),
          color: ColorResources.WHITE),
      child: Column(
        children: [
          Container(height: IZIDimensions.SPACE_SIZE_1X),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Text(
            'Chọn ngôn ngữ'.toUpperCase(),
            style: TextStyle(
              color: ColorResources.BLACK,
              fontFamily: NUNITO,
              fontSize: IZIDimensions.FONT_SIZE_H6,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            height: IZIDimensions.SPACE_SIZE_1X * 0.3,
            width: IZIDimensions.iziSize.width / 3,
            color: ColorResources.GREY,
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          IZIImage(
            ImagesPath.emptyCart,
            height: IZIDimensions.ONE_UNIT_SIZE * 200,
            width: IZIDimensions.ONE_UNIT_SIZE * 200,
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_3X,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 1, maxCrossAxisExtent: 120),
              itemCount: listLanguage.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: ColorResources.GREEN,
                    borderRadius:
                        BorderRadius.circular(IZIDimensions.BLUR_RADIUS_3X),
                  ),
                  child: Center(
                    child: Text(
                      listLanguage[index],
                      style: TextStyle(
                        color: ColorResources.WHITE,
                        fontFamily: NUNITO,
                        fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}
