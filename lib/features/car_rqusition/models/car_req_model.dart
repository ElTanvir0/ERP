import 'dart:convert';

class CarReqRequisitionModel {
  String requisition_date;
  String from_time;
  String requisition_duration;
  String destination_from;
  String? from_other;
  String destination_to;
  String? to_other;
  String note;
  String car_id;
  CarReqRequisitionModel({
    required this.requisition_date,
    required this.from_time,
    required this.requisition_duration,
    required this.destination_from,
    this.from_other,
    required this.destination_to,
    this.to_other,
    required this.note,
    required this.car_id,
  });

  CarReqRequisitionModel copyWith({
    String? requisition_date,
    String? from_time,
    String? requisition_duration,
    String? destination_from,
    String? from_other,
    String? destination_to,
    String? to_other,
    String? note,
    String? car_id,
  }) {
    return CarReqRequisitionModel(
      requisition_date: requisition_date ?? this.requisition_date,
      from_time: from_time ?? this.from_time,
      requisition_duration: requisition_duration ?? this.requisition_duration,
      destination_from: destination_from ?? this.destination_from,
      from_other: from_other ?? this.from_other,
      destination_to: destination_to ?? this.destination_to,
      to_other: to_other ?? this.to_other,
      note: note ?? this.note,
      car_id: car_id ?? this.car_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'requisition_date': requisition_date,
      'from_time': from_time,
      'requisition_duration': requisition_duration,
      'destination_from': destination_from,
      'from_other': from_other,
      'destination_to': destination_to,
      'to_other': to_other,
      'note': note,
      'car_id': car_id,
    };
  }

  factory CarReqRequisitionModel.fromMap(Map<String, dynamic> map) {
    return CarReqRequisitionModel(
      requisition_date: map['requisition_date'],
      from_time: map['from_time'],
      requisition_duration: map['requisition_duration'],
      destination_from: map['destination_from'],
      from_other: map['from_other'] != null ? map['from_other'] : null,
      destination_to: map['destination_to'],
      to_other: map['to_other'] != null ? map['to_other'] : null,
      note: map['note'],
      car_id: map['car_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CarReqRequisitionModel.fromJson(String source) =>
      CarReqRequisitionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CarReqRequisitionModel(requisition_date: $requisition_date, from_time: $from_time, requisition_duration: $requisition_duration, destination_from: $destination_from, from_other: $from_other, destination_to: $destination_to, to_other: $to_other, note: $note, car_id: $car_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarReqRequisitionModel &&
        other.requisition_date == requisition_date &&
        other.from_time == from_time &&
        other.requisition_duration == requisition_duration &&
        other.destination_from == destination_from &&
        other.from_other == from_other &&
        other.destination_to == destination_to &&
        other.to_other == to_other &&
        other.note == note &&
        other.car_id == car_id;
  }

  @override
  int get hashCode {
    return requisition_date.hashCode ^
        from_time.hashCode ^
        requisition_duration.hashCode ^
        destination_from.hashCode ^
        from_other.hashCode ^
        destination_to.hashCode ^
        to_other.hashCode ^
        note.hashCode ^
        car_id.hashCode;
  }
}
