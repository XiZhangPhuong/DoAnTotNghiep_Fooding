import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fooding_project/screens/profile/profile_controller.dart';
import 'package:get/get.dart';

import '../../base_widget/izi_image.dart';
import '../../base_widget/izi_text.dart';
import '../../helper/izi_dimensions.dart';
import '../../utils/color_resources.dart';

class ProfilePage extends GetView {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: GetBuilder(
          init: ProfileController(),
          builder: (ProfileController controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _trangCaNhan(),
                ],
              ),
            );
          }),
    );
  }

  ///
  /// App bar of page.
  ///
  AppBar _appbar() {
    return AppBar(
      backgroundColor: const Color(0xffABC4AA),
      elevation: 0,
      title: Text(
        'Trang cá nhân',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: IZIDimensions.FONT_SIZE_SPAN * 1.2,
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(IZIDimensions.ONE_UNIT_SIZE * 5),
        child: Container(),
      ),
    );
  }

  ///
  /// Trang cá nhân
  ///
  Widget _trangCaNhan() {
    return Container(
      width: IZIDimensions.iziSize.width,
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_5X,
      ),
      padding: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_3X,
      ),
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Column(
        children: [
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_5X * 4.5,
            width: IZIDimensions.SPACE_SIZE_5X * 4.5,
            child: ClipOval(
              child: IZIImage(
                "",
              ),
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          IZIText(
            text: "Trương Đình Quyền",
            style: TextStyle(
              color: ColorResources.BLACK,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              fontSize: IZIDimensions.FONT_SIZE_H6,
            ),
          ),
          SizedBox(
            height: IZIDimensions.ONE_UNIT_SIZE * 5,
          ),
          IZIText(
            text: "Thành viên",
            style: TextStyle(
              color: ColorResources.BLACK,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
              fontSize: IZIDimensions.FONT_SIZE_SPAN,
            ),
          ),
        ],
      ),
    );
  }
}
