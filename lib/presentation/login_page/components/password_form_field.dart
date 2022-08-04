import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart' as valid;

import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class PasswordFormField extends StatelessWidget {
  final bool isVisibility;
  final String? labelText;
  final VoidCallback pointToOnPress;
  final FormFieldValidator validator;

  final TextEditingController textEditingController;

  const PasswordFormField({
    Key? key,
    required this.isVisibility,
    this.labelText,
    required this.pointToOnPress,
    required this.validator,

    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: TextFormField(
        controller: textEditingController,
        validator: validator,
        obscureText: isVisibility,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          labelText: labelText,
          suffixIcon: IconButton(
            icon: isVisibility
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility),
            onPressed: pointToOnPress,
          ),
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.lightBlue,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}