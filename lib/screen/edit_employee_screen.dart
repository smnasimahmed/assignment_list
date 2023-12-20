// ignore_for_file: prefer_const_constructors
import 'package:drift/drift.dart' as drift;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_tracker_local_store/data/local/db/app_db.dart';
// import 'package:study_tracker_local_store/data/local/entity/employee_entity.dart';
import 'package:study_tracker_local_store/widget/custom_data_picker_formfield.dart';
import 'package:study_tracker_local_store/widget/custom_textform_field.dart';
// import 'package:intl/intl_browser.dart';

class EditEmployeeScreen extends StatefulWidget {
  final int id;
  const EditEmployeeScreen({required this.id, super.key});

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  late AppDb _db;
  late EmployeeData _employeeData;
  TextEditingController _firstNamecontroller = TextEditingController();
  TextEditingController _userNamecontroller = TextEditingController();
  TextEditingController _lastNamecontroller = TextEditingController();
  TextEditingController _dobcontroller = TextEditingController();
  DateTime? _dateOfBirth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _db = AppDb();
    getEmployee();
    // final employee = _db.getEmployee(widget.id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _db.close();
    _userNamecontroller.dispose();
    _firstNamecontroller.dispose();
    _lastNamecontroller.dispose();
    _dobcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Edit Task"),
            actions: [
              IconButton(
                  onPressed: () {
                    editemployee();
                  },
                  icon: Icon(Icons.save_as)),
              IconButton(
                  onPressed: () {
                    deleteEmployee();
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomTextFromFlied(
                  controller: _userNamecontroller,
                  // txtLabel: "User Name",
                  txtLabel: "Assignment Name",
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // CustomTextFromFlied(
                //   controller: _firstNamecontroller,
                //   txtLabel: "First Name",
                // ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFromFlied(
                  controller: _lastNamecontroller,
                  // txtLabel: "Last Name",
                  txtLabel: "Description",
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomDatePickerFormField(
                  controller: _dobcontroller,
                  txtLabel: 'Submission Date',
                  callback: () {
                    pickDateofBirth(context);
                  },
                ),
              ],
            ),
          )),
    );
  }

  Future<void> pickDateofBirth(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? initialDate,
      firstDate: DateTime(
        DateTime.now().year,
      ),
      lastDate: DateTime(
        DateTime.now().year + 1,
      ),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: ColorScheme.light(
            primary: Color.fromARGB(255, 171, 240, 209),
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child ?? Text('data'),
      ),
    );
    if (newDate == null) {
      return;
    }
    setState(() {
      _dateOfBirth = newDate;
      String dob = DateFormat('dd/MM/yyyy').format(newDate);
      _dobcontroller.text = dob;
    });
  }

  void editemployee() {
    final entity = EmployeeCompanion(
        id: drift.Value(widget.id),
        userName: drift.Value(_userNamecontroller.text),
        firstName: drift.Value(_firstNamecontroller.text),
        lastName: drift.Value(_lastNamecontroller.text),
        dateOfBirth: drift.Value(_dateOfBirth!));

    _db.updateEmployee(entity).then(
          (value) => ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              backgroundColor: const Color.fromARGB(255, 234, 221, 255),
              content: Text(
                "Existing Employee Updated: $value",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                    onPressed: () => ScaffoldMessenger.of(context)
                        .hideCurrentMaterialBanner(),
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        );
  }

  void deleteEmployee() {
    _db.deleteEmployee(widget.id).then(
          (value) => ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              backgroundColor: const Color.fromARGB(255, 171, 240, 209),
              content: Text(
                "Employee deleted: $value",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                    onPressed: () => ScaffoldMessenger.of(context)
                        .hideCurrentMaterialBanner(),
                    child: Text(
                      "Close",
                      style: TextStyle(color: Color.fromARGB(255, 34, 0, 93)),
                    ))
              ],
            ),
          ),
        );
  }

  Future<void> getEmployee() async {
    _employeeData = await _db.getEmployee(widget.id);
    _userNamecontroller.text = _employeeData.userName;
    _firstNamecontroller.text = _employeeData.firstName;
    _lastNamecontroller.text = _employeeData.lastName;
    _dobcontroller.text = _employeeData.dateOfBirth.toIso8601String();
  }
}
