import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/routes/routes_path/auth_routes.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

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
            children: const [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1594616838951-c155f8d978a0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Trương Đình Quyền",
                style: TextStyle(
                  fontSize: 22.0,
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
          onTap: () {},
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
          onTap: () {},
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
