class NGO {
  final String ngoid;
  final String title;
  final String location;
  final String ph;
  final String description;
  final String imageUrl;
  final DateTime datePublished;

  NGO(
      {required this.ngoid,
      required this.title,
      required this.location,
      required this.ph,
      required this.description,
      required this.imageUrl,
      required this.datePublished});

  Map<String, dynamic> getJson() {
    return {
      "title": title,
      "description": description,
      "ph": ph,
      "location": location,
      "ngoid": ngoid,
      "datePublished": datePublished,
      'imageUrl': imageUrl,
    };
  }

  factory NGO.getModelFromJson({required Map<String, dynamic> json}) {
    return NGO(
      title: json["name"],
      description: json["description"],
      ph: json["ph"],
      location: json["location"],
      ngoid: json["ngoid"],
      datePublished: json["datePublished"],
      imageUrl: json['imageUrl'],
    );
  }
}
