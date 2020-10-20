import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  var _firstName = '';
  var _lastName = '';
  var _email = '';
  var _imgUrl = '';

  void main() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      _firstName = documentSnapshot.get('First Name');
      _lastName = documentSnapshot.get('Last Name');
      _email = documentSnapshot.get('Email');
    });
  }
}
