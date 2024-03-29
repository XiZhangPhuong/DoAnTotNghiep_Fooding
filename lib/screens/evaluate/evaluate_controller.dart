// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/comment/comment_request.dart';
import 'package:fooding_project/model/order/order.dart';
import 'package:fooding_project/model/product/product_new.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/comment_repository.dart';
import 'package:fooding_project/repository/order_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/screens/review_food/review_food_controller.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class EvaluateController extends GetxController {
  OrderResponse orderResponse = OrderResponse();
  List<String> listArgument = Get.arguments as List<String>;
  String idOrder = '';
  String idProduct = '';
  String idShipper = '';
  String type = '';
  final CommentRepository _commentRepository = GetIt.I.get<CommentRepository>();
  TextEditingController editingController = TextEditingController();
  final _orderRepository = GetIt.I.get<OrderResponsitory>();
  final _userRepository = GetIt.I.get<UserRepository>();
  bool isLoadingOrder = false;
  bool satisFied = true;
  double countRating = 0;
  User userResponse = User();
  File? imageFile;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<File> listImageFile = [];
  Products products = Products();
  @override
  void onInit() {
    super.onInit();
    idOrder = listArgument[0];
    idProduct = listArgument[1];
    idShipper = listArgument[2];
    type = listArgument[3];
    findOrderDetail();
    _findUser();
  }

  ///
  /// fint user
  ///
  Future<void> _findUser() async {
    userResponse = await _userRepository.findbyId(idUser: idShipper);
  }

  ///
  /// click satisField
  ///
  void clickSatisField() {
    satisFied = !satisFied;
    update();
  }

  ///
  ///
  ///
  String convertsatisFied() {
    if (satisFied) {
      return 'Hài lòng';
    } else {
      return 'Không hài lòng';
    }
  }

  ///
  /// Pick avatar.
  ///
  Future<void> pickAvatar() async {
    final images = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (images == null) return;
    imageFile = File(images.path);
    listImageFile.add(imageFile!);
    isLoadingOrder = true;
    update();
  }

  // upload firesore list image string
  Future<List<String>> uploadImagesToStorage(List<File> images) async {
    List<String> downloadUrls = [];

    for (File image in images) {
      Reference ref = _storage
          .ref()
          .child('profilePics')
          .child(sl<SharedPreferenceHelper>().getIdUser);
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
  }

  ///
  /// click rating bar
  ///
  void clickRatingBar(double value) {
    countRating = value.toDouble();
    update();
  }

  ///
  /// find order by id
  ///
  Future<void> findOrderDetail() async {
    _orderRepository.getOrder(
      idOrder: idOrder,
      onSuccess: (onSuccess) async {
        orderResponse = onSuccess.first;
        for(Products i in orderResponse.listProduct!){
          if(idProduct==i.id){
            products = i;
          }
        }
        isLoadingOrder = true;
        update();
      },
      onError: (erorr) {
        print(erorr.toString());
      },
      statusOrder: '',
    );
  }

  ///
  /// post Comment
  ///
  Future<void> postComment(String typeUser) async {
    if (countRating == 0) {
      IZIAlert().error(message: 'Bạn chưa chọn số sao');
      return;
    }
    String idComment = const Uuid().v1();
    EasyLoading.show(status: 'Đang cập nhập');
    final CommentRequets _commentRequest = CommentRequets();
    _commentRequest.id = idComment;
    _commentRequest.idUser = sl<SharedPreferenceHelper>().getIdUser;
    _commentRequest.idStore = orderResponse.listProduct![0].idUser!;
    _commentRequest.idOrder = orderResponse.id;
    _commentRequest.satisFied = convertsatisFied();
    _commentRequest.idShipper = idShipper;
    _commentRequest.idProduct = idProduct;
    if (typeUser == 'SHIPPER') {
      _commentRequest.typeUser = 'SHIPPER';
    } else {
      _commentRequest.typeUser = 'PRODUCT';
    }

    _commentRequest.timeComment =
        DateFormat('HH:mm dd/MM/yyyy').format(DateTime.now());
    IZIValidate.nullOrEmpty(editingController.text)
        ? ''
        : _commentRequest.content = editingController.text;
    _commentRequest.rating = countRating.toDouble();
    if (listImageFile.isNotEmpty) {
      _commentRequest.listImage = await uploadImagesToStorage(listImageFile);
    }
    await _commentRepository.addComment(
      id: idComment,
      request: _commentRequest,
      onSucces: () {
        EasyLoading.dismiss();
 
        IZIAlert().success(message: 'Đánh giá thành công');
        Get.find<ReviewFoodController>().findOrder();
        Get.find<ReviewFoodController>().update();
        Get.back();
      },
      onError: (error) {
        EasyLoading.dismiss();
        print(error);
      },
    );
  }

  ///
  /// String checkPrice Or BienSoXe
  ///
  String checkPrice(String type){
     String str  = '';
     if(type=='PRODUCT'){
       if(products.priceDiscount==0){
        str = '${IZIPrice.currencyConverterVND(products.price!.toDouble())} đ';
       }else{
        str = '${IZIPrice.currencyConverterVND(products.priceDiscount!.toDouble())} đ';
       }
     }else{
       if(!IZIValidate.nullOrEmpty(userResponse.idVehicle)){
         str = 'Biển số xe : ${userResponse.idVehicle}';
       }
     }
    return str;
  }
}
