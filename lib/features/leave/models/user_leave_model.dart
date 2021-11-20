import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';

class UserLeaveModel {
  UserController _userController = Get.find<UserController>();
  String? id;
  String? unique_id;
  String? e_db_id;
  String? employee_id;
  String? start_days;
  String? how_many_days;
  String? end_date;
  String? hold_unhold;
  String? days;
  String? month;
  String? year;
  String? note;
  String? status;
  String? h_aproval;
  String? h_id;
  String? aproval;
  String? uploader_info;
  String? data;
  UserLeaveModel({
    this.id = '',
    this.unique_id,
    this.e_db_id,
    this.employee_id,
    this.start_days,
    this.how_many_days,
    this.end_date,
    this.hold_unhold,
    this.days,
    this.month,
    this.year,
    this.note,
    this.status = '1',
    this.h_aproval,
    this.h_id,
    this.aproval = '0',
    this.uploader_info,
    this.data,
  });

  var formatedPresentDate = DateFormat.yMd().format(DateTime.now());

  Map<String, dynamic> toMapForEveryDayLeavLogTable() {
    Map<String, dynamic> map = Map<String, dynamic>();
    var presentDat = DateTime.now();
    var formatedPresentDate = DateFormat('dd/MM/yyyy').format(presentDat);
    //  "id": "58",
    //     "unique_id": "239572678157494080",
    //     "h_days": "1",
    //     "days": "09",
    //     "month": "07",
    //     "year": "2021",
    //     "date_full": "09/07/2021",
    //     "status": "1",
    //     "uploader_info": "Super Admin___2010mdibrahim@gmail.com___BAR_011220_210463187872898170_1606780607",
    //     "data": "03/07/2021"

    map['unique_id'] = this.unique_id;
    map['h_days'] = '1';
    // map['days'] = this.day;
    // map['month'] = this.month;
    // map['year'] = this.year;

    map['status'] = '1';
    map['uploader_info'] = _userController.getUploaderInfo();
    map['data'] = formatedPresentDate;

    return map;
  }

  UserLeaveModel copyWith({
    String? id,
    String? unique_id,
    String? e_db_id,
    String? employee_id,
    String? start_days,
    String? how_many_days,
    String? end_date,
    String? hold_unhold,
    String? days,
    String? month,
    String? year,
    String? note,
    String? status,
    String? h_aproval,
    String? h_id,
    String? aproval,
    String? uploader_info,
    String? data,
  }) {
    return UserLeaveModel(
      id: id ?? this.id,
      unique_id: unique_id ?? this.unique_id,
      e_db_id: e_db_id ?? this.e_db_id,
      employee_id: employee_id ?? this.employee_id,
      start_days: start_days ?? this.start_days,
      how_many_days: how_many_days ?? this.how_many_days,
      end_date: end_date ?? this.end_date,
      hold_unhold: hold_unhold ?? this.hold_unhold,
      days: days ?? this.days,
      month: month ?? this.month,
      year: year ?? this.year,
      note: note ?? this.note,
      status: status ?? this.status,
      h_aproval: h_aproval ?? this.h_aproval,
      h_id: h_id ?? this.h_id,
      aproval: aproval ?? this.aproval,
      uploader_info: uploader_info ?? this.uploader_info,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unique_id': unique_id,
      'e_db_id': e_db_id,
      'employee_id': employee_id,
      'start_days': start_days,
      'how_many_days': how_many_days,
      'end_date': end_date,
      'hold_unhold': hold_unhold,
      'days': days,
      'month': month,
      'year': year,
      'note': note,
      'status': status,
      'h_aproval': h_aproval,
      'h_id': h_id,
      'aproval': aproval,
      'uploader_info': uploader_info,
      'data': data,
    };
  }

  factory UserLeaveModel.fromMap(Map<String, dynamic> map) {
    return UserLeaveModel(
      id: map['id'],
      unique_id: map['unique_id'],
      e_db_id: map['e_db_id'],
      employee_id: map['employee_id'],
      start_days: map['start_days'],
      how_many_days: map['how_many_days'],
      end_date: map['end_date'],
      hold_unhold: map['hold_unhold'],
      days: map['days'],
      month: map['month'],
      year: map['year'],
      note: map['note'],
      status: map['status'],
      h_aproval: map['h_aproval'],
      h_id: map['h_id'],
      aproval: map['aproval'],
      uploader_info: map['uploader_info'],
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLeaveModel.fromJson(String source) =>
      UserLeaveModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserLeaveModel(id: $id, unique_id: $unique_id, e_db_id: $e_db_id, employee_id: $employee_id, start_days: $start_days, how_many_days: $how_many_days, end_date: $end_date, hold_unhold: $hold_unhold, days: $days, month: $month, year: $year, note: $note, status: $status, h_aproval: $h_aproval, h_id: $h_id, aproval: $aproval, uploader_info: $uploader_info, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserLeaveModel &&
        other.id == id &&
        other.unique_id == unique_id &&
        other.e_db_id == e_db_id &&
        other.employee_id == employee_id &&
        other.start_days == start_days &&
        other.how_many_days == how_many_days &&
        other.end_date == end_date &&
        other.hold_unhold == hold_unhold &&
        other.days == days &&
        other.month == month &&
        other.year == year &&
        other.note == note &&
        other.status == status &&
        other.h_aproval == h_aproval &&
        other.h_id == h_id &&
        other.aproval == aproval &&
        other.uploader_info == uploader_info &&
        other.data == data;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        unique_id.hashCode ^
        e_db_id.hashCode ^
        employee_id.hashCode ^
        start_days.hashCode ^
        how_many_days.hashCode ^
        end_date.hashCode ^
        hold_unhold.hashCode ^
        days.hashCode ^
        month.hashCode ^
        year.hashCode ^
        note.hashCode ^
        status.hashCode ^
        h_aproval.hashCode ^
        h_id.hashCode ^
        aproval.hashCode ^
        uploader_info.hashCode ^
        data.hashCode;
  }
}
