// ignore_for_file: prefer_const_constructors
import 'package:drift/drift.dart' as drift;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_tracker_local_store/data/local/db/app_db.dart';
import 'package:study_tracker_local_store/widget/custom_data_picker_formfield.dart';
import 'package:study_tracker_local_store/widget/custom_textform_field.dart';
// import 'package:intl/intl_browser.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  // final _formKey = GlobalKey<FormState>();
  late AppDb _db;
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
            title: const Text("Add Task"),
            actions: [
              IconButton(
                  onPressed: () {
                    addemployee();
                  },
                  icon: Icon(Icons.save_as))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                CustomTextFromFlied(
                  controller: _userNamecontroller,
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
                  // txtLabel: 'Date of Birth',
                  txtLabel: "Submission Date",
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
            primary: Color.fromARGB(255, 140, 224, 186),
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
      String dob = DateFormat('yyyy/MM/dd').format(newDate);
      _dobcontroller.text = dob;
    });
  }

  void addemployee() {
    final entity = EmployeeCompanion(
        userName: drift.Value(_userNamecontroller.text),
        firstName: drift.Value(_firstNamecontroller.text),
        lastName: drift.Value(_lastNamecontroller.text),
        dateOfBirth: drift.Value(_dateOfBirth!));

    _db.insertEmployee(entity).then(
          (value) => ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              backgroundColor: Color.fromARGB(255, 171, 240, 209),
              content: Text(
                // "New Employee inserted: $value",
                "New Task inserted: $value",
                style: TextStyle(
                  color: Color.fromARGB(255, 34, 0, 93),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => ScaffoldMessenger.of(context)
                        .hideCurrentMaterialBanner(),
                    child: Text(
                      "Close",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ))
              ],
            ),
          ),
        );
  }
}
