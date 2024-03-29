import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../helper/izi_dimensions.dart';
import '../helper/izi_validate.dart';
import '../utils/color_resources.dart';
import '../utils/images_path.dart';

enum IZIImageType {
  SVG,
  IMAGE,
  NOTIMAGE,
}

enum IZIImageUrlType {
  NETWORK,
  ASSET,
  FILE,
  ICON,
  IMAGE_CIRCLE,
}

// ignore: must_be_immutable
class IZIImage extends StatelessWidget {
  IZIImage(
    String this.urlImage, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.colorIconsSvg,
  }) : super(key: key);
  IZIImage.file(
    this.file, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);
  IZIImage.icon(
    IconData this.icon, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color = ColorResources.BLACK,
    this.size,
  }) : super(key: key);
  String? urlImage;
  final double? width;
  final double? height;
  final BoxFit? fit;
  File? file;
  IconData? icon;
  Color? color;
  Color? colorIconsSvg;
  double? size;

  IZIImageType checkImageType(String url) {
    if (IZIValidate.nullOrEmpty(url) && IZIValidate.nullOrEmpty(file) && IZIValidate.nullOrEmpty(icon)) {
      return IZIImageType.NOTIMAGE;
    }
    if (url.endsWith(".svg")) {
      return IZIImageType.SVG;
    }
    return IZIImageType.IMAGE;
  }

  IZIImageUrlType checkImageUrlType(String url) {
    if (IZIValidate.nullOrEmpty(url)) {
      if (icon != null) {
        return IZIImageUrlType.ICON;
      }
      return IZIImageUrlType.FILE;
    }
    if (url.startsWith('http') || url.startsWith('https')) {
      return IZIImageUrlType.NETWORK;
    } else if (url.startsWith('assets/')) {
      return IZIImageUrlType.ASSET;
    } else if (icon != null) {
      if (icon!.fontFamily.toString().toLowerCase().contains('CupertinoIcons'.toLowerCase()) || icon!.fontFamily.toString().toLowerCase().contains('MaterialIcons'.toLowerCase())) {
        return IZIImageUrlType.ICON;
      }
      return IZIImageUrlType.FILE;
    }
    return IZIImageUrlType.FILE;
  }

  Widget imageTypeWidget(String urlImage, IZIImageType imageType, IZIImageUrlType imageUrlType) {
    if (imageType == IZIImageType.IMAGE) {
      if (imageUrlType == IZIImageUrlType.NETWORK) {
        return CachedNetworkImage(
          imageUrl: urlImage,
          fadeOutDuration: Duration.zero,
          fadeInDuration: Duration.zero,
          width: width,
          height: height,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: fit,
              ),
            ),
          ),
          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      } else if (imageUrlType == IZIImageUrlType.ASSET) {
        return Image.asset(
          urlImage,
          fit: fit,
          height: height,
          width: width,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error);
          },
        );
      } else if (imageUrlType == IZIImageUrlType.FILE) {
        return Image.file(
          file!,
          fit: fit,
          height: height,
          width: width,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error);
          },
        );
      } else if (imageUrlType == IZIImageUrlType.ICON) {
        return SizedBox(
          height: height,
          width: width,
          child: Icon(
            icon,
            color: color,
            size: size ?? IZIDimensions.ONE_UNIT_SIZE * 45,
          ),
        );
      }
    }

    if (imageType == IZIImageType.SVG) {
      if (imageUrlType == IZIImageUrlType.NETWORK) {
        return SvgPicture.network(
          urlImage,
          fit: fit!,
          height: height,
          width: width,
          placeholderBuilder: (BuildContext context) => const SizedBox(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      } else if (imageUrlType == IZIImageUrlType.ASSET) {
        return SvgPicture.asset(
          urlImage,
          fit: fit!,
          height: height,
          width: width,
          color: colorIconsSvg,
          placeholderBuilder: (BuildContext context) => const SizedBox(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      } else if (imageUrlType == IZIImageUrlType.FILE) {
        return Expanded(
          child: SvgPicture.file(
            file!,
            fit: fit!,
            height: height,
            width: width,
            placeholderBuilder: (BuildContext context) => const SizedBox(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      } else if (imageUrlType == IZIImageUrlType.ICON) {
        return SizedBox(
          height: height,
          width: width,
          child: Icon(
            icon,
            color: color,
          ),
        );
      }
    }

    if (imageType == IZIImageType.NOTIMAGE) {
      return Image.asset(
        ImagesPath.placeHolder,
        fit: fit,
        height: height ?? IZIDimensions.ONE_UNIT_SIZE * 50,
        width: width ?? IZIDimensions.ONE_UNIT_SIZE * 50,
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final imageType = checkImageType(urlImage.toString());
    final imageUrlType = checkImageUrlType(urlImage.toString());
    return imageTypeWidget(
      urlImage.toString(),
      imageType,
      imageUrlType,
    );
  }
}
