import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:timenest/presentation/screens/home/home.dart';
import '../../model/task_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime(2025, 1, 1);
  int _selectedIndex = 0;
  String _selectedOption = 'Option 1';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void saveTask(Task task) {
    // Access the already opened box
    final box = Hive.box<Task>('tasks');
    box.add(task); // Save the task
  }

  void viewTask() {
    final taskBox = Hive.box<Task>('tasks');

    final tasks = taskBox.values.toList();
    for (int index = 0; index < tasks.length; index++) {
      final task = tasks[index];
      print('Index: $index');
      print('Task Name: ${task.name}');
      print('Description: ${task.description}');
      print('Date: ${task.date}');
      print('Option: ${task.option}');
      print('-------------------------');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFBB8E6A), // Brown/copper accent color
              onPrimary: Colors.white,
              surface: Color(0xFFF5F1E3), // Beige/cream background
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define the custom colors
    // Beige/cream background
    const backgroundColor = Color.fromARGB(255, 237, 232, 220);
    // Brown/copper accent color
    const accentColor = Color.fromARGB(255, 177, 127, 89);
    const cardColor = Color.fromARGB(
      255,
      193,
      207,
      161,
    ); // Light green card color
    const textColor = Color.fromARGB(255, 67, 74, 67); // Dark text color
    const inputBgColor = Color(0xFFF5F1E3); // Input background color

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('', style: TextStyle(color: textColor, fontSize: 16)),
        actions: [
          IconButton(
            icon: const Icon(Icons.wb_sunny_outlined, color: accentColor),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: accentColor),
            onPressed: () {
              viewTask();
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu, color: accentColor),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Task Card
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  const BoxShadow(color: Colors.black),
                  const BoxShadow(
                    color: Colors.black,
                    spreadRadius: -1.0,
                    blurRadius: 1.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card Title
                    const Text(
                      'Enter Your Task',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Task Name Input
                    Container(
                      decoration: BoxDecoration(
                        color: inputBgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _taskNameController,
                        decoration: const InputDecoration(
                          hintText: 'Task Name',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Description Input
                    Container(
                      decoration: BoxDecoration(
                        color: inputBgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'Description',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Date Picker and Toggle
                    // Date Picker and Dropdown
                    Row(
                      children: [
                        // Date Picker
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: inputBgColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    DateFormat(
                                      'dd-MM-yyyy',
                                    ).format(_selectedDate),
                                    style: const TextStyle(
                                      color: textColor,
                                      fontSize: 16,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: textColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Dropdown List
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3A3A3A),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedOption,
                              dropdownColor: const Color(0xFF3A3A3A),
                              style: const TextStyle(color: Colors.white),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedOption = newValue!;
                                });
                              },
                              items:
                                  <String>[
                                    'Option 1',
                                    'Option 2',
                                    'Option 3',
                                    'Option 4',
                                  ].map<DropdownMenuItem<String>>((
                                    String value,
                                  ) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Cancel Button
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3A3A3A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),

                        // Confirm Button
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3A3A3A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.check, color: Colors.white),
                            onPressed: () async {
                              // Save task logic here
                              saveTask(
                                Task(
                                  name: _taskNameController.text,
                                  description: _descriptionController.text,
                                  date: _selectedDate,
                                  option: _selectedOption.toString(),
                                ),
                              );

                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Spacer to push bottom nav to bottom
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: accentColor,
          shape: BoxShape.circle,
          border: Border.all(color: backgroundColor, width: 4),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: accentColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Home icon
              IconButton(
                icon: Icon(
                  Icons.home_outlined,
                  color: _selectedIndex == 0 ? Colors.white : Colors.white70,
                  size: 32,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
              ),
              // Grid/Dashboard icon
              IconButton(
                icon: Icon(
                  Icons.grid_view,
                  color: _selectedIndex == 1 ? Colors.white : Colors.white70,
                  size: 28,
                ),
                onPressed: () => _onItemTapped(1),
              ),
              const SizedBox(width: 40), // Space for FAB
              // Calendar icon
              IconButton(
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: _selectedIndex == 2 ? Colors.white : Colors.white70,
                  size: 28,
                ),
                onPressed: () => _onItemTapped(2),
              ),
              // Settings icon
              IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  color: _selectedIndex == 3 ? Colors.white : Colors.white70,
                  size: 28,
                ),
                onPressed: () => _onItemTapped(3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
