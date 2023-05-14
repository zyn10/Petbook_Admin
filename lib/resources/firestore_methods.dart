import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:petbook_admin/model/petshow_model.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// //getname and adress
//   Future getNameAndAddress() async {
//     DocumentSnapshot snap =
//         await _firestore.collection("users").doc(_auth.currentUser!.uid).get();

//     UserDetailsModel userModel = UserDetailsModel.getModelFromJson(
//       (snap.data() as dynamic),
//     );

//     return userModel;
//   }
  Future<String> uploadPetShowInfo({
    required String name,
    required String location,
    required String date,
    required String time,
    required String description,
    required Uint8List? image,
  }) async {
    String output = "Something went wrong";

    if (image != null &&
        name != "" &&
        location != "" &&
        date != "" &&
        time != "" &&
        description != "") {
      try {
        String psid = const Uuid().v1();
        String url = await uploadImageToDatabase(image: image, uid: psid);

        PetShow petShow = PetShow(
          psid: psid,
          name: name,
          location: location,
          date: date,
          time: time,
          description: description,
          imageUrl: url,
          datePublished: DateTime.now(),
        );

        await _firestore.collection("petShow").doc(psid).set(petShow.getJson());
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields are not empty";
    }

    return output;
  }

  Future<String> uploadImageToDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("petshows").child(uid);
    UploadTask uploadToask = storageRef.putData(image);
    TaskSnapshot task = await uploadToask;
    return task.ref.getDownloadURL();
  }

  // Delete PetShow
  Future<String> deletePetShow(String petshowId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('petShow').doc(petshowId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
