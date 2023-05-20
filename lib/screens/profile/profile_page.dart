import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/base_widget/p45_appbar.dart';
import 'package:fooding_project/helper/izi_date.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/routes/routes_path/location_routes.dart';
import 'package:fooding_project/routes/routes_path/profile_routes.dart';
import 'package:fooding_project/screens/profile/profile_controller.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/utils/images_path.dart';
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
      appBar: const P45AppBarP(
        title: 'Trang cá nhân',
        isShowLeadingIcon: false,
      ),
      body: GetBuilder(
          init: ProfileController(),
          builder: (ProfileController controller) {
            return controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        _trangCaNhan(controller),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_3X,
                        ),
                        _editProfile(controller),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_3X,
                        ),
                        listOrder(controller),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_3X,
                        ),
                        _itemFuction(
                          ontap: () {
                            Get.toNamed(LocationRoutes.LOCATION);
                          },
                          image: Icons.location_city_sharp,
                          text: 'Quản lý địa chỉ',
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_3X,
                        ),
                        _itemFuction(
                          ontap: () {
                            Get.toNamed(ProfileRoutes.FEEL_RATING);
                          },
                          image: Icons.reviews,
                          text: 'Đánh giá cảm nhận',
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_3X,
                        ),
                        _itemFuction(
                          ontap: () {
                            Get.toNamed(ProfileRoutes.HELP);
                          },
                          image: Icons.help,
                          text: 'Thông tin liên hệ',
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_3X,
                        ),
                        _itemFuction(
                          ontap: () {
                            controller.logout();
                          },
                          image: Icons.exit_to_app,
                          text: 'Đăng xuất',
                        ),
                        Obx(() {
                          print(controller.isFooter.value);
                          if (controller.isFooter.value) {
                            return SizedBox(
                              height: IZIDimensions.iziSize.height * 0.08,
                            );
                          }
                          return const SizedBox();
                        })
                      ],
                    ),
                  );
          }),
    );
  }

  Widget _itemFuction({
    required Function ontap,
    required IconData image,
    required String text,
  }) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        color: ColorResources.WHITE,
        padding: EdgeInsets.all(
          IZIDimensions.SPACE_SIZE_4X,
        ),
        child: Row(
          children: [
            Icon(
              image,
              color: Colors.red,
            ),
            SizedBox(
              width: IZIDimensions.BLUR_RADIUS_4X,
            ),
            Text(
              text,
              style: TextStyle(
                color: const Color(0xff37306B),
                fontFamily: 'Nunito',
                fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _editProfile(ProfileController controller) {
    return Container(
      color: ColorResources.WHITE,
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Thông tin cá nhân",
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontSize: IZIDimensions.FONT_SIZE_DEFAULT * 1.1,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  await controller.gotoEditProfile();
                },
                child: Text(
                  "Sửa",
                  style: TextStyle(
                    color: ColorResources.BLACK,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_3X,
          ),
          _itemEdit(
              Icons.person,
              "Họ và tên",
              IZIValidate.nullOrEmpty(controller.user!.fullName)
                  ? "No Name"
                  : controller.user!.fullName!),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          _itemEdit(Icons.phone, "Số điện thoại", controller.user!.phone!),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          _itemEdit(
            Icons.date_range,
            "Ngày tháng năm sinh",
            IZIValidate.nullOrEmpty(controller.user!.dateOfBirth)
                ? "Chưa có dữ liệu"
                : controller.user!.dateOfBirth!,
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
        ],
      ),
    );
  }

  Row _itemEdit(IconData image, String label, String fullname) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          image,
          color: Colors.red,
          size: IZIDimensions.ONE_UNIT_SIZE * 40,
        ),
        SizedBox(
          width: IZIDimensions.SPACE_SIZE_1X,
        ),
        Text(
          label,
          style: TextStyle(
            color: ColorResources.BLACK,
            fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          width: IZIDimensions.SPACE_SIZE_2X,
        ),
        Expanded(
          child: Text(
            fullname,
            style: TextStyle(
              color: ColorResources.BLACK,
              fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: IZIDimensions.SPACE_SIZE_2X,
        ),
      ],
    );
  }

  ///
  /// App bar of page.
  ///
  AppBar _appbar() {
    return AppBar(
      backgroundColor: ColorResources.colorMain,
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
  Widget _trangCaNhan(ProfileController controller) {
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
              child: IZIValidate.nullOrEmpty(controller.user!.avatar)
                  ? const Icon(
                      Icons.person,
                      color: Colors.grey,
                    )
                  : IZIImage(
                      controller.user!.avatar!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          IZIText(
            text: IZIValidate.nullOrEmpty(controller.user!.fullName)
                ? "No Name"
                : controller.user!.fullName!,
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

  ///
  /// List order.
  ///
  Widget listOrder(ProfileController controller) {
    return Container(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_4X,
      ),
      color: ColorResources.WHITE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.store,
                color: Colors.red,
                size: IZIDimensions.ONE_UNIT_SIZE * 45,
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_1X,
              ),
              Text(
                "Đơn đặt hàng",
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontWeight: FontWeight.w500,
                  fontSize: IZIDimensions.FONT_SIZE_DEFAULT * 1.1,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  controller.gotoStatusOrder(0);
                },
                child: Row(
                  children: [
                    Text(
                      "Xem tất cả",
                      style: TextStyle(
                        color: ColorResources.camNhat,
                        fontWeight: FontWeight.w600,
                        fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: ColorResources.camNhat,
                      size: IZIDimensions.ONE_UNIT_SIZE * 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _itemOrder(
                ImagesPath.iconPeding,
                "Chờ nhận",
                () {
                  controller.gotoStatusOrder(0);
                },
                "1",
              ),
              _itemOrder(
                ImagesPath.iconVerified,
                "Đang giao",
                () {
                  controller.gotoStatusOrder(1);
                },
                "1",
              ),
              _itemOrder(
                ImagesPath.iconCancel,
                "Đã hủy",
                () {
                  controller.gotoStatusOrder(2);
                },
                "1",
              ),
              _itemOrder(
                ImagesPath.iconElevated,
                "Thành công",
                () {
                  controller.gotoStatusOrder(3);
                },
                "1",
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _itemOrder(
    String image,
    String status,
    Function ontap,
    String count,
  ) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Column(
        children: [
          Container(
            height: IZIDimensions.ONE_UNIT_SIZE * 110,
            width: IZIDimensions.ONE_UNIT_SIZE * 110,
            decoration: BoxDecoration(
              color: ColorResources.colorBGItemListOrder.withOpacity(.3),
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IZIImage(
                  image,
                  width: IZIDimensions.ONE_UNIT_SIZE * 70,
                ),
              ],
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          Text(
            status,
            style: TextStyle(
              color: ColorResources.colorTextItemListOrder,
              fontWeight: FontWeight.w500,
              fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
            ),
          ),
        ],
      ),
    );
  }
}
