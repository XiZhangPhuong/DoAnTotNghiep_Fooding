// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fooding_project/screens/home/home_controller.dart';
import 'package:get/get.dart';

class HomeScreenPage extends GetView<HomeController> {
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('103 Hoài Thanh'),
            centerTitle: true,
            leading: const Icon(Icons.location_on),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    // imageview slideshow
                    _imageslideShow(controller),
                    // Danh muc
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Danh mục',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _gridViewCategorys(controller),
                     SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Đề xuất',
                      style: TextStyle(fontSize: 16),
                    ),
                     SizedBox(
                      height: 10,
                    ),
                  
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _gridViewCategorys(HomeController controller) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 4,
      ),
      itemCount: controller.categorys.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print(controller.categorys[index]['title']);
            Get.snackbar('Cateogrys', controller.categorys[index]['title']);
          },
          child: Container(
           // height: 200,
            child: Column(
              children: [
                Expanded(
                    child: Image.network(
                  controller.categorys[index]['icon'],
                  //fit: BoxFit.cover,
                )),
                SizedBox(
                  height: 5,
                ),
                Text(controller.categorys[index]['title'])
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _imageslideShow(HomeController controller) {
    return ImageSlideshow(
      width: double.infinity,
      //height: 200,
      indicatorColor: Colors.blue,
      indicatorBackgroundColor: Colors.grey,
      indicatorRadius: 5.0,
      isLoop: true,
      autoPlayInterval: 3000,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              controller.slideshows[0],
              fit: BoxFit.cover,
            )),
        ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              controller.slideshows[1],
              fit: BoxFit.cover,
            )),
        ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              controller.slideshows[2],
              fit: BoxFit.cover,
            )),
      ],
    );
  }
}
