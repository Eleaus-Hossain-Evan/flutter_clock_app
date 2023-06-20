class AlarmInfo {
  int? id;
  DateTime alarmDateTime;
  String title;
  bool isPending;
  int gradientColorIndex;

  AlarmInfo({
    this.id,
    required this.alarmDateTime,
    required this.title,
    this.isPending = true,
    this.gradientColorIndex = 0,
  });

  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
        id: json["id"],
        title: json["title"],
        alarmDateTime: DateTime.parse(json["alarmDateTime"]),
        isPending: json["isPending"] == 1,
        gradientColorIndex: json["gradientColorIndex"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "alarmDateTime": alarmDateTime.toIso8601String(),
        "isPending": isPending == true ? 1 : 0,
        "gradientColorIndex": gradientColorIndex,
      };
}
