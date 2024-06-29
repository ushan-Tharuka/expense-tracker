import 'package:flutter/material.dart';
import 'package:flutter_advance/models/expence.dart';
import 'package:flutter_advance/widgets/add_new_expence.dart';
import 'package:flutter_advance/widgets/expence_list.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  //expenceList
  final List<ExpenceModel> _expenceList = [
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

  //funtion to open a modal overly
  void _openAddExpencesOverlay() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AddNewExpence();
        });
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
            color: Color.fromARGB(255, 0, 123, 60),
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
          ExpenceList(expenceList: _expenceList),
        ],
      ),
    );
  }
}
