import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

//sign up user
  Future<String> insertPetShow({
    required String name,
    required String location,
    required String date,
    required String time,
    required String description,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (name.isNotEmpty ||
          location.isNotEmpty ||
          date.isNotEmpty ||
          time.isNotEmpty ||
          description.isNotEmpty ||
          // ignore: unnecessary_null_comparison
          file != null) {
 

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('petShowsImages', file, false);
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          fullname: fullname,
          address: address,
        );
        await _firestore.collection("petShows").doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = 'success';
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = "invalid email";
      } else if (err.code == 'email-already-in-use') {
        res = "Account Already exists";
      } else if (err.code == 'weak-password') {
        res = "Password Provided is too Weak";
      } else {
        res = "Something Went Wrong!";
      }
    }
    return res;
  }

}
