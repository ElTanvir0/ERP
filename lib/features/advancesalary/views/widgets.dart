import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/advancesalary/controller/advance_salary_controller.dart';
import 'package:new_ways_app/features/advancesalary/models/advance_salary_model.dart';
import 'package:new_ways_app/features/advancesalary/models/salary_model.dart';
import 'package:new_ways_app/utils/constants.dart';

// ignore: must_be_immutable
class SalaryTableWidget extends StatelessWidget {
  List<SalaryModel> salaries = <SalaryModel>[];
  SalaryTableWidget({Key? key, required this.salaries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (salaries.length == 0)
        ? Center(
            child: Text('Nothing to show'),
          )
        : Padding(
            padding: EdgeInsets.all(0.0),
            child: ListView.builder(
                itemCount: salaries.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => SalaryHistory(
                      salary: salaries[index],
                    )),
          );
  }
}

class SalaryHistory extends StatelessWidget {
  final SalaryModel salary;
  SalaryHistory({Key? key, required this.salary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          print(salary.id);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: deviceSize.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Month : ${salary.month}-${salary.year}',
                        style: kTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Full Day Leave : ${salary.full_day_leave} days',
                        style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Half Day Leave : ${salary.half_day_leave} days',
                        style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Absent : ${salary.total_absent} days',
                        style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Attendence : ${salary.total_attendance} days',
                        style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Salay Deduction : ${salary.slary_deduction}',
                        style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Miss Attendence Deduction : ${(salary.miss_att_deduction == '') ? '0' : salary.miss_att_deduction}',
                        style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Advance Salary : ${(salary.advance_salary == '') ? '0' : salary.advance_salary}',
                        style: kSubTitleText),
                  ],
                ),
              ),
              Container(
                width: deviceSize.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Basic Salary : ${salary.basic_sallary}',
                        style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Festival Bonus : ${salary.festival_deauty_bonus}',
                        style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Performance Bonus : ${salary.performance_bonus}',
                        style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Attendance Bonus : ${salary.attendance_bonus} days',
                        style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Attendence Wise Sallary : ${salary.attendence_wise_sallary} days',
                        style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Extra Salary : ${(salary.extra_salary == '') ? '0' : salary.extra_salary}',
                        style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Total Salary : ${(salary.total_sallary == '') ? '0' : salary.total_sallary}',
                        style: kTitleText),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AdvSalaryTableWidget extends StatelessWidget {
  List<AdvanceSalaryModel> salaries = <AdvanceSalaryModel>[];
  AdvSalaryTableWidget({Key? key, required this.salaries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (salaries.length == 0)
        ? Center(
            child: Text('Nothing to show'),
          )
        : Padding(
            padding: EdgeInsets.all(0.0),
            child: ListView.builder(
              itemCount: salaries.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => AdvSalaryHistory(
                salary: salaries[index],
              ),
            ),
          );
  }
}

// ignore: must_be_immutable
class AdvSalaryHistory extends StatelessWidget {
  SalaryController _salaryController = Get.find<SalaryController>();
  final AdvanceSalaryModel salary;
  AdvSalaryHistory({Key? key, required this.salary}) : super(key: key);
  showApprovalDialouge(AdvanceSalaryModel data, String approval) {
    bool isLoading = false;

    Get.defaultDialog(
      title: (approval == '1')
          ? 'Accept Advance Money request?'
          : 'Deny Advance Money request?',
      middleText: (approval == '1')
          ? 'You are about to Accept a Advance Money Request \nAre you sure about this?'
          : 'You are about to Deny a Advance Money Request \nAre you sure about this?',
      onCancel: () {},
      onConfirm: () async {
        if (isLoading != true) {
          isLoading = true;
          await _salaryController.respondToAdvanceSalaryRequest(approval, data);
          _salaryController.onInit();
          isLoading = false;
          Get.back();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          print(salary.id);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: deviceSize.width * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage('$baseImageUrl${salary.photo!}'),
                    ),
                    getSpacer(),
                    Text(
                      salary.designation_name!,
                      style: kSubTitleText.copyWith(fontSize: 12),
                    ),
                    Text(
                      salary.department_name!,
                      style: kSubTitleText.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),
              Container(
                width: deviceSize.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Name : ${salary.full_name}', style: kTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Ammount : ${salary.amount}', style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Reason : ${salary.note}', style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Date : ${salary.data}', style: kSubTitleText),
                  ],
                ),
              ),
              Container(
                width: deviceSize.width * 0.3,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    (salary.aproval == '2' || salary.aproval_account == '2')
                        ? Container(
                            width: deviceSize.width * 0.2,
                            child: Text('Rejected',
                                softWrap: true,
                                style: TextStyle(color: Colors.red)),
                          )
                        : (salary.aproval == '1' &&
                                salary.aproval_account == '1')
                            ? Text(
                                'Approved',
                                style: TextStyle(color: Colors.green),
                              )
                            : (salary.aproval == '0' &&
                                    _salaryController.hive!
                                            .get('employee_id') ==
                                        _salaryController.adminhive!
                                            .get('neways_boss_id'))
                                ? SizedBox()
                                : (salary.aproval == '1' &&
                                        salary.aproval_account == '0' &&
                                        _salaryController.hive!
                                                .get('department') ==
                                            '2270968637477766714')
                                    ? SizedBox()
                                    : Container(
                                        width: deviceSize.width * 0.2,
                                        child: Text(
                                            (salary.aproval == '0')
                                                ? 'Pending Boss Approval'
                                                : 'Pending Acounts Approval',
                                            style:
                                                TextStyle(color: Colors.amber)),
                                      ),
                    ((salary.aproval == '0' &&
                                (_salaryController.hive!.get('employee_id') ==
                                    _salaryController.adminhive!
                                        .get('neways_boss_id'))) ||
                            (salary.aproval_account == '0' &&
                                (_salaryController.hive!.get('department') ==
                                    '2270968637477766714') &&
                                salary.aproval == '1'))
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showApprovalDialouge(salary, '1');
                                  },
                                  icon: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    showApprovalDialouge(salary, '2');
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  )),
                            ],
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
