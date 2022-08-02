import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const ValueKey(0),
      padding: const EdgeInsets.only(
        top: 30,
      ),
      child: ElevatedButton(
        onPressed: () {},
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
