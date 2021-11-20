import 'dart:convert';

class AdvanceSalaryModel {
  String? id;
  String? e_db_id;
  String? employee_id;
  String? amount;
  String? note;
  String? aproval;
  String? aproval_account;
  String? status;
  String? uploader_info;
  String? data;
  String? full_name;
  String? photo;
  String? d_head;
  String? designation_name;
  String? department_name;
  String? email;
  String? branch;
  String? role_name;
  String? employee_table_pk;
  String? department;
  AdvanceSalaryModel({
    this.id,
    this.e_db_id,
    this.employee_id,
    this.amount,
    this.note,
    this.aproval,
    this.aproval_account,
    this.status,
    this.uploader_info,
    this.data,
    this.full_name,
    this.photo,
    this.d_head,
    this.designation_name,
    this.department_name,
    this.email,
    this.branch,
    this.role_name,
    this.employee_table_pk,
    this.department,
  });

  AdvanceSalaryModel copyWith({
    String? id,
    String? e_db_id,
    String? employee_id,
    String? amount,
    String? note,
    String? aproval,
    String? aproval_account,
    String? status,
    String? uploader_info,
    String? data,
    String? full_name,
    String? photo,
    String? d_head,
    String? designation_name,
    String? department_name,
    String? email,
    String? branch,
    String? role_name,
    String? employee_table_pk,
    String? department,
  }) {
    return AdvanceSalaryModel(
      id: id ?? this.id,
      e_db_id: e_db_id ?? this.e_db_id,
      employee_id: employee_id ?? this.employee_id,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      aproval: aproval ?? this.aproval,
      aproval_account: aproval_account ?? this.aproval_account,
      status: status ?? this.status,
      uploader_info: uploader_info ?? this.uploader_info,
      data: data ?? this.data,
      full_name: full_name ?? this.full_name,
      photo: photo ?? this.photo,
      d_head: d_head ?? this.d_head,
      designation_name: designation_name ?? this.designation_name,
      department_name: department_name ?? this.department_name,
      email: email ?? this.email,
      branch: branch ?? this.branch,
      role_name: role_name ?? this.role_name,
      employee_table_pk: employee_table_pk ?? this.employee_table_pk,
      department: department ?? this.department,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'e_db_id': e_db_id,
      'employee_id': employee_id,
      'amount': amount,
      'note': note,
      'aproval': aproval,
      'aproval_account': aproval_account,
      'status': status,
      'uploader_info': uploader_info,
      'data': data,
      'full_name': full_name,
      'photo': photo,
      'd_head': d_head,
      'designation_name': designation_name,
      'department_name': department_name,
      'email': email,
      'branch': branch,
      'role_name': role_name,
      'employee_table_pk': employee_table_pk,
      'department': department,
    };
  }

  factory AdvanceSalaryModel.fromMap(Map<String, dynamic> map) {
    return AdvanceSalaryModel(
      id: map['id'] != null ? map['id'] : null,
      e_db_id: map['e_db_id'] != null ? map['e_db_id'] : null,
      employee_id: map['employee_id'] != null ? map['employee_id'] : null,
      amount: map['amount'] != null ? map['amount'] : null,
      note: map['note'] != null ? map['note'] : null,
      aproval: map['aproval'] != null ? map['aproval'] : null,
      aproval_account:
          map['aproval_account'] != null ? map['aproval_account'] : null,
      status: map['status'] != null ? map['status'] : null,
      uploader_info: map['uploader_info'] != null ? map['uploader_info'] : null,
      data: map['data'] != null ? map['data'] : null,
      full_name: map['full_name'] != null ? map['full_name'] : null,
      photo: map['photo'] != null ? map['photo'] : null,
      d_head: map['d_head'] != null ? map['d_head'] : null,
      designation_name:
          map['designation_name'] != null ? map['designation_name'] : null,
      department_name:
          map['department_name'] != null ? map['department_name'] : null,
      email: map['email'] != null ? map['email'] : null,
      branch: map['branch'] != null ? map['branch'] : null,
      role_name: map['role_name'] != null ? map['role_name'] : null,
      employee_table_pk:
          map['employee_table_pk'] != null ? map['employee_table_pk'] : null,
      department: map['department'] != null ? map['department'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdvanceSalaryModel.fromJson(String source) =>
      AdvanceSalaryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AdvanceSalaryModel(id: $id, e_db_id: $e_db_id, employee_id: $employee_id, amount: $amount, note: $note, aproval: $aproval, aproval_account: $aproval_account, status: $status, uploader_info: $uploader_info, data: $data, full_name: $full_name, photo: $photo, d_head: $d_head, designation_name: $designation_name, department_name: $department_name, email: $email, branch: $branch, role_name: $role_name, employee_table_pk: $employee_table_pk, department: $department)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AdvanceSalaryModel &&
        other.id == id &&
        other.e_db_id == e_db_id &&
        other.employee_id == employee_id &&
        other.amount == amount &&
        other.note == note &&
        other.aproval == aproval &&
        other.aproval_account == aproval_account &&
        other.status == status &&
        other.uploader_info == uploader_info &&
        other.data == data &&
        other.full_name == full_name &&
        other.photo == photo &&
        other.d_head == d_head &&
        other.designation_name == designation_name &&
        other.department_name == department_name &&
        other.email == email &&
        other.branch == branch &&
        other.role_name == role_name &&
        other.employee_table_pk == employee_table_pk &&
        other.department == department;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        e_db_id.hashCode ^
        employee_id.hashCode ^
        amount.hashCode ^
        note.hashCode ^
        aproval.hashCode ^
        aproval_account.hashCode ^
        status.hashCode ^
        uploader_info.hashCode ^
        data.hashCode ^
        full_name.hashCode ^
        photo.hashCode ^
        d_head.hashCode ^
        designation_name.hashCode ^
        department_name.hashCode ^
        email.hashCode ^
        branch.hashCode ^
        role_name.hashCode ^
        employee_table_pk.hashCode ^
        department.hashCode;
  }
}
