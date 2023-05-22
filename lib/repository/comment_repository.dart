import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/model/comment/comment_request.dart';

class CommentRepository{

  ///
  /// add Comment
  ///

   Future<void> addComment({
    String? id,
    required CommentRequets request,
    required Function() onSucces,
    required Function(dynamic error) onError,
  }) async {
    try {
     final ref=  await FirebaseFirestore.instance
          .collection("comments")
          .doc(id)
          .set(request.toMap(),);
      onSucces();
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// check Comment
  ///
  Future<void> checkComment({
    required String idUser,
    required String idProduct,
    required Function(bool check) onSuccess,
    required Function(dynamic e) onError,
  }) async {
      try{
       final ref = await FirebaseFirestore.instance.collection('comments')
       .where('idUser',isEqualTo: idUser)
       .where('idProduct',isEqualTo: idProduct).get();
       onSuccess(ref.docs.isNotEmpty);
      }catch(e){
        onError(e);
      }
  }

  ///
  /// get all Comment
  ///
  Future<void> getAllComment(
    {
      required String idProduct,
      required Function(List<CommentRequets> data) onSuccess,
      required Function(dynamic e) onError,
    }
  ) async {
    try{
     final ref = await FirebaseFirestore.instance.collection('comments')
     .where('idProduct',isEqualTo: idProduct)
     .where('typeUser',isEqualTo: 'PRODUCT')
     .get();
     onSuccess(ref.docs.map((e) => CommentRequets.fromMap(e.data())).toList());
    }catch(e){
       onError(e);
    }
  }

  ///
  /// get check
  ///

  Future<void> get(
    {
      required String idOrder,
      required String idUser,
      required Function(List<CommentRequets> data) onSuccess,
      required Function(dynamic e) onError,
    }
  ) async {
    try{
     final ref = await FirebaseFirestore.instance.collection('comments')
     .where('idUser',isEqualTo: idUser)
     .where('idOrder',isEqualTo: idOrder)
     .get();
     onSuccess(ref.docs.map((e) => CommentRequets.fromMap(e.data())).toList());
    }catch(e){
       onError(e);
    }
  }
}