import 'dart:convert';

import 'package:new_ways_app/features/tada/models/tadamodel.dart';

class TadaPaymentMethodModel {
  String? id;
  String transaction_id;
  String branch_id;
  String? booking_id;
  String? payment_method;
  String? details;
  String? card_amount;
  String cash_amount;
  String? mobile_amount;
  String? check_amount;
  String? invoice_number;
  String note;
  String? status; //Always 1
  String uploader_info;
  String data; // Its Actually Date
  TadaPaymentMethodModel({
    this.id = '',
    required this.transaction_id,
    this.branch_id = 'BAR_011220_210463187872898170_1606780607',
    this.booking_id = '',
    this.payment_method = 'Cash',
    this.details = 'TD/DA Return Account',
    this.card_amount = '',
    required this.cash_amount,
    this.mobile_amount = '',
    this.check_amount = '',
    this.invoice_number = '',
    required this.note,
    this.status = '1',
    required this.uploader_info,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_id': transaction_id,
      'branch_id': branch_id,
      'booking_id': booking_id,
      'payment_method': payment_method,
      'details': details,
      'card_amount': card_amount,
      'cash_amount': cash_amount,
      'mobile_amount': mobile_amount,
      'check_amount': check_amount,
      'invoice_number': invoice_number,
      'note': note,
      'status': status,
      'uploader_info': uploader_info,
      'data': data,
    };
  }

  factory TadaPaymentMethodModel.fromTadaModel(TadaModel tadaModel) {
    int cash_amount = int.parse((tadaModel.data.food_amount == '')
            ? '0'
            : tadaModel.data.food_amount!) +
        int.parse((tadaModel.data.transport_amount == '')
            ? '0'
            : tadaModel.data.transport_amount!);
    return TadaPaymentMethodModel(
        transaction_id: '',
        cash_amount: '$cash_amount',
        note: 'Received By Self ${tadaModel.user.full_name} TD/DA Bill',
        uploader_info: '',
        data: '');
  }

  factory TadaPaymentMethodModel.fromMap(Map<String, dynamic> map) {
    return TadaPaymentMethodModel(
      id: map['id'],
      transaction_id: map['transaction_id'],
      branch_id: map['branch_id'],
      booking_id: map['booking_id'],
      payment_method: map['payment_method'],
      details: map['details'],
      card_amount: map['card_amount'],
      cash_amount: map['cash_amount'],
      mobile_amount: map['mobile_amount'],
      check_amount: map['check_amount'],
      invoice_number: map['invoice_number'],
      note: map['note'],
      status: map['status'],
      uploader_info: map['uploader_info'],
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TadaPaymentMethodModel.fromJson(String source) =>
      TadaPaymentMethodModel.fromMap(json.decode(source));

  TadaPaymentMethodModel copyWith({
    String? id,
    String? transaction_id,
    String? branch_id,
    String? booking_id,
    String? payment_method,
    String? details,
    String? card_amount,
    String? cash_amount,
    String? mobile_amount,
    String? check_amount,
    String? invoice_number,
    String? note,
    String? status,
    String? uploader_info,
    String? data,
  }) {
    return TadaPaymentMethodModel(
      id: id ?? this.id,
      transaction_id: transaction_id ?? this.transaction_id,
      branch_id: branch_id ?? this.branch_id,
      booking_id: booking_id ?? this.booking_id,
      payment_method: payment_method ?? this.payment_method,
      details: details ?? this.details,
      card_amount: card_amount ?? this.card_amount,
      cash_amount: cash_amount ?? this.cash_amount,
      mobile_amount: mobile_amount ?? this.mobile_amount,
      check_amount: check_amount ?? this.check_amount,
      invoice_number: invoice_number ?? this.invoice_number,
      note: note ?? this.note,
      status: status ?? this.status,
      uploader_info: uploader_info ?? this.uploader_info,
      data: data ?? this.data,
    );
  }
}
