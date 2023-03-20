import 'package:flutter/material.dart';

import '../helper/izi_dimensions.dart';
import '../utils/color_resources.dart';
import '../utils/images_path.dart';
import 'izi_image.dart';


class LoadingApp extends StatelessWidget {
  const LoadingApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: IZIDimensions.ONE_UNIT_SIZE * 140,
      height: IZIDimensions.ONE_UNIT_SIZE * 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          IZIImage(
            ImagesPath.placeHolder,
            width: IZIDimensions.ONE_UNIT_SIZE * 130,
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: IZIDimensions.ONE_UNIT_SIZE * 140,
            height: IZIDimensions.ONE_UNIT_SIZE * 140,
            child: CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(ColorResources.PRIMARY_1),
              strokeWidth: IZIDimensions.ONE_UNIT_SIZE * 5,
            ),
          ),
        ],
      ),
    );
  }
}
