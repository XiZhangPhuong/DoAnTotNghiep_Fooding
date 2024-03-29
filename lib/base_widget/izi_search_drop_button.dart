// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:tiengviet/tiengviet.dart';
// import '../helper/izi_dimensions.dart';
// import '../helper/izi_number.dart';
// import '../helper/izi_other.dart';
// import '../helper/izi_validate.dart';
// import '../utils/color_resources.dart';

// class SearchDropDownButton<T> extends StatelessWidget {
//   const SearchDropDownButton({
//     Key? key,
//     this.hint = "",
//     this.onChanged,
//     required this.data,
//     required this.width,
//     required this.value,
//     this.label,
//     this.customHintText = false,
//     required this.isRequired,
//     this.paddingTop = 0,
//     this.isColorFieldWhite = false,
//     this.isEnable = true,
//     this.isHideLineButton = false,
//     this.padding,
//     this.fillColor,
//     this.smallSizeHintText = false,
//     this.valueClearSelected,
//     this.contentPadding,
//     this.focusNode,
//     this.fontSize,
//     this.highLightHint = false,
//     this.isSort = true,
//     this.colorBorder,
//     this.isBoxShadow = false,
//     this.hintStyle,
//     this.borderRadius,
//   }) : super(key: key);
//   final String? hint;
//   final double width;
//   final Function(T? value)? onChanged;
//   final String? label;
//   final bool? isRequired;
//   final List<T> data;
//   final double? paddingTop;
//   final bool? isColorFieldWhite, isSort;
//   final T? value;
//   final bool? isEnable;
//   final EdgeInsetsGeometry? padding;
//   final bool? isHideLineButton;
//   final Color? fillColor;
//   final Color? colorBorder;
//   final T? valueClearSelected;
//   final EdgeInsetsGeometry? contentPadding;
//   final FocusNode? focusNode;
//   final double? fontSize;
//   final bool? highLightHint, smallSizeHintText, customHintText;
//   final bool? isBoxShadow;
//   final TextStyle? hintStyle;
//   final int? borderRadius;

//   @override
//   Widget build(BuildContext context) {
//     //sort list
//     if (isSort!) {
//       sortWithClearSelected();
//     }

//     return Container(
//       // height: 55,
//       width: width,
//       padding: padding ?? EdgeInsets.zero,

