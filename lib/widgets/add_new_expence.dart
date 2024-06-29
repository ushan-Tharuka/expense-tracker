import 'package:flutter/material.dart';
import 'package:flutter_advance/models/expence.dart';

class AddNewExpence extends StatefulWidget {
  const AddNewExpence({super.key});

  @override
  State<AddNewExpence> createState() => _AddNewExpenceState();
}

class _AddNewExpenceState extends State<AddNewExpence> {
  //controller
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  Category _selectedCategory = Category.leasure;

  //remove unwant for clean memmory space
  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: "Add new expence title",
              label: Text("Title"),
            ),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    helperText: "Enter the amount",
                    label: Text("Amount"),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              //add date picker
              Expanded(
                child: Row(
                  children: [
                    Text("2023/2/2"),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.date_range_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //close the model button
                  ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
                    ),
                    child: const Text("Close"),
                  ),
                  SizedBox(width: 8,),
                  ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 0, 159, 95)),
                    ),
                    child: const Text("Save"),
                  ),
      
                  //save data and close model button
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
