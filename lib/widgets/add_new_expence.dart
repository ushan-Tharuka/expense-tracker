import 'package:flutter/material.dart';
import 'package:flutter_advance/models/expence.dart';

class AddNewExpence extends StatefulWidget {
  final void Function(ExpenceModel expence) onAddExpence;
  const AddNewExpence({super.key, required this.onAddExpence});

  @override
  State<AddNewExpence> createState() => _AddNewExpenceState();
}

class _AddNewExpenceState extends State<AddNewExpence> {
  //controller
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  Category _selectedCategory = Category.leasure;

  //datepicker variables
  final DateTime initialDate = DateTime.now();
  final DateTime firstDate = DateTime(
      DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);
  final DateTime lastDate = DateTime(
      DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);
  //final date
  DateTime _selectedDate = DateTime.now();

  //date picker
  Future<void> _openDataModel() async {
    try {
      //show the data model to store user selected
      final pickedDate = await showDatePicker(
          context: context, firstDate: firstDate, lastDate: lastDate);
      setState(() {
        _selectedDate = pickedDate!;
      });
    } catch (err) {
      print(err.toString());
    }
  }

  //Handle form submit
  void _handleFormSubmit() {
    //form validation
    //convert amount to double
    final userAmount = double.parse(_amountController.text.trim());
    if (_titleController.text.trim().isEmpty || userAmount <= 0) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Enter Valid Data"),
              content: const Text("Please enter valid Title and Amount"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Close"),
                )
              ],
            );
          });
    } else {
      //create new expence
      ExpenceModel newExpence = ExpenceModel(
          amount: userAmount,
          date: _selectedDate,
          title: _titleController.text.trim(),
          category: _selectedCategory);
      //Save the date
      widget.onAddExpence(newExpence);
      Navigator.pop(context);
    }
  }

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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(formattedDate.format(_selectedDate)),
                    IconButton(
                      onPressed: _openDataModel,
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.redAccent),
                    ),
                    child: const Text("Close"),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: _handleFormSubmit,
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 0, 159, 95)),
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
