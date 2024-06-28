import 'package:flutter/material.dart';
import 'package:flutter_advance/models/expence.dart';

class ExpenceList extends StatelessWidget {
  const ExpenceList({super.key, required this.expenceList});

  final List<ExpenceModel> expenceList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: expenceList.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expenceList[index].title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          expenceList[index].amount.toStringAsFixed(2),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(Icons.trending_down),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(expenceList[index].date.toString()),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
