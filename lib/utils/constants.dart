import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

const String databox = 'dataBox';
const String adminbox = 'adminHiveBox';

// const String apisecret = 'api_secret_123456';
const String baseUrl = 'base Url Please';
const String baseImageUrl = 'base Image Url';

const Color kSecondaryColor = Color(0xFFf8f9fe);
const Color kPrimaryColor = Color(0xFF777df1);
const Color kTryBG = Color(0xFFFFF4BD);
const TextStyle kSubTitleText = const TextStyle(color: Colors.blueGrey);
const TextStyle kTitleText = const TextStyle(fontWeight: FontWeight.bold);

BoxDecoration getBoxDecoration = BoxDecoration(
  color: Colors.white.withOpacity(0.8),
  borderRadius: BorderRadius.circular(16),
  boxShadow: [
    BoxShadow(
      offset: const Offset(4, 4),
      blurRadius: 5,
      color: Colors.black.withOpacity(0.2),
    ),
  ],
);

nullValidator(Object? value) {
  if (value == null) {
    return "Can't Be Empty";
  } else if (value == '') {
    return "Can't Be Empty";
  } else
    return null;
}

InputDecoration getInputDecoration = InputDecoration(
    fillColor: kSecondaryColor,
    filled: true,
    hintText: 'Reason',
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none));

SizedBox getSpacer() {
  return SizedBox(
    height: 16,
  );
}

showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg, toastLength: Toast.LENGTH_LONG, backgroundColor: kPrimaryColor);
}

int getDaysinAmonth({required int year, required int month}) {
  DateTime x1 = DateTime(year, month, 0).toUtc();
  return DateTime(
          (month == 12) ? year + 1 : year, (month == 12) ? 1 : month + 1, 0)
      .toUtc()
      .difference(x1)
      .inDays;
}

String getMonthName(int month) {
  return DateFormat('MMMM').format(DateTime(0, month));
}

String getDayName(DateTime date) {
  return DateFormat('EEEE').format(date);
}
