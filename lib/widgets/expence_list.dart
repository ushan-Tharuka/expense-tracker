import 'package:flutter/material.dart';
import 'package:flutter_advance/models/expence.dart';
import 'package:flutter_advance/widgets/expence_tile.dart';

class ExpenceList extends StatelessWidget {
  const ExpenceList({super.key, required this.expenceList});

  final List<ExpenceModel> expenceList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: expenceList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ExpenceTile(
                expence: expenceList[index],
              ),
            );
          }),
    );
  }
}
