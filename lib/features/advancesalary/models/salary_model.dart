import 'dart:convert';

class SalaryModel {
  String? id;
  String? unique_id;
  String? employee_id;
  String? month;
  String? year;
  String? date_full;
  String? total_number_of_days;
  String? full_day_leave;
  String? half_day_leave;
  String? total_attendance;
  String? total_absent;
  String? festival_deauty_bonus;
  String? attendance_bonus;
  String? performance_bonus;
  String? performance_bonus_percentage;
  String? basic_sallary;
  String? attendence_wise_sallary;
  String? slary_deduction;
  String? miss_att_deduction;
  String? extra_salary;
  String? advance_salary;
  String? total_sallary;
  String? salary_pay_method;
  String? note;
  String? status;
  String? uploader_info;
  String? data;
  SalaryModel({
    this.id,
    this.unique_id,
    this.employee_id,
    this.month,
    this.year,
    this.date_full,
    this.total_number_of_days,
    this.full_day_leave,
    this.half_day_leave,
    this.total_attendance,
    this.total_absent,
    this.festival_deauty_bonus,
    this.attendance_bonus,
    this.performance_bonus,
    this.performance_bonus_percentage,
    this.basic_sallary,
    this.attendence_wise_sallary,
    this.slary_deduction,
    this.miss_att_deduction,
    this.extra_salary,
    this.advance_salary,
    this.total_sallary,
    this.salary_pay_method,
    this.note,
    this.status,
    this.uploader_info,
    this.data,
  });

  SalaryModel copyWith({
    String? id,
    String? unique_id,
    String? employee_id,
    String? month,
    String? year,
    String? date_full,
    String? total_number_of_days,
    String? full_day_leave,
    String? half_day_leave,
    String? total_attendance,
    String? total_absent,
    String? festival_deauty_bonus,
    String? attendance_bonus,
    String? performance_bonus,
    String? performance_bonus_percentage,
    String? basic_sallary,
    String? attendence_wise_sallary,
    String? slary_deduction,
    String? miss_att_deduction,
    String? extra_salary,
    String? advance_salary,
    String? total_sallary,
    String? salary_pay_method,
    String? note,
    String? status,
    String? uploader_info,
    String? data,
  }) {
    return SalaryModel(
      id: id ?? this.id,
      unique_id: unique_id ?? this.unique_id,
      employee_id: employee_id ?? this.employee_id,
      month: month ?? this.month,
      year: year ?? this.year,
      date_full: date_full ?? this.date_full,
      total_number_of_days: total_number_of_days ?? this.total_number_of_days,
      full_day_leave: full_day_leave ?? this.full_day_leave,
      half_day_leave: half_day_leave ?? this.half_day_leave,
      total_attendance: total_attendance ?? this.total_attendance,
      total_absent: total_absent ?? this.total_absent,
      festival_deauty_bonus:
          festival_deauty_bonus ?? this.festival_deauty_bonus,
      attendance_bonus: attendance_bonus ?? this.attendance_bonus,
      performance_bonus: performance_bonus ?? this.performance_bonus,
      performance_bonus_percentage:
          performance_bonus_percentage ?? this.performance_bonus_percentage,
      basic_sallary: basic_sallary ?? this.basic_sallary,
      attendence_wise_sallary:
          attendence_wise_sallary ?? this.attendence_wise_sallary,
      slary_deduction: slary_deduction ?? this.slary_deduction,
      miss_att_deduction: miss_att_deduction ?? this.miss_att_deduction,
      extra_salary: extra_salary ?? this.extra_salary,
      advance_salary: advance_salary ?? this.advance_salary,
      total_sallary: total_sallary ?? this.total_sallary,
      salary_pay_method: salary_pay_method ?? this.salary_pay_method,
      note: note ?? this.note,
      status: status ?? this.status,
      uploader_info: uploader_info ?? this.uploader_info,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unique_id': unique_id,
      'employee_id': employee_id,
      'month': month,
      'year': year,
      'date_full': date_full,
      'total_number_of_days': total_number_of_days,
      'full_day_leave': full_day_leave,
      'half_day_leave': half_day_leave,
      'total_attendance': total_attendance,
      'total_absent': total_absent,
      'festival_deauty_bonus': festival_deauty_bonus,
      'attendance_bonus': attendance_bonus,
      'performance_bonus': performance_bonus,
      'performance_bonus_percentage': performance_bonus_percentage,
      'basic_sallary': basic_sallary,
      'attendence_wise_sallary': attendence_wise_sallary,
      'slary_deduction': slary_deduction,
      'miss_att_deduction': miss_att_deduction,
      'extra_salary': extra_salary,
      'advance_salary': advance_salary,
      'total_sallary': total_sallary,
      'salary_pay_method': salary_pay_method,
      'note': note,
      'status': status,
      'uploader_info': uploader_info,
      'data': data,
    };
  }