//       child: Column(
//         children: [
//           if (label != null)
//             Container(
//               padding: EdgeInsets.only(
//                 bottom: IZIDimensions.SPACE_SIZE_1X,
//               ),
//               alignment: Alignment.centerLeft,
//               child: RichText(
//                 text: TextSpan(
//                   text: label,
//                   style: hintStyle ??
//                       TextStyle(
//                         fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
//                         color: ColorResources.BLACK,
//                       ),
//                   children: [
//                     if (isRequired!)
//                       TextSpan(
//                         text: '*',
//                         style: TextStyle(
//                           fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.red,
//                         ),
//                       )
//                     else
//                       const TextSpan(),
//                   ],
//                 ),
//               ),
//             )
//           else
//             const SizedBox.shrink(),
//           Container(
//             decoration: BoxDecoration(
//               boxShadow: isBoxShadow == false ? null : IZIOther().boxShadow,
//             ),
//             child: DropdownSearch<T>(
//               key: UniqueKey(),
//               enabled: isEnable!,
//               items: data.map((e) => e).toList(),
//               dropdownBuilder: (context, selectedItem) {
//                 return Text(
//                   IZIValidate.nullOrEmpty(value) == false ? selectedItem.toString().replaceAll('Phường', '').replaceAll('Xã', '').replaceAll('Thị trấn', '') : hint!,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: smallSizeHintText == false ? IZIDimensions.FONT_SIZE_H6 : IZIDimensions.FONT_SIZE_H6,
//                     color: value == null
//                         ? ColorResources.NEUTRALS_4
//                         : customHintText == false
//                             ? isEnable! || highLightHint!
//                                 ? ColorResources.BLACK
//                                 : ColorResources.GREY
//                             : ColorResources.GREY,
//                   ),
//                 );
//               },
//               dropdownSearchDecoration: InputDecoration(
//                 hintText: hint,
//                 hintStyle: hintStyle ??
//                     TextStyle(
//                       fontSize: smallSizeHintText == false ? IZIDimensions.FONT_SIZE_SPAN : IZIDimensions.FONT_SIZE_SPAN,
//                       color: highLightHint! ? ColorResources.BLACK : ColorResources.BLACK.withOpacity(0.4),
//                     ),
//                 isDense: true,
//                 filled: true,
//                 fillColor: fillColor ?? ColorResources.WHITE,
//                 contentPadding: contentPadding ??
//                     EdgeInsets.all(
//                       IZIDimensions.SPACE_SIZE_4X,
//                     ),
//                 disabledBorder: OutlineInputBorder(
//                   borderSide: isHideLineButton! ? BorderSide.none : BorderSide(color: colorBorder ?? ColorResources.WHITE),
//                   borderRadius: BorderRadius.circular(borderRadius == 0 ? IZINumber.parseDouble(borderRadius) : IZIDimensions.BLUR_RADIUS_3X),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: isHideLineButton! ? BorderSide.none : BorderSide(color: colorBorder ?? ColorResources.WHITE),
//                   borderRadius: BorderRadius.circular(borderRadius == 0 ? IZINumber.parseDouble(borderRadius) : IZIDimensions.BLUR_RADIUS_3X),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(borderRadius == 0 ? IZINumber.parseDouble(borderRadius) : IZIDimensions.BLUR_RADIUS_3X),
//                   borderSide: isHideLineButton! ? BorderSide.none : BorderSide(color: colorBorder ?? ColorResources.WHITE),
//                 ),
//               ),
//               showAsSuffixIcons: true,
//               dropdownSearchTextAlign: TextAlign.center,
//               dropDownButton: Icon(
//                 Icons.arrow_drop_down,
//                 color: isEnable! ? ColorResources.NEUTRALS_3 : ColorResources.NEUTRALS_5,
//                 size: 24,
//               ),
//               showSearchBox: true,
//               onChanged: (val) {
//                 onChanged!(val);
//               },
//               selectedItem: value,
//               itemAsString: (T? item) => itemAsString(item),
//               filterFn: (T? item, String? filter) => filterFn(item, filter),
//               emptyBuilder: (context, searchEntry) => const Center(child: Text("No data")),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String itemAsString(T? item) {
//     if (item != null) {
//       if (item.runtimeType == String) {
//         return item.toString();
//       } else {
//         return item.toString();
//       }
//     }
//     return 'No data';
//   }

//   bool filterFn(T? item, String? filter) {
//     final _filter = removeVietnameseTones(filter.toString());
//     if (item != null) {
//       if (item.runtimeType == String) {
//         return removeVietnameseTones(item.toString()).contains(_filter);
//       } else {
//         final String _s = removeVietnameseTones(item.toString());
//         return _s.contains(_filter);
//       }
//     }
//     return false;
//   }

//   static String removeVietnameseTones(String str) {
//     final _str = TiengViet.parse(str.toLowerCase()).toLowerCase();
//     return _str;
//   }

//   List sortWithClearSelected() {
//     if (isSort == true) {
//       data.sort((a, b) => TiengViet.parse(a.toString().toLowerCase()).compareTo(TiengViet.parse(b.toString().toLowerCase())));
//     }

//     // if (data.isNotEmpty) {
//     //   final value = data.first;
//     //   if (value.runtimeType == ProvinceResponse) {
//     //     final index = (data as List<ProvinceResponse>).indexWhere(
//     //         (element) => IZIValidate.nullOrEmpty(element.id));
//     //     if (index != -1) {
//     //       data.insert(0, data.removeAt(index));
//     //     }
//     //     return data;
//     //   }
//     // }

//     return data;
//   }
// }
