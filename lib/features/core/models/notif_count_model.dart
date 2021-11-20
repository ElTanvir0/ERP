import 'dart:convert';

class NotifCountModel {
  String? count;
  NotifCountModel({
    this.count,
  });

  NotifCountModel copyWith({
    String? count,
  }) {
    return NotifCountModel(
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'count': count,
    };
  }

  factory NotifCountModel.fromMap(Map<String, dynamic> map) {
    return NotifCountModel(
      count: map['count'] != null ? map['count'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotifCountModel.fromJson(String source) =>
      NotifCountModel.fromMap(json.decode(source));

  @override
  String toString() => 'NotifCountModel(count: $count)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotifCountModel && other.count == count;
  }

  @override
  int get hashCode => count.hashCode;
}
