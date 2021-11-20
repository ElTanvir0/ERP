import 'dart:convert';

class BranchModelCR {
  String? branch_id;
  String? branch_name;
  BranchModelCR({
    this.branch_id,
    this.branch_name,
  });

  BranchModelCR copyWith({
    String? branch_id,
    String? branch_name,
  }) {
    return BranchModelCR(
      branch_id: branch_id ?? this.branch_id,
      branch_name: branch_name ?? this.branch_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'branch_id': branch_id,
      'branch_name': branch_name,
    };
  }

  factory BranchModelCR.fromMap(Map<String, dynamic> map) {
    return BranchModelCR(
      branch_id: map['branch_id'] != null ? map['branch_id'] : null,
      branch_name: map['branch_name'] != null ? map['branch_name'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BranchModelCR.fromJson(String source) =>
      BranchModelCR.fromMap(json.decode(source));

  @override
  String toString() =>
      'BranchModelCR(branch_id: $branch_id, branch_name: $branch_name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BranchModelCR &&
        other.branch_id == branch_id &&
        other.branch_name == branch_name;
  }

  @override
  int get hashCode => branch_id.hashCode ^ branch_name.hashCode;
}
