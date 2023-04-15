import 'package:flutter/material.dart';
import 'package:fooding_project/helper/izi_date.dart';
import 'package:fooding_project/screens/components/button_app.dart';
import 'package:fooding_project/screens/profile/edit_profile/edit_profile_controller.dart';
import 'package:get/get.dart';

import '../../../base_widget/izi_image.dart';
import '../../../base_widget/izi_input.dart';
import '../../../base_widget/izi_text.dart';
import '../../../helper/izi_dimensions.dart';
import '../../../helper/izi_validate.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/images_path.dart';
import '../../widgets/app_bar.dart';

class EditProfilePage extends GetView {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFooding(
        title: "Chỉnh sửa thông tin cá nhân",
        isLeading: true,
      ),
      body: GetBuilder(
        init: EditProfileController(),
        builder: (EditProfileController controller) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await controller.pickAvatar();
                    },
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorResources.WHITE,
                                width: 3,
                              ),
                            ),
                            height: IZIDimensions.SPACE_SIZE_5X * 5,
                            width: IZIDimensions.SPACE_SIZE_5X * 5,
                            child: Center(
                              child: ClipOval(
                                child: IZIValidate.nullOrEmpty(
                                  controller.imageFile,
                                )
                                    ? !IZIValidate.nullOrEmpty(
                                            controller.profileCTL.user!.avatar)
                                        ? IZIImage(
                                            controller.profileCTL.user!.avatar!,
                                            height:
                                                IZIDimensions.SPACE_SIZE_5X *
                                                    4.5,
                                            width: IZIDimensions.SPACE_SIZE_5X *
                                                4.5,
                                          )
                                        : Icon(
                                            Icons.person,
                                            size: IZIDimensions.SPACE_SIZE_5X *
                                                4.5,
                                            color: Colors.grey,
                                          )
                                    : IZIImage.file(
                                        controller.imageFile,
                                        height:
                                            IZIDimensions.SPACE_SIZE_5X * 4.5,
                                        width:
                                            IZIDimensions.SPACE_SIZE_5X * 4.5,
                                      ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: IZIDimensions.ONE_UNIT_SIZE * 10,
                            child: Container(
                              padding: EdgeInsets.all(
                                  IZIDimensions.SPACE_SIZE_1X * 0.7),
                              margin: EdgeInsets.only(
                                top: IZIDimensions.ONE_UNIT_SIZE * 150,
                                left: IZIDimensions.ONE_UNIT_SIZE * 150,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      IZIDimensions.BORDER_RADIUS_3X),
                                  color: ColorResources.WHITE),
                              child: Icon(
                                Icons.camera_alt,
                                size: IZIDimensions.ONE_UNIT_SIZE * 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: IZIDimensions.iziSize.width,
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_3X,
                      vertical: IZIDimensions.SPACE_SIZE_5X,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IZIText(
                              text: 'Họ và tên',
                              style: TextStyle(
                                color: ColorResources.BLACK,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                              ),
                            ),
                            Text(
                              " *",
                              style: TextStyle(
                                color: ColorResources.colorAccountRed,
                                fontSize: IZIDimensions.FONT_SIZE_H4,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        IZIInput(
                          type: IZIInputType.TEXT,
                          borderRadius: IZIDimensions.SPACE_SIZE_2X,
                          textInputAction: TextInputAction.next,
                          placeHolder: 'Ngo Tam Thanh',
                          initValue: controller.txtName.text,
                          onChanged: (value) {
                            controller.txtName.text = value;
                          },
                          hintStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                          ),
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        Row(
                          children: [
                            IZIText(
                              text: 'Số điện thoại',
                              style: TextStyle(
                                color: ColorResources.BLACK,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                              ),
                            ),
                            Text(
                              " *",
                              style: TextStyle(
                                color: ColorResources.colorAccountRed,
                                fontSize: IZIDimensions.FONT_SIZE_H4,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        IZIInput(
                          isReadOnly: true,
                          textInputAction: TextInputAction.next,
                          type: IZIInputType.PHONE,
                          borderRadius: IZIDimensions.SPACE_SIZE_2X,
                          placeHolder: '02457512012',
                          initValue: controller.txtPhone.text,
                          onChanged: (value) {
                            controller.txtPhone.text = value;
                          },
                          hintStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                          ),
                        ),

                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_2X,
                        ),

                        Row(
                          children: [
                            Text(
                              "Ngày sinh",
                              style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                                fontWeight: FontWeight.w700,
                                color: ColorResources.BLACK,
                                fontFamily: 'Nunito',
                              ),
                            ),
                            Text(
                              " *",
                              style: TextStyle(
                                color: ColorResources.colorAccountRed,
                                fontSize: IZIDimensions.FONT_SIZE_H4,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          child: IZIInput(
                            borderRadius: IZIDimensions.BORDER_RADIUS_3X,
                            placeHolder: controller.dateOfBirth,
                            type: IZIInputType.TEXT,
                            disbleError: true,
                            isDatePicker: true,
                            iziPickerDate: IZIPickerDate.CUPERTINO,
                            maximumDate:
                                DateTime.now().add(const Duration(hours: 1)),
                            onChanged: (val) {
                              controller.dateOfBirth = val;
                            },
                            hintStyle: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                              color: ColorResources.BLACK,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IZIText(
                              text: 'Email',
                              style: TextStyle(
                                color: ColorResources.BLACK,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                              ),
                            ),
                            Text(
                              " *",
                              style: TextStyle(
                                color: ColorResources.colorAccountRed,
                                fontSize: IZIDimensions.FONT_SIZE_H4,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        IZIInput(
                          type: IZIInputType.EMAIL,
                          borderRadius: IZIDimensions.SPACE_SIZE_2X,
                          placeHolder: 'kymonos1@gmail.com',
                          initValue: controller.txtEmail.text,
                          onChanged: (value) {
                            controller.txtEmail.text = value;
                          },
                          hintStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                          ),
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        IZIText(
                          text: 'Giới tính',
                          style: TextStyle(
                            color: ColorResources.BLACK,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                          ),
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        Container(
                          height: IZIDimensions.SPACE_SIZE_5X * 3,
                          width: IZIDimensions.iziSize.width,
                          padding: EdgeInsets.only(
                              right: IZIDimensions.SPACE_SIZE_2X),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  IZIDimensions.BORDER_RADIUS_4X),
                              color: const Color.fromRGBO(255, 255, 255, 1)),
                          child: Center(
                            child: DropdownButton(
                              isExpanded: true,
                              underline: const SizedBox(),
                              icon: const Icon(Icons.arrow_drop_down_outlined),
                              elevation: 0,
                              value: controller.selectedType,
                              items: controller.dropdownText.map(
                                (e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: IZIDimensions.SPACE_SIZE_5X,
                                      ),
                                      width: IZIDimensions.SPACE_SIZE_5X * 14,
                                      child: Text(
                                        e.toString(),
                                        style: TextStyle(
                                          fontSize: IZIDimensions.FONT_SIZE_H6,
                                          color: ColorResources.BLACK,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Nunito',
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                controller.setSelected(value.toString());
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_5X * 3,
                        ),
                        // Button start.
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomSheet: MediaQuery.of(context).viewInsets.bottom > 0
          ? const SizedBox()
          : GetBuilder(
              builder: (EditProfileController controller) => Container(
                margin: EdgeInsets.only(
                  bottom: IZIDimensions.SPACE_SIZE_2X,
                ),
                width: IZIDimensions.iziSize.width,
                height: IZIDimensions.ONE_UNIT_SIZE * 90,
                child: Center(
                  child: ButtonFooding(
                    text: "Lưu",
                    ontap: () {
                      controller.updateAccount();
                    },
                    border: IZIDimensions.BORDER_RADIUS_4X,
                  ),
                ),
              ),
            ),
    );
  }
}
