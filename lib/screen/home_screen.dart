// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:study_tracker_local_store/data/local/db/app_db.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  // ignore: override_on_non_overriding_member
  late AppDb _db;
  void initState() {
    // TODO: implement initState
    super.initState();
    _db = AppDb();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _db.close();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Assignment List",
            style: TextStyle(),
          ),
        ),
        body: FutureBuilder<List<EmployeeData>>(
            future: _db.getEmployees(),
            builder: (context, snapshot) {
              final List<EmployeeData>? employees = snapshot.data;

              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (employees != null) {
                return ListView.builder(
                    itemCount: employees.length,
                    itemBuilder: (context, index) {
                      final employee = employees[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/edit_employee',
                              arguments: employee.id);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          color: Color.fromARGB(255, 230, 253, 243),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(23.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //   employee.id.toString(),
                                      //   style: TextStyle(
                                      //     color: Color.fromARGB(255, 34, 0, 93),
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      //   textScaleFactor: 1.2,
                                      // ),

                                      Text(
                                        employee.userName.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        employee.firstName.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      Text(
                                        employee.lastName.toString(),
                                        style: TextStyle(),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Submission Date",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        employee.dateOfBirth.toString(),
                                        textAlign: TextAlign.end,
                                        style: TextStyle(),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
              return const Text("No Data Found");
            }),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Color.fromARGB(255, 171, 240, 209),
            onPressed: () {
              Navigator.pushNamed(context, '/add_employee');
            },
            icon: Icon(
              Icons.add,
              color: Color.fromARGB(255, 59, 59, 59),
            ),
            label: Text(
              "Add Task",
              style: TextStyle(color: Color.fromARGB(255, 59, 59, 59)),
            )),
      ),
    );
  }
}
