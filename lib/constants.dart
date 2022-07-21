import 'package:flutter/material.dart';

final branches = [
  "IT-1",
  "IT-2",
  "IT-3",
  "CSE-1",
  "CSE-2",
  "CSE-3",
  "ECE-1",
  "ECE-2",
  "ECE-3",
];

final semesters = ["1", "2", "3", "4", "5", "6", "7", "8"];

final genders = ["Female", "Male", "Other"];

final bloodGroups = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];

final phoneRegex = RegExp(r"\d{10}");
final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final spaceRegex = RegExp(r"\s");

enum devices { mobile, tablet, laptop, desktop, tv }

devices getDevice(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < 480) {
    return devices.mobile;
  }
  if (width < 768) {
    return devices.tablet;
  }
  if (width < 1024) {
    return devices.laptop;
  }
  if (width < 1200) {
    return devices.desktop;
  }
  return devices.tv;
}

double getCardWidth(BuildContext context) {
  final device = getDevice(context);
  switch (device) {
    case devices.mobile:
      return 350;
    case devices.tablet:
      return 400;
    case devices.laptop:
      return 450;
    case devices.desktop:
      return 500;
    case devices.tv:
      return 550;
  }
}

void showSnackBar({required BuildContext context, required String msg}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}
