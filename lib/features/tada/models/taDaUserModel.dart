import 'dart:convert';

class TadaUserModel {
  String? full_name;
  String? photo;
  String? d_head;
  String? role;
  String? designation_name;
  String? department_name;
  String? email;
  String? branch;
  String? department;
  TadaUserModel({
    this.full_name,
    this.photo,
    this.d_head,
    this.role,
    this.designation_name,
    this.department_name,
    this.email,
    this.branch,
    this.department,
  });

  Map<String, dynamic> toMap() {
    return {
      'full_name': full_name,
      'photo': photo,
      'd_head': d_head,
      'role': role,
      'designation_name': designation_name,
      'department_name': department_name,
      'email': email,
      'branch': branch,
      'department': department,
    };
  }

  factory TadaUserModel.fromMap(Map<String, dynamic> map) {
    return TadaUserModel(
      full_name: map['full_name'],
      photo: map['photo'],
      d_head: map['d_head'],
      role: map['role'],
      designation_name: map['designation_name'],
      department_name: map['department_name'],
      email: map['email'],
      branch: map['branch'],
      department: map['department'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TadaUserModel.fromJson(String source) =>
      TadaUserModel.fromMap(json.decode(source));
}
