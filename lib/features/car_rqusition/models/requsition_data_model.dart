import 'dart:convert';

class CarRequisitionModel {
  String? full_name;
  String? photo;
  String? service_id;
  String? id;
  String? service_product_id;
  String? start_date;
  String? end_date;
  String? destination_from;
  String? destination_to;
  String? requisition_by;
  String? creation_date;
  String? uploader_info;
  String? status;
  String? note;
  String? driver_start_date;
  String? driver_end_date;
  String? mileage_start;
  String? mileage_end;
  String? unit;
  String? confirmation_code;
  String? description;
  String? requisition_type;
  String? name;
  String? approval_note;
  CarRequisitionModel({
    this.full_name,
    this.photo,
    this.service_id,
    this.id,
    this.service_product_id,
    this.start_date,
    this.end_date,
    this.destination_from,
    this.destination_to,
    this.requisition_by,
    this.creation_date,
    this.uploader_info,
    this.status,
    this.note,
    this.driver_start_date,
    this.driver_end_date,
    this.mileage_start,
    this.mileage_end,
    this.unit,
    this.confirmation_code,
    this.description,
    this.requisition_type,
    this.name,
    this.approval_note,
  });

  CarRequisitionModel copyWith({
    String? full_name,
    String? photo,
    String? service_id,
    String? id,
    String? service_product_id,
    String? start_date,
    String? end_date,
    String? destination_from,
    String? destination_to,
    String? requisition_by,
    String? creation_date,
    String? uploader_info,
    String? status,
    String? note,
    String? driver_start_date,
    String? driver_end_date,
    String? mileage_start,
    String? mileage_end,
    String? unit,
    String? confirmation_code,
    String? description,
    String? requisition_type,
    String? name,
    String? approval_note,
  }) {
    return CarRequisitionModel(
      full_name: full_name ?? this.full_name,
      photo: photo ?? this.photo,
      service_id: service_id ?? this.service_id,
      id: id ?? this.id,
      service_product_id: service_product_id ?? this.service_product_id,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      destination_from: destination_from ?? this.destination_from,
      destination_to: destination_to ?? this.destination_to,
      requisition_by: requisition_by ?? this.requisition_by,
      creation_date: creation_date ?? this.creation_date,
      uploader_info: uploader_info ?? this.uploader_info,
      status: status ?? this.status,
      note: note ?? this.note,
      driver_start_date: driver_start_date ?? this.driver_start_date,
      driver_end_date: driver_end_date ?? this.driver_end_date,
      mileage_start: mileage_start ?? this.mileage_start,
      mileage_end: mileage_end ?? this.mileage_end,
      unit: unit ?? this.unit,
      confirmation_code: confirmation_code ?? this.confirmation_code,
      description: description ?? this.description,
      requisition_type: requisition_type ?? this.requisition_type,
      name: name ?? this.name,
      approval_note: approval_note ?? this.approval_note,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'full_name': full_name,
      'photo': photo,
      'service_id': service_id,
      'id': id,
      'service_product_id': service_product_id,
      'start_date': start_date,
      'end_date': end_date,
      'destination_from': destination_from,
      'destination_to': destination_to,
      'requisition_by': requisition_by,
      'creation_date': creation_date,
      'uploader_info': uploader_info,
      'status': status,
      'note': note,
      'driver_start_date': driver_start_date,
      'driver_end_date': driver_end_date,
      'mileage_start': mileage_start,
      'mileage_end': mileage_end,
      'unit': unit,
      'confirmation_code': confirmation_code,
      'description': description,
      'requisition_type': requisition_type,
      'name': name,
      'approval_note': approval_note,
    };
  }

