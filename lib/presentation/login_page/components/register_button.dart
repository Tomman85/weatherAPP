import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: Colors.blue,
          fixedSize: Size(
            MediaQuery.of(context).size.width,
            60,
          ),
          primary: Colors.blue,
        ),
        child: Text(
          'register'.tr,
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
