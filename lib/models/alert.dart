class Alert {
  int id;
  String type;
  int petId;
  String detection;
  num confidence;
  String img;
  String date;

  Alert({
    required this.id,
    required this.type,
    required this.petId,
    required this.detection,
    required this.confidence,
    required this.img,
    required this.date,
  });
}
