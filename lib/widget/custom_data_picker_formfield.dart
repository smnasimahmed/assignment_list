import 'package:flutter/material.dart';

class CustomDatePickerFormField extends StatelessWidget {
  final TextEditingController _controller;
  final String _txtLabel;
  final VoidCallback _callback;

  const CustomDatePickerFormField(
      {super.key,
      required TextEditingController controller,
      required String txtLabel,
      required VoidCallback callback})
      : _callback = callback,
        _controller = controller,
        _txtLabel = txtLabel;

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
      onTap: _callback,
    );
  }
}
