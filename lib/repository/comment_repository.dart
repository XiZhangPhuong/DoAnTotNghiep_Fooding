import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/model/comment/comment_request.dart';

class CommentRepository{

  ///
  /// add Comment
  ///

   Future<void> addComment({
    required CommentRequets request,
    required Function() onSucces,
    required Function(dynamic error) onError,
  }) async {
    try {
     final ref=  await FirebaseFirestore.instance
          .collection("comments")
          .doc()
          .set(request.toMap(),);
      onSucces();
    } catch (e) {
      onError(e);
    }
  }
}