import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooding_project/model/product/products.dart';

class ProductsRepository {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  CollectionReference collectionProduct =
      FirebaseFirestore.instance.collection("products");
  CollectionReference collectionStore =
      FirebaseFirestore.instance.collection("users");

  ///
  /// delete product
  ///

  Future<void> deleteCartDocumentAndSubcollections(String idUser) async {
    final cartRef = FirebaseFirestore.instance.collection('carts').doc(idUser);
    await cartRef.collection('listProduct').get().then((listProductSnap) {
      for (var listProductDoc in listProductSnap.docs) {
        listProductDoc.reference.delete();
      }
    });
    await cartRef.delete();
  }

  ///
  /// add list cart
  ///
  Future<void> pushDataProduct(List<Products> listProducts) async {
    for (var i in listProducts) {
      await collectionProduct.doc(i.id!).set(i.toMap());
    }
  }

  // Xóa document trong collection "Cart" theo "idUser"
  Future<void> deleteCartByUserId(String idUser) async {
    final cartRef = FirebaseFirestore.instance.collection('carts').doc(idUser);
    await cartRef.delete();
  }

  ///
  /// get data products filter name category
  ///
  Future<List<Products>> getProductList(String nameCategpry) async {
    List<Products> listProducts = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('nameCategory', isEqualTo: nameCategpry)
        .get();
    for (var element in querySnapshot.docs) {
      Products products =
          Products.fromMap(element.data() as Map<String, dynamic>);
      listProducts.add(products);
    }
    return listProducts;
  }

  ///
  /// get all list product
  ///
  Future<void> getAllListProduct({
    required Function(List<Products> listProduct) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try{
      QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('products').get();
       onSucess(querySnapshot.docs.map((e) => Products.fromMap(e.data() as Map<String,dynamic>)).toList());
    }catch(e){
       onError(e);
    }
  }

  ///
  /// get list product paginate page = 1 , limit = 10
  ///
  Future<void> paginateProducts({
    required Function(List<Products> listProduct) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try{
      QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('products').limit(10).get();
       onSucess(querySnapshot.docs.map((e) => Products.fromMap(e.data() as Map<String,dynamic>)).toList());
    }catch(e){
       onError(e);
    }
  }

  

}





