class PetShow {
  final String psid; //pet show id
  final String name;
  final String location;
  final String date;
  final String time;
  final String description;
  final String imageUrl;
  final DateTime datePublished;

  PetShow(
      {required this.psid,
      required this.name,
      required this.location,
      required this.date,
      required this.time,
      required this.description,
      required this.imageUrl,
      required this.datePublished});

  Map<String, dynamic> getJson() {
    return {
      "name": name,
      "description": description,
      "time": time,
      "date": date,
      "location": location,
      "psid": psid,
      "datePublished": datePublished,
      'imageUrl': imageUrl,
    };
  }

  factory PetShow.getModelFromJson({required Map<String, dynamic> json}) {
    return PetShow(
      name: json["name"],
      description: json["description"],
      time: json["time"],
      date: json["date"],
      location: json["location"],
      psid: json["psid"],
      datePublished: json["datePublished"],
      imageUrl: json['imageUrl'],
    );
  }
}
