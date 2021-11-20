import 'dart:convert';

class AttendenceReqSingleModel {
  String date;
  String reason;
  AttendenceReqSingleModel({
    required this.date,
    required this.reason,
  });

  AttendenceReqSingleModel copyWith({
    String? date,
    String? reason,
  }) {
    return AttendenceReqSingleModel(
      date: date ?? this.date,
      reason: reason ?? this.reason,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reason': reason,
    };
  }

  factory AttendenceReqSingleModel.fromMap(Map<String, dynamic> map) {
    return AttendenceReqSingleModel(
      date: map['date'],
      reason: map['reason'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendenceReqSingleModel.fromJson(String source) =>
      AttendenceReqSingleModel.fromMap(json.decode(source));

  @override
  String toString() => 'AttendenceReqSingleModel(date: $date, reason: $reason)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AttendenceReqSingleModel &&
        other.date == date &&
        other.reason == reason;
  }

  @override
  int get hashCode => date.hashCode ^ reason.hashCode;
}
