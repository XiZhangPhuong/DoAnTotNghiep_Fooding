// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/routes/routes_path/auth_routes.dart';
import 'package:fooding_project/routes/routes_path/profile_routes.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  final String avatar;
  final String fullName;

     const MainDrawer({
    Key? key,
    required this.avatar,
    required this.fullName,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResources.LIGHT_GREY,
      width: IZIDimensions.iziSize.width * 0.7,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              ClipOval(
                child: IZIImage(avatar,height: IZIDimensions.ONE_UNIT_SIZE*100,
                width: IZIDimensions.ONE_UNIT_SIZE*100,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                fullName,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                  fontFamily: NUNITO,
                  
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Software Engenieer",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        //Now let's Add the button for the Menu
        //and let's copy that and modify it
        ListTile(
          onTap: () {
            Get.toNamed(ProfileRoutes.PROFILE);
          },
          leading: const Icon(
            Icons.person,
            color: Colors.black,
          ),
          title: const Text("Thông tin cá nhân"),
        ),

        ListTile(
          onTap: () {},
          leading: const Icon(
            Icons.inbox,
            color: Colors.black,
          ),
          title: const Text("Ví của bạn"),
        ),

        ListTile(
          onTap: () {
            Get.toNamed(ProfileRoutes.CHART);
          },
          leading: const Icon(
            Icons.assessment,
            color: Colors.black,
          ),
          title: const Text("Thống kê"),
        ),

        ListTile(
          onTap: () {
            Get.offAllNamed(AuthRoutes.LOGIN);
            IZIAlert().success(message: "Đăng xuất thành công");
          },
          leading: const Icon(
            Icons.settings,
            color: Colors.black,
          ),
          title: const Text("Log out"),
        ),
      ]),
    );
  }
}
