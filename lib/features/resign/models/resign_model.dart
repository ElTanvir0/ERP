import 'dart:convert';

class ResignModel {
  String? full_name;
  String? photo;
  String? id;
  String? e_db_id;
  String? employee_id;
  String? department_head_id;
  String? department_head_e_id;
  String? application;
  String? aproval;
  String? note;
  String? status;
  String? uploader_info;
  String? data;
  ResignModel({
    this.full_name,
    this.photo,
    this.id,
    this.e_db_id,
    this.employee_id,
    this.department_head_id,
    this.department_head_e_id,
    this.application,
    this.aproval,
    this.note,
    this.status,
    this.uploader_info,
    this.data,
  });

  ResignModel copyWith({
    String? full_name,
    String? photo,
    String? id,
    String? e_db_id,
    String? employee_id,
    String? department_head_id,
    String? department_head_e_id,
    String? application,
    String? aproval,
    String? note,
    String? status,
    String? uploader_info,
    String? data,
  }) {
    return ResignModel(
      full_name: full_name ?? this.full_name,
      photo: photo ?? this.photo,
      id: id ?? this.id,
      e_db_id: e_db_id ?? this.e_db_id,
      employee_id: employee_id ?? this.employee_id,
      department_head_id: department_head_id ?? this.department_head_id,
      department_head_e_id: department_head_e_id ?? this.department_head_e_id,
      application: application ?? this.application,
      aproval: aproval ?? this.aproval,
      note: note ?? this.note,
      status: status ?? this.status,
      uploader_info: uploader_info ?? this.uploader_info,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'full_name': full_name,
      'photo': photo,
      'id': id,
      'e_db_id': e_db_id,
      'employee_id': employee_id,
      'department_head_id': department_head_id,
      'department_head_e_id': department_head_e_id,
      'application': application,
      'aproval': aproval,
      'note': note,
      'status': status,
      'uploader_info': uploader_info,
      'data': data,
    };
  }

  factory ResignModel.fromMap(Map<String, dynamic> map) {
    return ResignModel(
      full_name: map['full_name'] != null ? map['full_name'] : null,
      photo: map['photo'] != null ? map['photo'] : null,
      id: map['id'] != null ? map['id'] : null,
      e_db_id: map['e_db_id'] != null ? map['e_db_id'] : null,
      employee_id: map['employee_id'] != null ? map['employee_id'] : null,
      department_head_id:
          map['department_head_id'] != null ? map['department_head_id'] : null,
      department_head_e_id: map['department_head_e_id'] != null
          ? map['department_head_e_id']
          : null,
      application: map['application'] != null ? map['application'] : null,
      aproval: map['aproval'] != null ? map['aproval'] : null,
      note: map['note'] != null ? map['note'] : null,
      status: map['status'] != null ? map['status'] : null,
      uploader_info: map['uploader_info'] != null ? map['uploader_info'] : null,
      data: map['data'] != null ? map['data'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResignModel.fromJson(String source) =>
      ResignModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResignModel(full_name: $full_name, photo: $photo, id: $id, e_db_id: $e_db_id, employee_id: $employee_id, department_head_id: $department_head_id, department_head_e_id: $department_head_e_id, application: $application, aproval: $aproval, note: $note, status: $status, uploader_info: $uploader_info, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResignModel &&
        other.full_name == full_name &&
        other.photo == photo &&
        other.id == id &&
        other.e_db_id == e_db_id &&
        other.employee_id == employee_id &&
        other.department_head_id == department_head_id &&
        other.department_head_e_id == department_head_e_id &&
        other.application == application &&
        other.aproval == aproval &&
        other.note == note &&
        other.status == status &&
        other.uploader_info == uploader_info &&
        other.data == data;
  }

  @override
  int get hashCode {
    return full_name.hashCode ^
        photo.hashCode ^
        id.hashCode ^
        e_db_id.hashCode ^
        employee_id.hashCode ^
        department_head_id.hashCode ^
        department_head_e_id.hashCode ^
        application.hashCode ^
        aproval.hashCode ^
        note.hashCode ^
        status.hashCode ^
        uploader_info.hashCode ^
        data.hashCode;
  }
}
