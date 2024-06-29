import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

//create a unique id usign uuid
final uuid = const Uuid().v4();
//date format
final formattedDate = DateFormat.yMd();

//enum Category
enum Category { work, food, travel, leasure }

//category icons
final CategoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leasure: Icons.local_movies,
  Category.travel: Icons.airplanemode_active,
  Category.work: Icons.work,
};

class ExpenceModel {
  ExpenceModel({
    required this.amount,
    required this.date,
    required this.title,
    required this.category,
  }) : id = uuid;
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  //getter > formated date
  String get getFormattedDate {
    return formattedDate.format(date);
  }
}
