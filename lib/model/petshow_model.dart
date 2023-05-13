import 'package:cloud_firestore/cloud_firestore.dart';

class PetShow {
  final String psid;//pet show id
  final String name;
  final String location;
  final String date;
  final String time;
  final String description;
  final String imageUrl;
  final DateTime datePublished;

  PetShow({
    required this.psid,
    required this.name,
    required this.location,
    required this.date,
    required this.time,
    required this.description,
    required this.imageUrl,
    required this.datePublished
  });
}

  static PetShow fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PetShow(
        description: snapshot["description"],
        psid: snapshot["psid"],
        name: snapshot["likes"],
        location: snapshot["postId"],
        datePublished: snapshot["datePublished"],
        date: snapshot["date"],
        time: snapshot['time'],
        imageUrl: snapshot['imageUrl']);
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "likes": likes,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'profImage': profImage
      };
}