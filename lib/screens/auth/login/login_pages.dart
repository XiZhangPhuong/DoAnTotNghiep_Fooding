// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fooding_project/screens/auth/login/login_controller.dart';
import 'package:get/get.dart';

class LoginPages extends GetView<LoginController> {
  const LoginPages({super.key});

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
    return GetBuilder(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(h * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),

                //header of page
                _header(h),

                SizedBox(
                  height: h * 0.01,
                ),

                // Login.
                _formLogin(h, w),
                Spacer(),

                // Footer of page
                _footer(w),
              ],
            ),
          ),
        );
      },
    );
  }

  Container _footer(double w) {
    return Container(
      width: w,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Bạn không có tài khoản? "),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Đăng kí',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _formLogin(double h, double w) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey.shade800,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey.shade800,
              ),
            ),
            prefixIcon: Icon(
              Icons.person,
              color: Colors.amber,
            ),
            hintText: 'Your Phone',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: h * 0.01,
        ),
        //password
        TextFormField(
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey.shade800,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey.shade800,
              ),
            ),
            prefixIcon: Icon(
              Icons.lock,
            ),
            suffixIcon: Icon(Icons.remove_red_eye),
            hintText: 'password',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: h * 0.02,
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            child: Text(
              'Quên mật khẩu?',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(
          height: h * 0.02,
        ),
        Center(
          child: SizedBox(
            height: h * 0.055,
            width: w * 0.6,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor:
                    Colors.white, // change background color of button
                backgroundColor: Colors.brown.shade400,
              ),
              onPressed: () {},
              child: Text(
                'Đăng nhập',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _header(double h) {
    return Column(
      children: [
        Text(
          'Chào mừng quay trở lại',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: h * 0.008,
        ),
        Text(
          'Đồ ăn ngon, đồ ăn an toàn, giao nhanh nhất',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
