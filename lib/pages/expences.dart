import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_advance/models/expence.dart';
import 'package:flutter_advance/server/database.dart';
import 'package:flutter_advance/widgets/add_new_expence.dart';
import 'package:flutter_advance/widgets/expence_list.dart';
import 'package:hive/hive.dart';
import 'package:pie_chart/pie_chart.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  final _myBox = Hive.box("expenceDatabase");
  Database db = Database();

  //expenceList
  // final List<ExpenceModel> _expenceList = [
  //   ExpenceModel(
  //       amount: 10.5,
  //       date: DateTime.now(),
  //       title: "Cricket",
  //       category: Category.leasure),
  //   ExpenceModel(
  //       amount: 10.9,
  //       date: DateTime.now(),
  //       title: "Rice",
  //       category: Category.food),
  //   ExpenceModel(
  //       amount: 20,
  //       date: DateTime.now(),
  //       title: "Bag",
  //       category: Category.travel),
  // ];

  //pie chart
  Map<String, double> dataMap = {
    "Food": 0,
    "Travel": 0,
    "Leasure": 0,
    "Work": 0,
  };
  //add new expence
  void onAddNewExpence(ExpenceModel expence) {
    setState(() {
      db.expenceList.add(expence);
      calCategoryValues();
    });
    db.updateData();
  }

  //funtion to open a modal overly
  void _openAddExpencesOverlay() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AddNewExpence(
            onAddExpence: onAddNewExpence,
          );
        });
  }

  //remove a expence
  void onDeleteExpence(ExpenceModel expence) {
    ExpenceModel deletingExpence = expence;
    //get the index of removing expemce
    final int removingIndex = db.expenceList.indexOf(expence);
    setState(() {
      db.expenceList.remove(expence);
      db.updateData();
      calCategoryValues();
    });
    //show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: const Text("Item Deleted!"),
          action: SnackBarAction(
              label: "Undo",
              onPressed: () {
                setState(() {
                  db.expenceList.insert(removingIndex, deletingExpence);
                  db.updateData();
                  calCategoryValues();
                });
              })),
    );
  }

//Pie chart date
  double foodVal = 0;
  double travelVal = 0;
  double leasureVal = 0;
  double workVal = 0;

  void calCategoryValues() {
    double foodValTotal = 0;
    double travelValTotal = 0;
    double leasureValTotal = 0;
    double workValTotal = 0;

    for (final expence in db.expenceList) {
      if (expence.category == Category.food) {
        foodValTotal += expence.amount;
      }
      if (expence.category == Category.travel) {
        travelValTotal += expence.amount;
      }
      if (expence.category == Category.leasure) {
        leasureValTotal += expence.amount;
      }
      if (expence.category == Category.work) {
        workValTotal += expence.amount;
      }
    }

    setState(() {
      foodVal = foodValTotal;
      travelVal = travelValTotal;
      leasureVal = leasureValTotal;
      workVal = workValTotal;
    });

    //update the detaMap
    dataMap = {
      "Food": foodVal,
      "Travel": travelVal,
      "Leasure": leasureVal,
      "Work": workVal,
    };
  }

  @override
  void initState() {
    super.initState();
    //if this is the first time create the inial date
    if (_myBox.get("EXP_DATA") == null) {
      db.createInitialDatabase();
      calCategoryValues();
    } else {
      db.loadData();
      calCategoryValues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expences',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 0, 159, 95),
        elevation: 0,
        actions: [
          Container(
            color: const Color.fromARGB(255, 0, 123, 60),
            child: IconButton(
                onPressed: _openAddExpencesOverlay,
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 800),
              // chartLegendSpacing: 20,
              chartRadius: MediaQuery.of(context).size.width / 2.2,
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 25,
              centerText: "Expences",
            ),
          ),
          ExpenceList(
            expenceList: db.expenceList,
            onDeleteExpence: onDeleteExpence,
          ),
        ],
      ),
    );
  }
}
