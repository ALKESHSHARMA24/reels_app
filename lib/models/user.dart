import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String profilepics;
  String email;
  String uid;

  User(
      {required this.name,
      required this.email,
      required this.profilepics,
      required this.uid});

    //now in map will do whatever data we pass get from above User it will stroe in map and convert into the
    //json format
  Map<String, dynamic> toJson() => {
        "name": name,
        "profilepics": profilepics,
        "email": email,
        "uid": uid,
      };
  static User fromSnap(DocumentSnapshot snap) {

    //this snapshot will use for iterating from the data
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        name: snapshot['name'],
        email: snapshot['email'],
        profilepics: snapshot['profilepics'],
        uid: snapshot['uid']);
  }
}
