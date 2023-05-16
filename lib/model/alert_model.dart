class Alerts {
  final String alertid;
  final String title;
  final String date;
  final String description;
  final DateTime datePublished;

  Alerts(
      {required this.alertid,
      required this.title,
      required this.date,
      required this.description,
      required this.datePublished});

  Map<String, dynamic> getJson() {
    return {
      "title": title,
      "description": description,
      "date": date,
      "alertid": alertid,
      "datePublished": datePublished,
    };
  }

  factory Alerts.getModelFromJson({required Map<String, dynamic> json}) {
    return Alerts(
      title: json["title"],
      description: json["description"],
      date: json["date"],
      alertid: json["alertid"],
      datePublished: json["datePublished"],
    );
  }
}
