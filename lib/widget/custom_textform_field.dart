import 'package:flutter/material.dart';

class CustomTextFromFlied extends StatelessWidget {
  const CustomTextFromFlied(
      {super.key,
      required TextEditingController controller,
      required String txtLabel})
      : _controller = controller,
        _txtLabel = txtLabel;

  final TextEditingController _controller;

  final String _txtLabel;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        label: Text(_txtLabel),
      ),
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value == null || value.isNotEmpty) {
          return '$_txtLabel cannot be empty';
        }
        return null;
      },
    );
  }
}
