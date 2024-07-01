import 'package:flutter_advance/models/expence.dart';
import 'package:hive/hive.dart';

class Database {
  //create a database reference
  final _mybox = Hive.box("expenceDatabase");

  List<ExpenceModel> expenceList = [];
  //crea the init expence list function

  void createInitialDatabase() {
    expenceList = [
      ExpenceModel(
          amount: 10.5,
          date: DateTime.now(),
          title: "Cricket",
          category: Category.leasure),
      ExpenceModel(
          amount: 10.9,
          date: DateTime.now(),
          title: "Rice",
          category: Category.food),
      ExpenceModel(
          amount: 20,
          date: DateTime.now(),
          title: "Bag",
          category: Category.travel),
    ];
  }

  //load the data
  void loadData() {
    final dynamic data = _mybox.get("EXP_DATA");
    //validate the data
    if (data != null && data is List<dynamic>) {
      expenceList = data.cast<ExpenceModel>().toList();
    }
  }

  //update the data
  Future<void> updateData() async {
    await _mybox.put("EXP_DATA", expenceList);
    print("data saved");
  }
}