  factory CarRequisitionModel.fromMap(Map<String, dynamic> map) {
    return CarRequisitionModel(
      full_name: map['full_name'] != null ? map['full_name'] : null,
      photo: map['photo'] != null ? map['photo'] : null,
      service_id: map['service_id'] != null ? map['service_id'] : null,
      id: map['id'] != null ? map['id'] : null,
      service_product_id:
          map['service_product_id'] != null ? map['service_product_id'] : null,
      start_date: map['start_date'] != null ? map['start_date'] : null,
      end_date: map['end_date'] != null ? map['end_date'] : null,
      destination_from:
          map['destination_from'] != null ? map['destination_from'] : null,
      destination_to:
          map['destination_to'] != null ? map['destination_to'] : null,
      requisition_by:
          map['requisition_by'] != null ? map['requisition_by'] : null,
      creation_date: map['creation_date'] != null ? map['creation_date'] : null,
      uploader_info: map['uploader_info'] != null ? map['uploader_info'] : null,
      status: map['status'] != null ? map['status'] : null,
      note: map['note'] != null ? map['note'] : null,
      driver_start_date:
          map['driver_start_date'] != null ? map['driver_start_date'] : null,
      driver_end_date:
          map['driver_end_date'] != null ? map['driver_end_date'] : null,
      mileage_start: map['mileage_start'] != null ? map['mileage_start'] : null,
      mileage_end: map['mileage_end'] != null ? map['mileage_end'] : null,
      unit: map['unit'] != null ? map['unit'] : null,
      confirmation_code:
          map['confirmation_code'] != null ? map['confirmation_code'] : null,
      description: map['description'] != null ? map['description'] : null,
      requisition_type:
          map['requisition_type'] != null ? map['requisition_type'] : null,
      name: map['name'] != null ? map['name'] : null,
      approval_note: map['approval_note'] != null ? map['approval_note'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarRequisitionModel.fromJson(String source) =>
      CarRequisitionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CarRequisitionModel(full_name: $full_name, photo: $photo, service_id: $service_id, id: $id, service_product_id: $service_product_id, start_date: $start_date, end_date: $end_date, destination_from: $destination_from, destination_to: $destination_to, requisition_by: $requisition_by, creation_date: $creation_date, uploader_info: $uploader_info, status: $status, note: $note, driver_start_date: $driver_start_date, driver_end_date: $driver_end_date, mileage_start: $mileage_start, mileage_end: $mileage_end, unit: $unit, confirmation_code: $confirmation_code, description: $description, requisition_type: $requisition_type, name: $name, approval_note: $approval_note)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarRequisitionModel &&
        other.full_name == full_name &&
        other.photo == photo &&
        other.service_id == service_id &&
        other.id == id &&
        other.service_product_id == service_product_id &&
        other.start_date == start_date &&
        other.end_date == end_date &&
        other.destination_from == destination_from &&
        other.destination_to == destination_to &&
        other.requisition_by == requisition_by &&
        other.creation_date == creation_date &&
        other.uploader_info == uploader_info &&
        other.status == status &&
        other.note == note &&
        other.driver_start_date == driver_start_date &&
        other.driver_end_date == driver_end_date &&
        other.mileage_start == mileage_start &&
        other.mileage_end == mileage_end &&
        other.unit == unit &&
        other.confirmation_code == confirmation_code &&
        other.description == description &&
        other.requisition_type == requisition_type &&
        other.name == name &&
        other.approval_note == approval_note;
  }

  @override
  int get hashCode {
    return full_name.hashCode ^
        photo.hashCode ^
        service_id.hashCode ^
        id.hashCode ^
        service_product_id.hashCode ^
        start_date.hashCode ^
        end_date.hashCode ^
        destination_from.hashCode ^
        destination_to.hashCode ^
        requisition_by.hashCode ^
        creation_date.hashCode ^
        uploader_info.hashCode ^
        status.hashCode ^
        note.hashCode ^
        driver_start_date.hashCode ^
        driver_end_date.hashCode ^
        mileage_start.hashCode ^
        mileage_end.hashCode ^
        unit.hashCode ^
        confirmation_code.hashCode ^
        description.hashCode ^
        requisition_type.hashCode ^
        name.hashCode ^
        approval_note.hashCode;
  }
}
