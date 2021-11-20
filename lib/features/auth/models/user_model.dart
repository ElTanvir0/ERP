import 'dart:convert';

class UserModel {
  String? id;
  String? employee_id;
  String? role;
  String? role_name;
  String? designation;
  String? designation_name;
  String? department;
  String? department_name;
  String? grade_id;
  String? grade_name;
  String? f_name;
  String? l_name;
  String? full_name;
  String? father_name;
  String? mother_name;
  String? gender;
  String? marital_status;
  String? date_of_birth;
  String? date_of_joining;
  String? blood_group;
  String? personal_Phone;
  String? email;
  String? password;
  String? photo;
  String? Company_phone;
  String? company_email;
  String? nid_number;
  String? branch;
  String? emergency_contact_name;
  String? emergency_contact_relation;
  String? emergency_no1;
  String? emergency_contact_name2;
  String? emergency_contact_relation2;
  String? emergency_no2;
  String? emergency_attachment_1;
  String? emergency_attachment_2;
  String? current_address;
  String? permanent_address;
  String? qualification;
  String? work_exp;
  String? job_responsibilities;
  String? note;
  String? previus_company;
  String? previus_designation;
  String? reason_leave;
  String? basic_salary;
  String? mobile_allowance;
  String? salary_pay_method;
  String? contruct_type;
  String? work_shift;
  String? assign_bed;
  String? bank_account_title;
  String? bank_account_number;
  String? bank_name;
  String? bfsc_code;
  String? bank_branch_name;
  String? account_type;
  String? facebook;
  String? twitter;
  String? linkedin;
  String? instagram;
  String? first_doc;
  String? second_doc;
  String? thired_doc;
  String? forth_doc;
  String? status;
  String? uploader_info;
  String? data;
  String? extra_note;
  String? d_head;
  String? d_head_reporting;
  String? religion;
  String? release_type;
  UserModel({
    this.id,
    this.employee_id,
    this.role,
    this.role_name,
    this.designation,
    this.designation_name,
    this.department,
    this.department_name,
    this.grade_id,
    this.grade_name,
    this.f_name,
    this.l_name,
    this.full_name,
    this.father_name,
    this.mother_name,
    this.gender,
    this.marital_status,
    this.date_of_birth,
    this.date_of_joining,
    this.blood_group,
    this.personal_Phone,
    this.email,
    this.password,
    this.photo,
    this.Company_phone,
    this.company_email,
    this.nid_number,
    this.branch,
    this.emergency_contact_name,
    this.emergency_contact_relation,
    this.emergency_no1,
    this.emergency_contact_name2,
    this.emergency_contact_relation2,
    this.emergency_no2,
    this.emergency_attachment_1,
    this.emergency_attachment_2,
    this.current_address,
    this.permanent_address,
    this.qualification,
    this.work_exp,
    this.job_responsibilities,
    this.note,
    this.previus_company,
    this.previus_designation,
    this.reason_leave,
    this.basic_salary,
    this.mobile_allowance,
    this.salary_pay_method,
    this.contruct_type,
    this.work_shift,
    this.assign_bed,
    this.bank_account_title,
    this.bank_account_number,
    this.bank_name,
    this.bfsc_code,
    this.bank_branch_name,
    this.account_type,
    this.facebook,
    this.twitter,
    this.linkedin,
    this.instagram,
    this.first_doc,
    this.second_doc,
    this.thired_doc,
    this.forth_doc,
    this.status,
    this.uploader_info,
    this.data,
    this.extra_note,
    this.d_head,
    this.d_head_reporting,
    this.religion,
    this.release_type,
  });

