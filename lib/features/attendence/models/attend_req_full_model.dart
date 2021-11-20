import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'attend_req_single_model.dart';

class AttendReqFullModel {
  String note;
  List<AttendenceReqSingleModel> requests;
  AttendReqFullModel({
    required this.note,
    required this.requests,
  });

  AttendReqFullModel copyWith({
    String? note,
    List<AttendenceReqSingleModel>? requests,
  }) {
    return AttendReqFullModel(
      note: note ?? this.note,
      requests: requests ?? this.requests,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'note': note,
      'requests': requests.map((x) => x.toMap()).toList(),
    };
  }

  factory AttendReqFullModel.fromMap(Map<String, dynamic> map) {
    return AttendReqFullModel(
      note: map['note'],
      requests: List<AttendenceReqSingleModel>.from(
          map['requests']?.map((x) => AttendenceReqSingleModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendReqFullModel.fromJson(String source) =>
      AttendReqFullModel.fromMap(json.decode(source));

  @override
  String toString() => 'AttendReqFullModel(note: $note, requests: $requests)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AttendReqFullModel &&
        other.note == note &&
        listEquals(other.requests, requests);
  }

  @override
  int get hashCode => note.hashCode ^ requests.hashCode;
}
