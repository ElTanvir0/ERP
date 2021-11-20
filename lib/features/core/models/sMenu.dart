import 'dart:convert';

class SmenuLocation {
  String? employee_id;
  String? full_name;
  String? photo;
  String? longitude;
  String? latitude;
  SmenuLocation({
    this.employee_id,
    this.full_name,
    this.photo,
    this.longitude,
    this.latitude,
  });

  SmenuLocation copyWith({
    String? employee_id,
    String? full_name,
    String? photo,
    String? longitude,
    String? latitude,
  }) {
    return SmenuLocation(
      employee_id: employee_id ?? this.employee_id,
      full_name: full_name ?? this.full_name,
      photo: photo ?? this.photo,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employee_id': employee_id,
      'full_name': full_name,
      'photo': photo,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory SmenuLocation.fromMap(Map<String, dynamic> map) {
    return SmenuLocation(
      employee_id: map['employee_id'] != null ? map['employee_id'] : null,
      full_name: map['full_name'] != null ? map['full_name'] : null,
      photo: map['photo'] != null ? map['photo'] : null,
      longitude: map['longitude'] != null ? map['longitude'] : null,
      latitude: map['latitude'] != null ? map['latitude'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SmenuLocation.fromJson(String source) =>
      SmenuLocation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SmenuLocation(employee_id: $employee_id, full_name: $full_name, photo: $photo, longitude: $longitude, latitude: $latitude)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SmenuLocation &&
        other.employee_id == employee_id &&
        other.full_name == full_name &&
        other.photo == photo &&
        other.longitude == longitude &&
        other.latitude == latitude;
  }

  @override
  int get hashCode {
    return employee_id.hashCode ^
        full_name.hashCode ^
        photo.hashCode ^
        longitude.hashCode ^
        latitude.hashCode;
  }
}
