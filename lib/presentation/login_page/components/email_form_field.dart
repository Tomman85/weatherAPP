import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class EmailFormField extends StatelessWidget {
  final TextEditingController editingController;
  const EmailFormField({
    Key? key, required this.editingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(controller: editingController,
        validator: (val) {
          if (val!.isEmpty) {
            return 'emptyEmail'.tr;
          }
          if (EmailValidator(errorText: 'validEmail'.tr).isValid(val)) {
            return null;
          }
          return EmailValidator(errorText: 'validEmail'.tr).errorText;
        },
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