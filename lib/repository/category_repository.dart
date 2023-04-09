// ignore_for_file: avoid_print, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/model/category/category.dart';

class CategoryRepository{
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    CollectionReference collection  = FirebaseFirestore.instance.collection("categorys");
   ///
   /// Push list Category to FireStore
   ///
   Future<void> pushListCategory() async{
      try{
        List<Category> listCate = [
          Category(id: '1',thumnail: "https://tea-3.lozi.vn/v1/images/resized/category-web-1565-1590397916?w=240&amp;type=s",name: "Cơm"),
          Category(id: '2',thumnail: "https://tea-3.lozi.vn/v1/images/resized/category-web-1533-1590653836?w=240&amp;type=s",name: "Bún|Mì"),
          Category(id: '3',thumnail: "https://tea-3.lozi.vn/v1/images/resized/category-web-21-1590397610?w=240&amp;type=s",name: "Đồ uống"),
          Category(id: '4',thumnail: "https://tea-3.lozi.vn/v1/images/resized/category-web-1164-1590572746?w=240&amp;type=s",name: "Hải sản"),
          Category(id: '5',thumnail: "https://tea-3.lozi.vn/v1/images/resized/category-web-1407-1590396880?w=240&amp;type=s",name: "Đồ ăn nhanh"),
          Category(id: '6',thumnail: "https://st.depositphotos.com/1332722/1245/v/950/depositphotos_12454057-stock-illustration-pizza-vector-illustration.jpg",name: "Ăn vặt"),
          Category(id: '7',thumnail: "https://img.pikbest.com/png-images/qianku/eating-hot-pot-at-home_2400223.png!bw340",name: "Nướng|Lẩu"),
          Category(id: '8',thumnail: "https://tea-3.lozi.vn/v1/images/resized/category-web-77-1617002219?w=240&amp;type=s",name: "Món nhậu"),
                  
        ];
         for (var element in listCate) {
           await  collection.doc().set(element.toMap());
        }
      }catch(e){
         print("Thêm dữ liệu Danh mục thất bại  $e");
      }
   }

   ///
   /// getListCategory
   ///
   Future<void> getListCategory()async{
     try{

     }catch(e){
       print("Lấy dữ liệu Danh mục thất bại  $e");  
     }
   }
}