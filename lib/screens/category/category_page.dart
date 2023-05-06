import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fooding_project/base_widget/p45_appbar.dart';
import 'package:fooding_project/screens/category/category_controller.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CategoryController(),
      builder:  ( CategoryController controller) {
         return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          appBar: const P45AppBarP(title: 'Danh mục sản phẩm'),
          body: Container(

          ),
         );
      },
    );
  }
}