import 'package:intl/intl.dart';

import 'userLeaveApprovalModel.dart';

class EmployeeLeaveApprovalTableModel {
  String? employeeTablePrimaryKey;
  String? employeeId;
  String? employeeLeaveTablePrimaryKey;
  String? approvalType;
  String? approvalNote;
  String? status;
  String? roleName;
  String? email;
  String? branchId;
  String? approvalDate;
  String? uploaderInfo;
  EmployeeLeaveApprovalTableModel({
    required this.employeeTablePrimaryKey,
    required this.employeeId,
    required this.employeeLeaveTablePrimaryKey,
    this.approvalType = 'Approved',
    required this.approvalNote,
    this.status = '1',
    required this.roleName,
    required this.email,
    required this.branchId,
    this.approvalDate,
  });
  factory EmployeeLeaveApprovalTableModel.fromApprovalModel(
      UserLeaveApprovalModel user) {
    return EmployeeLeaveApprovalTableModel(
        employeeTablePrimaryKey: user.e_db_id,
        employeeId: user.employee_id,
        employeeLeaveTablePrimaryKey: user.id,
        approvalNote: '',
        roleName: user.role_name!,
        email: user.email!,
        branchId: user.branch);
  }

  EmployeeLeaveApprovalTableModel.fromMap(Map m) {
    employeeTablePrimaryKey = m['e_db_id'];
    employeeId = m['employee_id'];
    employeeLeaveTablePrimaryKey = m['leave_id'];
    approvalType = m['aproval_type'];
    approvalNote = m['note'];
    status = m['status'];
    approvalDate = m['data'];
    uploaderInfo = m['uploader_info'];
  }

  Map<String, dynamic> toMap() {
    var presentDat = DateTime.now();
    var formatedPresentDate = DateFormat.yMd().format(presentDat);
    Map<String, dynamic> map = Map<String, dynamic>();
    map['e_db_id'] = employeeTablePrimaryKey;
    map['employee_id'] = employeeId;
    map['leave_id'] = employeeLeaveTablePrimaryKey;
    map['note'] = approvalNote;
    map['status'] = '1';
    map['data'] = formatedPresentDate;
    map['aproval_type'] = approvalType;

    return map;
  }

  EmployeeLeaveApprovalTableModel copyWith({
    String? employeeTablePrimaryKey,
    String? employeeId,
    String? employeeLeaveTablePrimaryKey,
    String? approvalType,
    String? approvalNote,
    String? status,
    String? roleName,
    String? email,
    String? branchId,
    String? approvalDate,
  }) {
    return EmployeeLeaveApprovalTableModel(
      employeeTablePrimaryKey:
          employeeTablePrimaryKey ?? this.employeeTablePrimaryKey,
      employeeId: employeeId ?? this.employeeId,
      employeeLeaveTablePrimaryKey:
          employeeLeaveTablePrimaryKey ?? this.employeeLeaveTablePrimaryKey,
      approvalType: approvalType ?? this.approvalType,
      approvalNote: approvalNote ?? this.approvalNote,
      status: status ?? this.status,
      roleName: roleName ?? this.roleName,
      email: email ?? this.email,
      branchId: branchId ?? this.branchId,
      approvalDate: approvalDate ?? this.approvalDate,
    );
  }
}
