import 'package:flutter/material.dart';
import 'input_type.dart';

class InputBox extends StatelessWidget {
  String hint, label;
  bool enabled;
  InputType type;

  InputBox(
      {this.hint = "",
      this.label = "",
      this.enabled = true,
      this.type = InputType.text});

  Widget build(BuildContext context) {
    return TextFormField(
        enabled: enabled,
        keyboardType: parseKeyboardType(type),
        decoration:
            InputDecoration(hintText: this.hint, labelText: this.label));
  }

  TextInputType parseKeyboardType(InputType type) {
    switch (type) {
      case InputType.text:
        return TextInputType.text;
      case InputType.date:
        return TextInputType.datetime;
      case InputType.numeric:
        return TextInputType.number;
    }
    return TextInputType.text;
  }
}
