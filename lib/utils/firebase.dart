import 'package:firebase_database/firebase_database.dart';

class FireBaseDataBase{
  static DatabaseReference dataUser = FirebaseDatabase.instance.ref("User");
}