  UserModel copyWith({
    String? id,
    String? employee_id,
    String? role,
    String? role_name,
    String? designation,
    String? designation_name,
    String? department,
    String? department_name,
    String? grade_id,
    String? grade_name,
    String? f_name,
    String? l_name,
    String? full_name,
    String? father_name,
    String? mother_name,
    String? gender,
    String? marital_status,
    String? date_of_birth,
    String? date_of_joining,
    String? blood_group,
    String? personal_Phone,
    String? email,
    String? password,
    String? photo,
    String? Company_phone,
    String? company_email,
    String? nid_number,
    String? branch,
    String? emergency_contact_name,
    String? emergency_contact_relation,
    String? emergency_no1,
    String? emergency_contact_name2,
    String? emergency_contact_relation2,
    String? emergency_no2,
    String? emergency_attachment_1,
    String? emergency_attachment_2,
    String? current_address,
    String? permanent_address,
    String? qualification,
    String? work_exp,
    String? job_responsibilities,
    String? note,
    String? previus_company,
    String? previus_designation,
    String? reason_leave,
    String? basic_salary,
    String? mobile_allowance,
    String? salary_pay_method,
    String? contruct_type,
    String? work_shift,
    String? assign_bed,
    String? bank_account_title,
    String? bank_account_number,
    String? bank_name,
    String? bfsc_code,
    String? bank_branch_name,
    String? account_type,
    String? facebook,
    String? twitter,
    String? linkedin,
    String? instagram,
    String? first_doc,
    String? second_doc,
    String? thired_doc,
    String? forth_doc,
    String? status,
    String? uploader_info,
    String? data,
    String? extra_note,
    String? d_head,
    String? d_head_reporting,
    String? religion,
    String? release_type,
  }) {
    return UserModel(
      id: id ?? this.id,
      employee_id: employee_id ?? this.employee_id,
      role: role ?? this.role,
      role_name: role_name ?? this.role_name,
      designation: designation ?? this.designation,
      designation_name: designation_name ?? this.designation_name,
      department: department ?? this.department,
      department_name: department_name ?? this.department_name,
      grade_id: grade_id ?? this.grade_id,
      grade_name: grade_name ?? this.grade_name,
      f_name: f_name ?? this.f_name,
      l_name: l_name ?? this.l_name,
      full_name: full_name ?? this.full_name,
      father_name: father_name ?? this.father_name,
      mother_name: mother_name ?? this.mother_name,
      gender: gender ?? this.gender,
      marital_status: marital_status ?? this.marital_status,
      date_of_birth: date_of_birth ?? this.date_of_birth,
      date_of_joining: date_of_joining ?? this.date_of_joining,
      blood_group: blood_group ?? this.blood_group,
      personal_Phone: personal_Phone ?? this.personal_Phone,
      email: email ?? this.email,
      password: password ?? this.password,
      photo: photo ?? this.photo,
      Company_phone: Company_phone ?? this.Company_phone,
      company_email: company_email ?? this.company_email,
      nid_number: nid_number ?? this.nid_number,
      branch: branch ?? this.branch,
      emergency_contact_name:
          emergency_contact_name ?? this.emergency_contact_name,
      emergency_contact_relation:
          emergency_contact_relation ?? this.emergency_contact_relation,
      emergency_no1: emergency_no1 ?? this.emergency_no1,
      emergency_contact_name2:
          emergency_contact_name2 ?? this.emergency_contact_name2,
      emergency_contact_relation2:
          emergency_contact_relation2 ?? this.emergency_contact_relation2,
      emergency_no2: emergency_no2 ?? this.emergency_no2,
      emergency_attachment_1:
          emergency_attachment_1 ?? this.emergency_attachment_1,
      emergency_attachment_2:
          emergency_attachment_2 ?? this.emergency_attachment_2,
      current_address: current_address ?? this.current_address,
      permanent_address: permanent_address ?? this.permanent_address,
      qualification: qualification ?? this.qualification,
      work_exp: work_exp ?? this.work_exp,
      job_responsibilities: job_responsibilities ?? this.job_responsibilities,
      note: note ?? this.note,
      previus_company: previus_company ?? this.previus_company,
      previus_designation: previus_designation ?? this.previus_designation,
      reason_leave: reason_leave ?? this.reason_leave,
      basic_salary: basic_salary ?? this.basic_salary,
      mobile_allowance: mobile_allowance ?? this.mobile_allowance,
      salary_pay_method: salary_pay_method ?? this.salary_pay_method,
      contruct_type: contruct_type ?? this.contruct_type,
      work_shift: work_shift ?? this.work_shift,
      assign_bed: assign_bed ?? this.assign_bed,
      bank_account_title: bank_account_title ?? this.bank_account_title,
      bank_account_number: bank_account_number ?? this.bank_account_number,
      bank_name: bank_name ?? this.bank_name,
      bfsc_code: bfsc_code ?? this.bfsc_code,
      bank_branch_name: bank_branch_name ?? this.bank_branch_name,
      account_type: account_type ?? this.account_type,
      facebook: facebook ?? this.facebook,
      twitter: twitter ?? this.twitter,
      linkedin: linkedin ?? this.linkedin,
      instagram: instagram ?? this.instagram,
      first_doc: first_doc ?? this.first_doc,
      second_doc: second_doc ?? this.second_doc,
      thired_doc: thired_doc ?? this.thired_doc,
      forth_doc: forth_doc ?? this.forth_doc,
      status: status ?? this.status,
      uploader_info: uploader_info ?? this.uploader_info,
      data: data ?? this.data,
      extra_note: extra_note ?? this.extra_note,
      d_head: d_head ?? this.d_head,
      d_head_reporting: d_head_reporting ?? this.d_head_reporting,
      religion: religion ?? this.religion,
      release_type: release_type ?? this.release_type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employee_id': employee_id,
      'role': role,
      'role_name': role_name,
      'designation': designation,
      'designation_name': designation_name,
      'department': department,
      'department_name': department_name,
      'grade_id': grade_id,
      'grade_name': grade_name,
      'f_name': f_name,
      'l_name': l_name,
      'full_name': full_name,
      'father_name': father_name,
      'mother_name': mother_name,
      'gender': gender,
      'marital_status': marital_status,
      'date_of_birth': date_of_birth,
      'date_of_joining': date_of_joining,
      'blood_group': blood_group,
      'personal_Phone': personal_Phone,
      'email': email,
      'password': password,
      'photo': photo,
      'Company_phone': Company_phone,
      'company_email': company_email,
      'nid_number': nid_number,
      'branch': branch,
      'emergency_contact_name': emergency_contact_name,
      'emergency_contact_relation': emergency_contact_relation,
      'emergency_no1': emergency_no1,
      'emergency_contact_name2': emergency_contact_name2,
      'emergency_contact_relation2': emergency_contact_relation2,
      'emergency_no2': emergency_no2,
      'emergency_attachment_1': emergency_attachment_1,
      'emergency_attachment_2': emergency_attachment_2,
      'current_address': current_address,
      'permanent_address': permanent_address,
      'qualification': qualification,
      'work_exp': work_exp,
      'job_responsibilities': job_responsibilities,
      'note': note,
      'previus_company': previus_company,
      'previus_designation': previus_designation,
      'reason_leave': reason_leave,
      'basic_salary': basic_salary,
      'mobile_allowance': mobile_allowance,
      'salary_pay_method': salary_pay_method,
      'contruct_type': contruct_type,
      'work_shift': work_shift,
      'assign_bed': assign_bed,
      'bank_account_title': bank_account_title,
      'bank_account_number': bank_account_number,
      'bank_name': bank_name,
      'bfsc_code': bfsc_code,
      'bank_branch_name': bank_branch_name,
      'account_type': account_type,
      'facebook': facebook,
      'twitter': twitter,
      'linkedin': linkedin,
      'instagram': instagram,
      'first_doc': first_doc,
      'second_doc': second_doc,
      'thired_doc': thired_doc,
      'forth_doc': forth_doc,
      'status': status,
      'uploader_info': uploader_info,
      'data': data,
      'extra_note': extra_note,
      'd_head': d_head,
      'd_head_reporting': d_head_reporting,
      'religion': religion,
      'release_type': release_type,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] : null,
      employee_id: map['employee_id'] != null ? map['employee_id'] : null,
      role: map['role'] != null ? map['role'] : null,
      role_name: map['role_name'] != null ? map['role_name'] : null,
      designation: map['designation'] != null ? map['designation'] : null,
      designation_name:
          map['designation_name'] != null ? map['designation_name'] : null,
      department: map['department'] != null ? map['department'] : null,
      department_name:
          map['department_name'] != null ? map['department_name'] : null,
      grade_id: map['grade_id'] != null ? map['grade_id'] : null,
      grade_name: map['grade_name'] != null ? map['grade_name'] : null,
      f_name: map['f_name'] != null ? map['f_name'] : null,
      l_name: map['l_name'] != null ? map['l_name'] : null,
      full_name: map['full_name'] != null ? map['full_name'] : null,
      father_name: map['father_name'] != null ? map['father_name'] : null,
      mother_name: map['mother_name'] != null ? map['mother_name'] : null,
      gender: map['gender'] != null ? map['gender'] : null,
      marital_status:
          map['marital_status'] != null ? map['marital_status'] : null,
      date_of_birth: map['date_of_birth'] != null ? map['date_of_birth'] : null,
      date_of_joining:
          map['date_of_joining'] != null ? map['date_of_joining'] : null,
      blood_group: map['blood_group'] != null ? map['blood_group'] : null,
      personal_Phone:
          map['personal_Phone'] != null ? map['personal_Phone'] : null,
      email: map['email'] != null ? map['email'] : null,
      password: map['password'] != null ? map['password'] : null,
      photo: map['photo'] != null ? map['photo'] : null,
      Company_phone: map['Company_phone'] != null ? map['Company_phone'] : null,
      company_email: map['company_email'] != null ? map['company_email'] : null,
      nid_number: map['nid_number'] != null ? map['nid_number'] : null,
      branch: map['branch'] != null ? map['branch'] : null,
      emergency_contact_name: map['emergency_contact_name'] != null
          ? map['emergency_contact_name']
          : null,
      emergency_contact_relation: map['emergency_contact_relation'] != null
          ? map['emergency_contact_relation']
          : null,
      emergency_no1: map['emergency_no1'] != null ? map['emergency_no1'] : null,
      emergency_contact_name2: map['emergency_contact_name2'] != null
          ? map['emergency_contact_name2']
          : null,
      emergency_contact_relation2: map['emergency_contact_relation2'] != null
          ? map['emergency_contact_relation2']
          : null,
      emergency_no2: map['emergency_no2'] != null ? map['emergency_no2'] : null,
      emergency_attachment_1: map['emergency_attachment_1'] != null
          ? map['emergency_attachment_1']
          : null,
      emergency_attachment_2: map['emergency_attachment_2'] != null
          ? map['emergency_attachment_2']
          : null,
      current_address:
          map['current_address'] != null ? map['current_address'] : null,
      permanent_address:
          map['permanent_address'] != null ? map['permanent_address'] : null,
      qualification: map['qualification'] != null ? map['qualification'] : null,
      work_exp: map['work_exp'] != null ? map['work_exp'] : null,
      job_responsibilities: map['job_responsibilities'] != null
          ? map['job_responsibilities']
          : null,
      note: map['note'] != null ? map['note'] : null,
      previus_company:
          map['previus_company'] != null ? map['previus_company'] : null,
      previus_designation: map['previus_designation'] != null
          ? map['previus_designation']
          : null,
      reason_leave: map['reason_leave'] != null ? map['reason_leave'] : null,
      basic_salary: map['basic_salary'] != null ? map['basic_salary'] : null,
      mobile_allowance:
          map['mobile_allowance'] != null ? map['mobile_allowance'] : null,
      salary_pay_method:
          map['salary_pay_method'] != null ? map['salary_pay_method'] : null,
      contruct_type: map['contruct_type'] != null ? map['contruct_type'] : null,
      work_shift: map['work_shift'] != null ? map['work_shift'] : null,
      assign_bed: map['assign_bed'] != null ? map['assign_bed'] : null,
      bank_account_title:
          map['bank_account_title'] != null ? map['bank_account_title'] : null,
      bank_account_number: map['bank_account_number'] != null
          ? map['bank_account_number']
          : null,
      bank_name: map['bank_name'] != null ? map['bank_name'] : null,
      bfsc_code: map['bfsc_code'] != null ? map['bfsc_code'] : null,
      bank_branch_name:
          map['bank_branch_name'] != null ? map['bank_branch_name'] : null,
      account_type: map['account_type'] != null ? map['account_type'] : null,
      facebook: map['facebook'] != null ? map['facebook'] : null,
      twitter: map['twitter'] != null ? map['twitter'] : null,
      linkedin: map['linkedin'] != null ? map['linkedin'] : null,
      instagram: map['instagram'] != null ? map['instagram'] : null,
      first_doc: map['first_doc'] != null ? map['first_doc'] : null,
      second_doc: map['second_doc'] != null ? map['second_doc'] : null,
      thired_doc: map['thired_doc'] != null ? map['thired_doc'] : null,
      forth_doc: map['forth_doc'] != null ? map['forth_doc'] : null,
      status: map['status'] != null ? map['status'] : null,
      uploader_info: map['uploader_info'] != null ? map['uploader_info'] : null,
      data: map['data'] != null ? map['data'] : null,
      extra_note: map['extra_note'] != null ? map['extra_note'] : null,
      d_head: map['d_head'] != null ? map['d_head'] : null,
      d_head_reporting:
          map['d_head_reporting'] != null ? map['d_head_reporting'] : null,
      religion: map['religion'] != null ? map['religion'] : null,
      release_type: map['release_type'] != null ? map['release_type'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, employee_id: $employee_id, role: $role, role_name: $role_name, designation: $designation, designation_name: $designation_name, department: $department, department_name: $department_name, grade_id: $grade_id, grade_name: $grade_name, f_name: $f_name, l_name: $l_name, full_name: $full_name, father_name: $father_name, mother_name: $mother_name, gender: $gender, marital_status: $marital_status, date_of_birth: $date_of_birth, date_of_joining: $date_of_joining, blood_group: $blood_group, personal_Phone: $personal_Phone, email: $email, password: $password, photo: $photo, Company_phone: $Company_phone, company_email: $company_email, nid_number: $nid_number, branch: $branch, emergency_contact_name: $emergency_contact_name, emergency_contact_relation: $emergency_contact_relation, emergency_no1: $emergency_no1, emergency_contact_name2: $emergency_contact_name2, emergency_contact_relation2: $emergency_contact_relation2, emergency_no2: $emergency_no2, emergency_attachment_1: $emergency_attachment_1, emergency_attachment_2: $emergency_attachment_2, current_address: $current_address, permanent_address: $permanent_address, qualification: $qualification, work_exp: $work_exp, job_responsibilities: $job_responsibilities, note: $note, previus_company: $previus_company, previus_designation: $previus_designation, reason_leave: $reason_leave, basic_salary: $basic_salary, mobile_allowance: $mobile_allowance, salary_pay_method: $salary_pay_method, contruct_type: $contruct_type, work_shift: $work_shift, assign_bed: $assign_bed, bank_account_title: $bank_account_title, bank_account_number: $bank_account_number, bank_name: $bank_name, bfsc_code: $bfsc_code, bank_branch_name: $bank_branch_name, account_type: $account_type, facebook: $facebook, twitter: $twitter, linkedin: $linkedin, instagram: $instagram, first_doc: $first_doc, second_doc: $second_doc, thired_doc: $thired_doc, forth_doc: $forth_doc, status: $status, uploader_info: $uploader_info, data: $data, extra_note: $extra_note, d_head: $d_head, d_head_reporting: $d_head_reporting, religion: $religion, release_type: $release_type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.employee_id == employee_id &&
        other.role == role &&
        other.role_name == role_name &&
        other.designation == designation &&
        other.designation_name == designation_name &&
        other.department == department &&
        other.department_name == department_name &&
        other.grade_id == grade_id &&
        other.grade_name == grade_name &&
        other.f_name == f_name &&
        other.l_name == l_name &&
        other.full_name == full_name &&
        other.father_name == father_name &&
        other.mother_name == mother_name &&
        other.gender == gender &&
        other.marital_status == marital_status &&
        other.date_of_birth == date_of_birth &&
        other.date_of_joining == date_of_joining &&
        other.blood_group == blood_group &&
        other.personal_Phone == personal_Phone &&
        other.email == email &&
        other.password == password &&
        other.photo == photo &&
        other.Company_phone == Company_phone &&
        other.company_email == company_email &&
        other.nid_number == nid_number &&
        other.branch == branch &&
        other.emergency_contact_name == emergency_contact_name &&
        other.emergency_contact_relation == emergency_contact_relation &&
        other.emergency_no1 == emergency_no1 &&
        other.emergency_contact_name2 == emergency_contact_name2 &&
        other.emergency_contact_relation2 == emergency_contact_relation2 &&
        other.emergency_no2 == emergency_no2 &&
        other.emergency_attachment_1 == emergency_attachment_1 &&
        other.emergency_attachment_2 == emergency_attachment_2 &&
        other.current_address == current_address &&
        other.permanent_address == permanent_address &&
        other.qualification == qualification &&
        other.work_exp == work_exp &&
        other.job_responsibilities == job_responsibilities &&
        other.note == note &&
        other.previus_company == previus_company &&
        other.previus_designation == previus_designation &&
        other.reason_leave == reason_leave &&
        other.basic_salary == basic_salary &&
        other.mobile_allowance == mobile_allowance &&
        other.salary_pay_method == salary_pay_method &&
        other.contruct_type == contruct_type &&
        other.work_shift == work_shift &&
        other.assign_bed == assign_bed &&
        other.bank_account_title == bank_account_title &&
        other.bank_account_number == bank_account_number &&
        other.bank_name == bank_name &&
        other.bfsc_code == bfsc_code &&
        other.bank_branch_name == bank_branch_name &&
        other.account_type == account_type &&
        other.facebook == facebook &&
        other.twitter == twitter &&
        other.linkedin == linkedin &&
        other.instagram == instagram &&
        other.first_doc == first_doc &&
        other.second_doc == second_doc &&
        other.thired_doc == thired_doc &&
        other.forth_doc == forth_doc &&
        other.status == status &&
        other.uploader_info == uploader_info &&
        other.data == data &&
        other.extra_note == extra_note &&
        other.d_head == d_head &&
        other.d_head_reporting == d_head_reporting &&
        other.religion == religion &&
        other.release_type == release_type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        employee_id.hashCode ^
        role.hashCode ^
        role_name.hashCode ^
        designation.hashCode ^
        designation_name.hashCode ^
        department.hashCode ^
        department_name.hashCode ^
        grade_id.hashCode ^
        grade_name.hashCode ^
        f_name.hashCode ^
        l_name.hashCode ^
        full_name.hashCode ^
        father_name.hashCode ^
        mother_name.hashCode ^
        gender.hashCode ^
        marital_status.hashCode ^
        date_of_birth.hashCode ^
        date_of_joining.hashCode ^
        blood_group.hashCode ^
        personal_Phone.hashCode ^
        email.hashCode ^
        password.hashCode ^
        photo.hashCode ^
        Company_phone.hashCode ^
        company_email.hashCode ^
        nid_number.hashCode ^
        branch.hashCode ^
        emergency_contact_name.hashCode ^
        emergency_contact_relation.hashCode ^
        emergency_no1.hashCode ^
        emergency_contact_name2.hashCode ^
        emergency_contact_relation2.hashCode ^
        emergency_no2.hashCode ^
        emergency_attachment_1.hashCode ^
        emergency_attachment_2.hashCode ^
        current_address.hashCode ^
        permanent_address.hashCode ^
        qualification.hashCode ^
        work_exp.hashCode ^
        job_responsibilities.hashCode ^
        note.hashCode ^
        previus_company.hashCode ^
        previus_designation.hashCode ^
        reason_leave.hashCode ^
        basic_salary.hashCode ^
        mobile_allowance.hashCode ^
        salary_pay_method.hashCode ^
        contruct_type.hashCode ^
        work_shift.hashCode ^
        assign_bed.hashCode ^
        bank_account_title.hashCode ^
        bank_account_number.hashCode ^
        bank_name.hashCode ^
        bfsc_code.hashCode ^
        bank_branch_name.hashCode ^
        account_type.hashCode ^
        facebook.hashCode ^
        twitter.hashCode ^
        linkedin.hashCode ^
        instagram.hashCode ^
        first_doc.hashCode ^
        second_doc.hashCode ^
        thired_doc.hashCode ^
        forth_doc.hashCode ^
        status.hashCode ^
        uploader_info.hashCode ^
        data.hashCode ^
        extra_note.hashCode ^
        d_head.hashCode ^
        d_head_reporting.hashCode ^
        religion.hashCode ^
        release_type.hashCode;
  }
}
