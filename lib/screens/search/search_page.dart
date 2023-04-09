import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fooding_project/screens/search/search_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SearchPage extends GetView<SearchController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SearchController(),
      builder: (SearchController  controller) {
         return Scaffold(
            
         );
      },
    );
  }
}