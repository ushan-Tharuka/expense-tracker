import 'package:uuid/uuid.dart';

//create a unique id usign uuid
final uuid = const Uuid().v4();

//enum Category
enum Category { work, food, travel, leasure }

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
}
