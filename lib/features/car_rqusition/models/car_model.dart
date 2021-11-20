import 'dart:convert';

class CarModel {
  String? description;
  String? requisition_type;
  String? name;
  String? id;
  CarModel({
    this.description,
    this.requisition_type,
    this.name,
    this.id,
  });

  CarModel copyWith({
    String? description,
    String? requisition_type,
    String? name,
    String? id,
  }) {
    return CarModel(
      description: description ?? this.description,
      requisition_type: requisition_type ?? this.requisition_type,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'requisition_type': requisition_type,
      'name': name,
      'id': id,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      description: map['description'] != null ? map['description'] : null,
      requisition_type:
          map['requisition_type'] != null ? map['requisition_type'] : null,
      name: map['name'] != null ? map['name'] : null,
      id: map['id'] != null ? map['id'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarModel.fromJson(String source) =>
      CarModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CarModel(description: $description, requisition_type: $requisition_type, name: $name, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarModel &&
        other.description == description &&
        other.requisition_type == requisition_type &&
        other.name == name &&
        other.id == id;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        requisition_type.hashCode ^
        name.hashCode ^
        id.hashCode;
  }
}
