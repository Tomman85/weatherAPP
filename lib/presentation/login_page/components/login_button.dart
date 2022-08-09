import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback pointToOnPress;

  const LoginButton({
    Key? key,
    required this.pointToOnPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const ValueKey(0),
      padding: const EdgeInsets.only(
        top: 30,
      ),
      child: ElevatedButton(
        onPressed: pointToOnPress,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: Colors.black,
          fixedSize: Size(
            MediaQuery.of(context).size.width * 08,
            60,
          ),
        ),
        child: Text('login'.tr),
      ),
    );
  }
}
