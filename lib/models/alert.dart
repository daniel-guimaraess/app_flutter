class Alert {
  String type;
  String detection;
  double confidence;
  String img;
  String date;

  Alert({
    required this.type,
    required this.detection,
    required this.confidence,
    required this.img,
    required this.date,
  });
}
