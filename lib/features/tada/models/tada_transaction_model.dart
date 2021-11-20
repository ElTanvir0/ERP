import 'dart:convert';

import 'package:new_ways_app/features/tada/models/tadamodel.dart';

class TadaTranscationModel {
  String? id;
  String transaction_id;
  String? branch_id;
  String? booking_id;
  String careof;
  String? account_type;
  String? account;
  String amount;
  String date;
  String? transaction_type;
  String? transaction_category;
  String? transaction_method;
  String? data_one;
  String? data_two;
  String? data_three;
  String note;
  String? status;
  String uploader_info;
  String data; //This is Actually date
  TadaTranscationModel({
    this.id = '',
    required this.transaction_id,
    this.branch_id = 'BAR_011220_210463187872898170_1606780607',
    this.booking_id = '',
    required this.careof,
    this.account_type = 'Default',
    this.account = 'Default',
    required this.amount,
    required this.date,
    this.transaction_type = 'Debit',
    this.transaction_category = 'TD/DA Return Account',
    this.transaction_method = 'Cash',
    this.data_one = '',
    this.data_two = '',
    this.data_three = '',
    required this.note,
    this.status = '1',
    required this.uploader_info,
    required this.data,
  });

  factory TadaTranscationModel.fromTadaModel(TadaModel tadaModel) {
    int cash_amount = int.parse((tadaModel.data.food_amount == '0')
            ? ''
            : tadaModel.data.food_amount!) +
        int.parse((tadaModel.data.transport_amount == '')
            ? '0'
            : tadaModel.data.transport_amount!);
    return TadaTranscationModel(
        transaction_id: '',
        careof: tadaModel.user.full_name!,
        amount: '$cash_amount',
        date: '',
        note: tadaModel.data.employee_id!,
        uploader_info: '',
        data: '');
  }

  TadaTranscationModel copyWith({
    String? id,
    String? transaction_id,
    String? branch_id,
    String? booking_id,
    String? careof,
    String? account_type,
    String? account,
    String? amount,
    String? date,
    String? transaction_type,
    String? transaction_category,
    String? transaction_method,
    String? data_one,
    String? data_two,
    String? data_three,
    String? note,
    String? status,
    String? uploader_info,
    String? data,
  }) {
    return TadaTranscationModel(
      id: id ?? this.id,
      transaction_id: transaction_id ?? this.transaction_id,
      branch_id: branch_id ?? this.branch_id,
      booking_id: booking_id ?? this.booking_id,
      careof: careof ?? this.careof,
      account_type: account_type ?? this.account_type,
      account: account ?? this.account,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      transaction_type: transaction_type ?? this.transaction_type,
      transaction_category: transaction_category ?? this.transaction_category,
      transaction_method: transaction_method ?? this.transaction_method,
      data_one: data_one ?? this.data_one,
      data_two: data_two ?? this.data_two,
      data_three: data_three ?? this.data_three,
      note: note ?? this.note,
      status: status ?? this.status,
      uploader_info: uploader_info ?? this.uploader_info,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_id': transaction_id,
      'branch_id': branch_id,
      'booking_id': booking_id,
      'careof': careof,
      'account_type': account_type,
      'account': account,
      'amount': amount,
      'date': date,
      'transaction_type': transaction_type,
      'transaction_category': transaction_category,
      'transaction_method': transaction_method,
      'data_one': data_one,
      'data_two': data_two,
      'data_three': data_three,
      'note': note,
      'status': status,
      'uploader_info': uploader_info,
      'data': data,
    };
  }

  factory TadaTranscationModel.fromMap(Map<String, dynamic> map) {
    return TadaTranscationModel(
      id: map['id'],
      transaction_id: map['transaction_id'],
      branch_id: map['branch_id'],
      booking_id: map['booking_id'],
      careof: map['careof'],
      account_type: map['account_type'],
      account: map['account'],
      amount: map['amount'],
      date: map['date'],
      transaction_type: map['transaction_type'],
      transaction_category: map['transaction_category'],
      transaction_method: map['transaction_method'],
      data_one: map['data_one'],
      data_two: map['data_two'],
      data_three: map['data_three'],
      note: map['note'],
      status: map['status'],
      uploader_info: map['uploader_info'],
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TadaTranscationModel.fromJson(String source) =>
      TadaTranscationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TadaTranscationModel(id: $id, transaction_id: $transaction_id, branch_id: $branch_id, booking_id: $booking_id, careof: $careof, account_type: $account_type, account: $account, amount: $amount, date: $date, transaction_type: $transaction_type, transaction_category: $transaction_category, transaction_method: $transaction_method, data_one: $data_one, data_two: $data_two, data_three: $data_three, note: $note, status: $status, uploader_info: $uploader_info, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TadaTranscationModel &&
        other.id == id &&
        other.transaction_id == transaction_id &&
        other.branch_id == branch_id &&
        other.booking_id == booking_id &&
        other.careof == careof &&
        other.account_type == account_type &&
        other.account == account &&
        other.amount == amount &&
        other.date == date &&
        other.transaction_type == transaction_type &&
        other.transaction_category == transaction_category &&
        other.transaction_method == transaction_method &&
        other.data_one == data_one &&
        other.data_two == data_two &&
        other.data_three == data_three &&
        other.note == note &&
        other.status == status &&
        other.uploader_info == uploader_info &&
        other.data == data;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        transaction_id.hashCode ^
        branch_id.hashCode ^
        booking_id.hashCode ^
        careof.hashCode ^
        account_type.hashCode ^
        account.hashCode ^
        amount.hashCode ^
        date.hashCode ^
        transaction_type.hashCode ^
        transaction_category.hashCode ^
        transaction_method.hashCode ^
        data_one.hashCode ^
        data_two.hashCode ^
        data_three.hashCode ^
        note.hashCode ^
        status.hashCode ^
        uploader_info.hashCode ^
        data.hashCode;
  }
}
