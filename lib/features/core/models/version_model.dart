import 'dart:convert';

class VersionControl {
  String? major;
  String? minor;
  String? patch;
  String? link;
  String? state;
  VersionControl({
    this.major,
    this.minor,
    this.patch,
    this.link,
    this.state,
  });

  VersionControl copyWith({
    String? major,
    String? minor,
    String? patch,
    String? link,
    String? state,
  }) {
    return VersionControl(
      major: major ?? this.major,
      minor: minor ?? this.minor,
      patch: patch ?? this.patch,
      link: link ?? this.link,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'major': major,
      'minor': minor,
      'patch': patch,
      'link': link,
      'state': state,
    };
  }

  factory VersionControl.fromMap(Map<String, dynamic> map) {
    return VersionControl(
      major: map['major'] != null ? map['major'] : null,
      minor: map['minor'] != null ? map['minor'] : null,
      patch: map['patch'] != null ? map['patch'] : null,
      link: map['link'] != null ? map['link'] : null,
      state: map['state'] != null ? map['state'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VersionControl.fromJson(String source) =>
      VersionControl.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VersionControl(major: $major, minor: $minor, patch: $patch, link: $link, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VersionControl &&
        other.major == major &&
        other.minor == minor &&
        other.patch == patch &&
        other.link == link &&
        other.state == state;
  }

  @override
  int get hashCode {
    return major.hashCode ^
        minor.hashCode ^
        patch.hashCode ^
        link.hashCode ^
        state.hashCode;
  }
}
