import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/model/store/store.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/utils/app_constants.dart';

class ProductsRepository{
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    CollectionReference collectionProduct  = FirebaseFirestore.instance.collection("products");
    CollectionReference collectionStore = FirebaseFirestore.instance.collection("users");

    ///
    /// push list product
    ///
    void pushListProduct(){
       List<Products> listProduct = [
        Products(id: generateRandomString(20),idUser: ''),
       ];
    } 
    
}