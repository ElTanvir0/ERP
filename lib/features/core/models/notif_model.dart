import 'dart:convert';

class NotifModel {
  String? id;
  String? user_id;
  String? user_type;
  String? n_header;
  String? n_message;
  String? n_links;
  String? time;
  String? data;
  String? time_stamp;
  String? is_read;
  String? uploader_info;
  String? creation_date;
  String? is_pushed;
  NotifModel({
    this.id,
    this.user_id,
    this.user_type,
    this.n_header,
    this.n_message,
    this.n_links,
    this.time,
    this.data,
    this.time_stamp,
    this.is_read,
    this.uploader_info,
    this.creation_date,
    this.is_pushed,
  });

  NotifModel copyWith({
    String? id,
    String? user_id,
    String? user_type,
    String? n_header,
    String? n_message,
    String? n_links,
    String? time,
    String? data,
    String? time_stamp,
    String? is_read,
    String? uploader_info,
    String? creation_date,
    String? is_pushed,
  }) {
    return NotifModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      user_type: user_type ?? this.user_type,
      n_header: n_header ?? this.n_header,
      n_message: n_message ?? this.n_message,
      n_links: n_links ?? this.n_links,
      time: time ?? this.time,
      data: data ?? this.data,
      time_stamp: time_stamp ?? this.time_stamp,
      is_read: is_read ?? this.is_read,
      uploader_info: uploader_info ?? this.uploader_info,
      creation_date: creation_date ?? this.creation_date,
      is_pushed: is_pushed ?? this.is_pushed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': user_id,
      'user_type': user_type,
      'n_header': n_header,
      'n_message': n_message,
      'n_links': n_links,
      'time': time,
      'data': data,
      'time_stamp': time_stamp,
      'is_read': is_read,
      'uploader_info': uploader_info,
      'creation_date': creation_date,
      'is_pushed': is_pushed,
    };
  }

  factory NotifModel.fromMap(Map<String, dynamic> map) {
    return NotifModel(
      id: map['id'] != null ? map['id'] : null,
      user_id: map['user_id'] != null ? map['user_id'] : null,
      user_type: map['user_type'] != null ? map['user_type'] : null,
      n_header: map['n_header'] != null ? map['n_header'] : null,
      n_message: map['n_message'] != null ? map['n_message'] : null,
      n_links: map['n_links'] != null ? map['n_links'] : null,
      time: map['time'] != null ? map['time'] : null,
      data: map['data'] != null ? map['data'] : null,
      time_stamp: map['time_stamp'] != null ? map['time_stamp'] : null,
      is_read: map['is_read'] != null ? map['is_read'] : null,
      uploader_info: map['uploader_info'] != null ? map['uploader_info'] : null,
      creation_date: map['creation_date'] != null ? map['creation_date'] : null,
      is_pushed: map['is_pushed'] != null ? map['is_pushed'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotifModel.fromJson(String source) =>
      NotifModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotifModel(id: $id, user_id: $user_id, user_type: $user_type, n_header: $n_header, n_message: $n_message, n_links: $n_links, time: $time, data: $data, time_stamp: $time_stamp, is_read: $is_read, uploader_info: $uploader_info, creation_date: $creation_date, is_pushed: $is_pushed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotifModel &&
        other.id == id &&
        other.user_id == user_id &&
        other.user_type == user_type &&
        other.n_header == n_header &&
        other.n_message == n_message &&
        other.n_links == n_links &&
        other.time == time &&
        other.data == data &&
        other.time_stamp == time_stamp &&
        other.is_read == is_read &&
        other.uploader_info == uploader_info &&
        other.creation_date == creation_date &&
        other.is_pushed == is_pushed;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user_id.hashCode ^
        user_type.hashCode ^
        n_header.hashCode ^
        n_message.hashCode ^
        n_links.hashCode ^
        time.hashCode ^
        data.hashCode ^
        time_stamp.hashCode ^
        is_read.hashCode ^
        uploader_info.hashCode ^
        creation_date.hashCode ^
        is_pushed.hashCode;
  }
}
