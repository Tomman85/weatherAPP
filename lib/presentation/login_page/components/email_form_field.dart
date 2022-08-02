import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class EmailFormField extends StatelessWidget {
  const EmailFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        validator:
           EmailValidator(errorText: 'Enter valid pass'),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          labelText: 'email'.tr,
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
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
