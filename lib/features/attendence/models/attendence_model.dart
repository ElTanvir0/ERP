import 'dart:convert';

class AttendenceModel {
  String? attendance;
  String? days;
  String? month;
  String? years;
  AttendenceModel({
    this.attendance,
    this.days,
    this.month,
    this.years,
  });

  AttendenceModel copyWith({
    String? attendance,
    String? days,
    String? month,
    String? years,
  }) {
    return AttendenceModel(
      attendance: attendance ?? this.attendance,
      days: days ?? this.days,
      month: month ?? this.month,
      years: years ?? this.years,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attendance': attendance,
      'days': days,
      'month': month,
      'years': years,
    };
  }

  factory AttendenceModel.fromMap(Map<String, dynamic> map) {
    return AttendenceModel(
      attendance: map['attendance'] != null ? map['attendance'] : null,
      days: map['days'] != null ? map['days'] : null,
      month: map['month'] != null ? map['month'] : null,
      years: map['years'] != null ? map['years'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendenceModel.fromJson(String source) =>
      AttendenceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AttendenceModel(attendance: $attendance, days: $days, month: $month, years: $years)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AttendenceModel &&
        other.attendance == attendance &&
        other.days == days &&
        other.month == month &&
        other.years == years;
  }

  @override
  int get hashCode {
    return attendance.hashCode ^
        days.hashCode ^
        month.hashCode ^
        years.hashCode;
  }
}
