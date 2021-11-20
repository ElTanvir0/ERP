import 'dart:convert';

class PurchaseMoneyRequestModel {
  String? id;
  String? employee_id;
  String? amount;
  String? note;
  String? status;
  String? uploader_info;
  String? data;
  String? full_name;
  String? photo;
  String? employee_table_pk;
  String? designation_name;
  String? department_name;
  PurchaseMoneyRequestModel({
    this.id,
    this.employee_id,
    this.amount,
    this.note,
    this.status,
    this.uploader_info,
    this.data,
    this.full_name,
    this.photo,
    this.employee_table_pk,
    this.designation_name,
    this.department_name,
  });

  PurchaseMoneyRequestModel copyWith({
    String? id,
    String? employee_id,
    String? amount,
    String? note,
    String? status,
    String? uploader_info,
    String? data,
    String? full_name,
    String? photo,
    String? employee_table_pk,
    String? designation_name,
    String? department_name,
  }) {
    return PurchaseMoneyRequestModel(
      id: id ?? this.id,
      employee_id: employee_id ?? this.employee_id,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      status: status ?? this.status,
      uploader_info: uploader_info ?? this.uploader_info,
      data: data ?? this.data,
      full_name: full_name ?? this.full_name,
      photo: photo ?? this.photo,
      employee_table_pk: employee_table_pk ?? this.employee_table_pk,
      designation_name: designation_name ?? this.designation_name,
      department_name: department_name ?? this.department_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employee_id': employee_id,
      'amount': amount,
      'note': note,
      'status': status,
      'uploader_info': uploader_info,
      'data': data,
      // 'full_name': full_name,
      // 'photo': photo,
      // 'employee_table_pk': employee_table_pk,
      // 'designation_name': designation_name,
      // 'department_name': department_name,
    };
  }

  factory PurchaseMoneyRequestModel.fromMap(Map<String, dynamic> map) {
    return PurchaseMoneyRequestModel(
      id: map['id'],
      employee_id: map['employee_id'],
      amount: map['amount'],
      note: map['note'],
      status: map['status'],
      uploader_info: map['uploader_info'],
      data: map['data'],
      full_name: map['full_name'],
      photo: map['photo'],
      employee_table_pk: map['employee_table_pk'],
      designation_name: map['designation_name'],
      department_name: map['department_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PurchaseMoneyRequestModel.fromJson(String source) =>
      PurchaseMoneyRequestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PurchaseMoneyRequestModel(id: $id, employee_id: $employee_id, amount: $amount, note: $note, status: $status, uploader_info: $uploader_info, data: $data, full_name: $full_name, photo: $photo, employee_table_pk: $employee_table_pk, designation_name: $designation_name, department_name: $department_name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PurchaseMoneyRequestModel &&
        other.id == id &&
        other.employee_id == employee_id &&
        other.amount == amount &&
        other.note == note &&
        other.status == status &&
        other.uploader_info == uploader_info &&
        other.data == data &&
        other.full_name == full_name &&
        other.photo == photo &&
        other.employee_table_pk == employee_table_pk &&
        other.designation_name == designation_name &&
        other.department_name == department_name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        employee_id.hashCode ^
        amount.hashCode ^
        note.hashCode ^
        status.hashCode ^
        uploader_info.hashCode ^
        data.hashCode ^
        full_name.hashCode ^
        photo.hashCode ^
        employee_table_pk.hashCode ^
        designation_name.hashCode ^
        department_name.hashCode;
  }
}
