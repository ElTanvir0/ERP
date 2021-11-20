class UserLeaveModelForEveryDayLeaveLog {
  late final String uniqueId;
  late final String howManyDays;
  late final String day;
  late final String month;
  late final String year;
  late final String fullDate;
  late final String status;
  late final String uploaderInfo;
  late final String data;

  Map<String, dynamic> toMapForEveryDayLeavLogTable() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['unique_id'] = '239572678157494080';
    map['h_days'] = '1';
    map['days'] = this.day;
    map['month'] = this.month;
    map['year'] = this.year;
    map['date_full'] = this.fullDate;
    map['status'] = '1';
    map['uploader_info'] =
        "Super Admin___2010mdibrahim@gmail.com___BAR_011220_210463187872898170_1606780607";
    map['data'] = "03/07/2021";

    return map;
  }
}
