import 'dart:convert';

class UserLeaveApprovalModel {
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
  String? full_name;
  String? photo;
  String? d_head;
  String? role_name;
  String? email;
  String? branch;
  String? employee_table_pk;
  String? department;
  UserLeaveApprovalModel({
    this.id,
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
    this.status,
    this.h_aproval,
    this.h_id,
    this.aproval,
    this.uploader_info,
    this.data,
    this.full_name,
    this.photo,
    this.d_head,
    this.role_name,
    this.email,
    this.branch,
    this.employee_table_pk,
    this.department,
  });

  UserLeaveApprovalModel copyWith({
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
    String? full_name,
    String? photo,
    String? d_head,
    String? role_name,
    String? email,
    String? branch,
    String? employee_table_pk,
    String? department,
  }) {
    return UserLeaveApprovalModel(
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
      full_name: full_name ?? this.full_name,
      photo: photo ?? this.photo,
      d_head: d_head ?? this.d_head,
      role_name: role_name ?? this.role_name,
      email: email ?? this.email,
      branch: branch ?? this.branch,
      employee_table_pk: employee_table_pk ?? this.employee_table_pk,
      department: department ?? this.department,
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
      'full_name': full_name,
      'photo': photo,
      'd_head': d_head,
      'role_name': role_name,
      'email': email,
      'branch': branch,
      'employee_table_pk': employee_table_pk,
      'department': department,
    };
  }

  factory UserLeaveApprovalModel.fromMap(Map<String, dynamic> map) {
    return UserLeaveApprovalModel(
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
      full_name: map['full_name'],
      photo: map['photo'],
      d_head: map['d_head'],
      role_name: map['role_name'],
      email: map['email'],
      branch: map['branch'],
      employee_table_pk: map['employee_table_pk'],
      department: map['department'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLeaveApprovalModel.fromJson(String source) =>
      UserLeaveApprovalModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserLeaveApprovalModel(id: $id, unique_id: $unique_id, e_db_id: $e_db_id, employee_id: $employee_id, start_days: $start_days, how_many_days: $how_many_days, end_date: $end_date, hold_unhold: $hold_unhold, days: $days, month: $month, year: $year, note: $note, status: $status, h_aproval: $h_aproval, h_id: $h_id, aproval: $aproval, uploader_info: $uploader_info, data: $data, full_name: $full_name, photo: $photo, d_head: $d_head, role_name: $role_name, email: $email, branch: $branch, employee_table_pk: $employee_table_pk, department: $department)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserLeaveApprovalModel &&
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
        other.data == data &&
        other.full_name == full_name &&
        other.photo == photo &&
        other.d_head == d_head &&
        other.role_name == role_name &&
        other.email == email &&
        other.branch == branch &&
        other.employee_table_pk == employee_table_pk &&
        other.department == department;
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
        data.hashCode ^
        full_name.hashCode ^
        photo.hashCode ^
        d_head.hashCode ^
        role_name.hashCode ^
        email.hashCode ^
        branch.hashCode ^
        employee_table_pk.hashCode ^
        department.hashCode;
  }
}
