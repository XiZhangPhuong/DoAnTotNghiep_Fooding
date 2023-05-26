import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/model/comment/comment_reponse.dart';

class CommentRepostitory{
   ///
   /// get all Comment
   ///
   Future<void> getAllComment({
    required Function(List<CommentRequets> data) onSucess,
    required Function(dynamic e) onError,
   }) async {
     try{
       final ref = await FirebaseFirestore.instance.collection('comments')
       .where('typeUser',isEqualTo: 'SHIPPER')
       .get();
       List<CommentRequets> listComment = ref.docs.map((e) => CommentRequets.fromMap(e.data())).toList();
       onSucess(listComment);
     }catch(e){
       onError(e);
     }
   }
}