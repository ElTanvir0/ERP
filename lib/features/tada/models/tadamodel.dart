import 'dart:convert';

import 'taDaUserModel.dart';
import 'tadaDatamodel.dart';

class TadaModel {
  TadaUserModel user;
  TaDaDataModel data;
  TadaModel({
    required this.user,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user.toJson(),
      'data': data.toJson(),
    };
  }

  factory TadaModel.fromMap(Map<String, dynamic> map) {
    return TadaModel(
      user: TadaUserModel.fromMap(map),
      data: TaDaDataModel.fromMap(map),
    );
  }

  String toJson() => json.encode(toMap());

  factory TadaModel.fromJson(Map<String, dynamic> source) =>
      TadaModel.fromMap(source);
}
