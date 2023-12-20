import 'package:flutter/material.dart';
import 'package:study_tracker_local_store/screen/add_employee_screen.dart';
import 'package:study_tracker_local_store/screen/edit_employee_screen.dart';
import 'package:study_tracker_local_store/screen/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/add_employee':
        return MaterialPageRoute(builder: (_) => AddEmployeeScreen());
      case '/edit_employee':
        if (args is int) {
          return MaterialPageRoute(builder: (_) => EditEmployeeScreen(id: args,));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text("Sorry NO route was found"),
        ),
      );
    });
  }
}