  factory SalaryModel.fromMap(Map<String, dynamic> map) {
    return SalaryModel(
      id: map['id'],
      unique_id: map['unique_id'],
      employee_id: map['employee_id'],
      month: map['month'],
      year: map['year'],
      date_full: map['date_full'],
      total_number_of_days: map['total_number_of_days'],
      full_day_leave: map['full_day_leave'],
      half_day_leave: map['half_day_leave'],
      total_attendance: map['total_attendance'],
      total_absent: map['total_absent'],
      festival_deauty_bonus: map['festival_deauty_bonus'],
      attendance_bonus: map['attendance_bonus'],
      performance_bonus: map['performance_bonus'],
      performance_bonus_percentage: map['performance_bonus_percentage'],
      basic_sallary: map['basic_sallary'],
      attendence_wise_sallary: map['attendence_wise_sallary'],
      slary_deduction: map['slary_deduction'],
      miss_att_deduction: map['miss_att_deduction'],
      extra_salary: map['extra_salary'],
      advance_salary: map['advance_salary'],
      total_sallary: map['total_sallary'],
      salary_pay_method: map['salary_pay_method'],
      note: map['note'],
      status: map['status'],
      uploader_info: map['uploader_info'],
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SalaryModel.fromJson(String source) =>
      SalaryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SalaryModel(id: $id, unique_id: $unique_id, employee_id: $employee_id, month: $month, year: $year, date_full: $date_full, total_number_of_days: $total_number_of_days, full_day_leave: $full_day_leave, half_day_leave: $half_day_leave, total_attendance: $total_attendance, total_absent: $total_absent, festival_deauty_bonus: $festival_deauty_bonus, attendance_bonus: $attendance_bonus, performance_bonus: $performance_bonus, performance_bonus_percentage: $performance_bonus_percentage, basic_sallary: $basic_sallary, attendence_wise_sallary: $attendence_wise_sallary, slary_deduction: $slary_deduction, miss_att_deduction: $miss_att_deduction, extra_salary: $extra_salary, advance_salary: $advance_salary, total_sallary: $total_sallary, salary_pay_method: $salary_pay_method, note: $note, status: $status, uploader_info: $uploader_info, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SalaryModel &&
        other.id == id &&
        other.unique_id == unique_id &&
        other.employee_id == employee_id &&
        other.month == month &&
        other.year == year &&
        other.date_full == date_full &&
        other.total_number_of_days == total_number_of_days &&
        other.full_day_leave == full_day_leave &&
        other.half_day_leave == half_day_leave &&
        other.total_attendance == total_attendance &&
        other.total_absent == total_absent &&
        other.festival_deauty_bonus == festival_deauty_bonus &&
        other.attendance_bonus == attendance_bonus &&
        other.performance_bonus == performance_bonus &&
        other.performance_bonus_percentage == performance_bonus_percentage &&
        other.basic_sallary == basic_sallary &&
        other.attendence_wise_sallary == attendence_wise_sallary &&
        other.slary_deduction == slary_deduction &&
        other.miss_att_deduction == miss_att_deduction &&
        other.extra_salary == extra_salary &&
        other.advance_salary == advance_salary &&
        other.total_sallary == total_sallary &&
        other.salary_pay_method == salary_pay_method &&
        other.note == note &&
        other.status == status &&
        other.uploader_info == uploader_info &&
        other.data == data;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        unique_id.hashCode ^
        employee_id.hashCode ^
        month.hashCode ^
        year.hashCode ^
        date_full.hashCode ^
        total_number_of_days.hashCode ^
        full_day_leave.hashCode ^
        half_day_leave.hashCode ^
        total_attendance.hashCode ^
        total_absent.hashCode ^
        festival_deauty_bonus.hashCode ^
        attendance_bonus.hashCode ^
        performance_bonus.hashCode ^
        performance_bonus_percentage.hashCode ^
        basic_sallary.hashCode ^
        attendence_wise_sallary.hashCode ^
        slary_deduction.hashCode ^
        miss_att_deduction.hashCode ^
        extra_salary.hashCode ^
        advance_salary.hashCode ^
        total_sallary.hashCode ^
        salary_pay_method.hashCode ^
        note.hashCode ^
        status.hashCode ^
        uploader_info.hashCode ^
        data.hashCode;
  }
}
