import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/cubit/sign_in/sign_in_cubit.dart';
import 'package:weather/cubit/sign_up/sign_up_cubit.dart';
import 'package:weather/cubit/user/user_cubit.dart';
import 'package:weather/presentation/login_page/components/email_form_field.dart';
import 'package:weather/presentation/login_page/components/login_button.dart';
import 'package:weather/presentation/login_page/components/password_form_field.dart';
import 'package:weather/presentation/login_page/components/register_button.dart';
import 'package:weather/utils/error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

import '../../const/hive_box_names.dart';

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
  final TextEditingController _email = TextEditingController();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'emptyPassword'.tr),
    MinLengthValidator(8, errorText: 'shortPassword'.tr),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'specialPassword'.tr)
  ]);

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    Widget firstChild = BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.signInStatus == SignInStatus.error) {
          errorDialog(context, state.error);
        } else if (state.signInStatus == SignInStatus.success) {
          Navigator.of(context).pop();
        }
      },
      child: LoginButton(
        pointToOnPress: () {
          if (formKey.currentState!.validate()) {
            context.read<SignInCubit>().state.signInStatus ==
                    SignInStatus.submitting
                ? null
                : context
                    .read<SignInCubit>()
                    .SignIn(email: _email.text, password: _pass.text)
                    .then((_) => context.read<UserCubit>().getProfile(
                        uid: fbAuth.FirebaseAuth.instance.currentUser?.uid));
            print('valid');
          }
        },
      ),
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

    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.signUpStatus == SignUpStatus.error) {
          errorDialog(context, state.error);
        } else if (state.signUpStatus == SignUpStatus.success) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blue),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Lottie.asset('lib/assets/lottie/32532-day-night.json',
                      width: 200),
                ),
                EmailFormField(
                  editingController: _email,
                ),
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
                  duration: const Duration(milliseconds: 300),
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
                        if (context.read<SignUpCubit>().state.signUpStatus ==
                            SignUpStatus.submitting) {
                          null;
                        } else {
                          context
                              .read<SignUpCubit>()
                              .SignUp(email: _email.text, password: _pass.text)
                              .then((_) => context.read<UserCubit>().getProfile(
                                  uid: fbAuth
                                      .FirebaseAuth.instance.currentUser?.uid));
                        }
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
                          child:
                              context.read<SignUpCubit>().state.signUpStatus ==
                                      SignUpStatus.submitting
                                  ? Container()
                                  : Center(
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
