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
  bool isVisibility = true;
  bool wantRegister = false;
  Widget? child;
  String? password;

  final formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'emptyPassword'.tr),
    MinLengthValidator(8, errorText: 'shortPassword'.tr),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'specialPassword'.tr)
  ]);

  @override
  Widget build(BuildContext context) {
    Widget firstChild = LoginButton(
      pointToOnPress: () {
        if (formKey.currentState!.validate()) {
        }
      },
    );
    Widget? secondChild = PasswordFormField(
      validator: (val) => MatchValidator(errorText: 'matchPassword'.tr)
          .validateMatch(val, _pass.text),
      isVisibility: isVisibility,
      labelText: 'passwordRepeat'.tr,
      pointToOnPress: () {
        isVisibility = !isVisibility;
        setState(() {});
      },
      textEditingController: _confirmPass,
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
      body: SingleChildScrollView(
        child: Padding(
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
                const EmailFormField(),
                PasswordFormField(
                  validator: passwordValidator,
                  isVisibility: isVisibility,
                  labelText: 'password'.tr,
                  pointToOnPress: () {
                    isVisibility = !isVisibility;
                    setState(() {});
                  },
                  textEditingController: _pass,
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
                      }
                    }
                    wantRegister = true;
                    setState(() {});
                  },
                ),
                wantRegister
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20,bottom: 50),
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
      ),
    );
  }
}
