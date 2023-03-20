import 'package:flutter/material.dart';
import 'package:tiengviet/tiengviet.dart';

import '../helper/izi_dimensions.dart';
import '../utils/color_resources.dart';

class DropDownButton<T> extends StatelessWidget {
  const DropDownButton({
    Key? key,
    this.hint = "",
    this.onChanged,
    required this.data,
    this.width,
    this.height,
    required this.value,
    this.label,
    this.labelStyle,
    required this.isRequired,
    this.isEnable = true,
    this.isSort = true,
    this.padding,
    this.textStyleValue,
    this.borderRadius,
    this.colorBorder,
    this.backgroundColor,
    this.textStyleHintText,
    this.selectedItemBuilder,
    this.prefixWidget,
  }) : super(key: key);
  final String? hint;
  final double? width, height;
  final Function(T? value)? onChanged;
  final String? label;
  final TextStyle? labelStyle;
  final bool? isRequired;
  final List<T> data;
  final T? value;
  final bool? isEnable;
  final EdgeInsetsGeometry? padding;
  final bool? isSort;
  final TextStyle? textStyleValue;
  final TextStyle? textStyleHintText;
  final double? borderRadius;
  final Color? colorBorder;
  final Color? backgroundColor;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final Widget Function(T value)? prefixWidget;

  @override
  Widget build(BuildContext context) {
    if (isSort!) {
      data.sort((a, b) => TiengViet.parse(a.toString())
          .toLowerCase()
          .compareTo(TiengViet.parse(b.toString()).toLowerCase()));
    }
    return Container(
      width: width ?? IZIDimensions.iziSize.width,
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        children: [
          if (label != null)
            Container(
              padding: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_1X,
              ),
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: label,
                  style: labelStyle ??
                      TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        color: ColorResources.BLACK,
                      ),
                  children: [
                    if (isRequired!)
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      )
                    else
                      const TextSpan(),
                  ],
                ),
              ),
            ),
          SizedBox(
            // height: height ?? 49,
            // decoration: BoxDecoration(
            //   boxShadow: IZIOther().boxShadow,
            // ),
            // margin: EdgeInsets.only(
            //   bottom: IZIDimensions.FONT_SIZE_H5,
            // ),
            child: FormField(
              enabled: isEnable!,
              builder: (field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(
                      IZIDimensions.SPACE_SIZE_3X,
                    ),
                    border: OutlineInputBorder(
                      // borderRadius: BorderRadius.circular(
                      //   IZIDimensions.BLUR_RADIUS_3X,
                      // ),
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? IZIDimensions.BLUR_RADIUS_3X,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorBorder ?? ColorResources.WHITE,
                      ),
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? IZIDimensions.BLUR_RADIUS_3X,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorBorder ?? ColorResources.WHITE,
                      ),
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? IZIDimensions.BLUR_RADIUS_3X,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorBorder ?? ColorResources.WHITE,
                      ),
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? IZIDimensions.BLUR_RADIUS_3X,
                      ),
                    ),
                    isDense: true,
                    filled: true,
                    fillColor: backgroundColor ?? ColorResources.WHITE,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<T>(
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BLUR_RADIUS_3X,
                      ),
                      autofocus: true,
                      onTap: () {},
                      hint: Text(
                        hint!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: textStyleHintText,
                      ),
                      value: value,
                      selectedItemBuilder: selectedItemBuilder,
                      style: textStyleValue ??
                          TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_SPAN,
                            color: ColorResources.BLACK,
                          ),
                      isDense: true,
                      isExpanded: true,
                      onChanged: isEnable!
                          ? (val) {
                              onChanged!(val);
                            }
                          : null,
                      items: data
                          .map(
                            (e) => DropdownMenuItem<T>(
                              value: e,
                              child: prefixWidget != null
                                  ? prefixWidget!(e)
                                  : Text(
                                      e.toString(),
                                      maxLines: 3,
                                      style: TextStyle(
                                        color: value.hashCode == e.hashCode
                                            ? ColorResources.PRIMARY_5
                                            : ColorResources.BLACK,
                                        fontWeight: value.hashCode == e.hashCode
                                            ? FontWeight.w400
                                            : FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
