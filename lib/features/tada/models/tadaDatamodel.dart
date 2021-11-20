import 'dart:convert';

class TaDaDataModel {
  String? id;
  String? e_db_id;
  String? employee_id;
  String? department_head_id;
  String? destination_from;
  String? destination_to;
  String? transport_date;
  String? transport_type;
  String? transport_details;
  String? transport_amount;
  String? food_amount;
  String? vehicle_type;
  String? vehicle_type_reason;
  String? bill_attachment;
  String? note;
  String? status = '1';
  String? department_head_aproval = '0';
  String? boss_aproval = '0';
  String? accounts_aproval = '0';
  String? self_aproval = '0';
  String? uploader_info;
  String? data;
  TaDaDataModel({
    this.id,
    this.e_db_id,
    this.employee_id,
    this.department_head_id,
    this.destination_from,
    this.destination_to,
    this.transport_date,
    this.transport_type,
    this.transport_details,
    this.transport_amount,
    this.food_amount,
    this.vehicle_type,
    this.vehicle_type_reason,
    this.bill_attachment,
    this.note,
    this.status,
    this.department_head_aproval,
    this.boss_aproval,
    this.accounts_aproval,
    this.self_aproval,
    this.uploader_info,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'e_db_id': e_db_id,
      'employee_id': employee_id,
      'department_head_id': department_head_id,
      'destination_from': destination_from,
      'destination_to': destination_to,
      'transport_date': transport_date,
      'transport_type': transport_type,
      'transport_details': transport_details,
      'transport_amount': transport_amount,
      'food_amount': food_amount,
      'vehicle_type': vehicle_type,
      'vehicle_type_reason': vehicle_type_reason,
      'bill_attachment': bill_attachment,
      'note': note,
      'status': status,
      'department_head_aproval': department_head_aproval,
      'boss_aproval': boss_aproval,
      'accounts_aproval': accounts_aproval,
      'self_aproval': self_aproval,
      'uploader_info': uploader_info,
      'data': data,
    };
  }

  factory TaDaDataModel.fromMap(Map<String, dynamic> map) {
    return TaDaDataModel(
      id: map['id'],
      e_db_id: map['e_db_id'],
      employee_id: map['employee_id'],
      department_head_id: map['department_head_id'],
      destination_from: map['destination_from'],
      destination_to: map['destination_to'],
      transport_date: map['transport_date'],
      transport_type: map['transport_type'],
      transport_details: map['transport_details'],
      transport_amount: map['transport_amount'],
      food_amount: map['food_amount'],
      vehicle_type: map['vehicle_type'],
      vehicle_type_reason: map['vehicle_type_reason'],
      bill_attachment: map['bill_attachment'],
      note: map['note'],
      status: map['status'],
      department_head_aproval: map['department_head_aproval'],
      boss_aproval: map['boss_aproval'],
      accounts_aproval: map['accounts_aproval'],
      self_aproval: map['self_aproval'],
      uploader_info: map['uploader_info'],
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TaDaDataModel.fromJson(String source) =>
      TaDaDataModel.fromMap(json.decode(source));

  TaDaDataModel copyWith({
    String? id,
    String? e_db_id,
    String? employee_id,
    String? department_head_id,
    String? destination_from,
    String? destination_to,
    String? transport_date,
    String? transport_type,
    String? transport_details,
    String? transport_amount,
    String? food_amount,
    String? vehicle_type,
    String? vehicle_type_reason,
    String? bill_attachment,
    String? note,
    String? status,
    String? department_head_aproval,
    String? boss_aproval,
    String? accounts_aproval,
    String? self_aproval,
    String? uploader_info,
    String? data,
  }) {
    return TaDaDataModel(
      id: id ?? this.id,
      e_db_id: e_db_id ?? this.e_db_id,
      employee_id: employee_id ?? this.employee_id,
      department_head_id: department_head_id ?? this.department_head_id,
      destination_from: destination_from ?? this.destination_from,
      destination_to: destination_to ?? this.destination_to,
      transport_date: transport_date ?? this.transport_date,
      transport_type: transport_type ?? this.transport_type,
      transport_details: transport_details ?? this.transport_details,
      transport_amount: transport_amount ?? this.transport_amount,
      food_amount: food_amount ?? this.food_amount,
      vehicle_type: vehicle_type ?? this.vehicle_type,
      vehicle_type_reason: vehicle_type_reason ?? this.vehicle_type_reason,
      bill_attachment: bill_attachment ?? this.bill_attachment,
      note: note ?? this.note,
      status: status ?? this.status,
      department_head_aproval:
          department_head_aproval ?? this.department_head_aproval,
      boss_aproval: boss_aproval ?? this.boss_aproval,
      accounts_aproval: accounts_aproval ?? this.accounts_aproval,
      self_aproval: self_aproval ?? this.self_aproval,
      uploader_info: uploader_info ?? this.uploader_info,
      data: data ?? this.data,
    );
  }
}
