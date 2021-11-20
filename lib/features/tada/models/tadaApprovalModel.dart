import 'dart:convert';

import 'tadaDatamodel.dart';

class TadaApprovalModel {
  String? id;
  String? e_db_id;
  String? employee_id;
  String? ta_request_id;
  String? aproval_type;
  String? note;
  String? status;
  String? uploader_info;
  String? data;
  TadaApprovalModel({
    this.id,
    this.e_db_id,
    this.employee_id,
    this.ta_request_id,
    this.aproval_type,
    this.note,
    this.status,
    this.uploader_info,
    this.data,
  });

  TadaApprovalModel copyWith({
    String? id,
    String? e_db_id,
    String? employee_id,
    String? ta_request_id,
    String? aproval_type,
    String? note,
    String? status,
    String? uploader_info,
    String? data,
  }) {
    return TadaApprovalModel(
      id: id ?? this.id,
      e_db_id: e_db_id ?? this.e_db_id,
      employee_id: employee_id ?? this.employee_id,
      ta_request_id: ta_request_id ?? this.ta_request_id,
      aproval_type: aproval_type ?? this.aproval_type,
      note: note ?? this.note,
      status: status ?? this.status,
      uploader_info: uploader_info ?? this.uploader_info,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'e_db_id': e_db_id,
      'employee_id': employee_id,
      'ta_request_id': ta_request_id,
      'aproval_type': aproval_type,
      'note': note,
      'status': status,
      'uploader_info': uploader_info,
      'data': data,
    };
  }

  factory TadaApprovalModel.fromMap(Map<String, dynamic> map) {
    return TadaApprovalModel(
      id: map['id'],
      e_db_id: map['e_db_id'],
      employee_id: map['employee_id'],
      ta_request_id: map['ta_request_id'],
      aproval_type: map['aproval_type'],
      note: map['note'],
      status: map['status'],
      uploader_info: map['uploader_info'],
      data: map['data'],
    );
  }

  factory TadaApprovalModel.fromTadaModel(TaDaDataModel model) {
    DateTime now = DateTime.now();
    return TadaApprovalModel(
      id: '',
      e_db_id: model.e_db_id,
      employee_id: model.employee_id,
      ta_request_id: model.id,
      aproval_type: '',
      note: model.note,
      status: model.status,
      uploader_info: '',
      data: DateTime(now.year, now.month, now.day).toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TadaApprovalModel.fromJson(String source) =>
      TadaApprovalModel.fromMap(json.decode(source));
}
