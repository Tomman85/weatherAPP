import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/presentation/login_page/components/email_form_field.dart';
import 'package:weather/presentation/login_page/components/login_button.dart';
import 'package:weather/presentation/login_page/components/password_form_field.dart';
import 'package:weather/presentation/login_page/components/register_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isVisibility = false;
  bool wantRegister = false;
  Widget? child;
  String? password;

  final formKey = GlobalKey<FormState>();
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  @override
  Widget build(BuildContext context) {
    Widget firstChild = const LoginButton();
    Widget? secondChild = PasswordFormField(
      onChanged: (val) {
        password = val;
      },
      validator: (val) {
        if (password == null) {
          return;
        }
        MatchValidator(errorText: '').validateMatch(val, password!);
      },
      isVisibility: isVisibility,
      labelText: 'passwordRepeat'.tr,
      pointToOnPress: () {
        isVisibility = !isVisibility;
        setState(() {});
      },
    );

    if (!wantRegister) {
      child = firstChild;
    } else {
      child = secondChild;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: Lottie.asset('lib/assets/lottie/32532-day-night.json',
                    width: 200),
              ),
              EmailFormField(),
              PasswordFormField(
                validator: (val) {
                  if (password == null) {
                    return;
                  }
                  MatchValidator(errorText: '').validateMatch(val, password!);
                },
                isVisibility: isVisibility,
                labelText: 'password'.tr,
                pointToOnPress: () {
                  isVisibility = !isVisibility;
                  setState(() {});
                },
              ),
              AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: child,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TextButton(
                  onPressed: () {},
                  child: Text('forgotPassword'.tr),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Center(
                  child: Text(
                    'account'.tr,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              RegisterButton(
                onPressed: () {
                  if (wantRegister == true) {
                    if (formKey.currentState!.validate()) {
                      print('valid');
                    }
                  }
                  wantRegister = true;
                  setState(() {});
                },
              ),
              wantRegister
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: GestureDetector(
                        onTap: () {
                          wantRegister = false;
                          setState(() {});
                        },
                        child: Center(
                          child: Text(
                            'wannaLogin'.tr,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
