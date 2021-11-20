import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:new_ways_app/features/car_rqusition/models/car_model.dart';
import 'package:new_ways_app/features/car_rqusition/models/cr_branch_model.dart';

class CarsAndBranchesModel {
  List<CarModel>? cars;
  List<BranchModelCR>? branches;
  CarsAndBranchesModel({
    this.cars,
    this.branches,
  });

  CarsAndBranchesModel copyWith({
    List<CarModel>? cars,
    List<BranchModelCR>? branches,
  }) {
    return CarsAndBranchesModel(
      cars: cars ?? this.cars,
      branches: branches ?? this.branches,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cars': cars?.map((x) => x.toMap()).toList(),
      'branches': branches?.map((x) => x.toMap()).toList(),
    };
  }

  factory CarsAndBranchesModel.fromMap(Map<String, dynamic> map) {
    return CarsAndBranchesModel(
      cars: map['cars'] != null
          ? List<CarModel>.from(map['cars']?.map((x) => CarModel.fromMap(x)))
          : null,
      branches: map['branches'] != null
          ? List<BranchModelCR>.from(
              map['branches']?.map((x) => BranchModelCR.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarsAndBranchesModel.fromJson(String source) =>
      CarsAndBranchesModel.fromMap(json.decode(source));

  @override
  String toString() => 'CarsAndBranchesModel(cars: $cars, branches: $branches)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarsAndBranchesModel &&
        listEquals(other.cars, cars) &&
        listEquals(other.branches, branches);
  }

  @override
  int get hashCode => cars.hashCode ^ branches.hashCode;
}
