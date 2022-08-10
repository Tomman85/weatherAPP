import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/cubit/sign_in/sign_in_cubit.dart';
import 'package:weather/cubit/sign_up/sign_up_cubit.dart';
import 'package:weather/cubit/user/user_cubit.dart';
import 'package:weather/presentation/login_page/components/email_form_field.dart';
import 'package:weather/presentation/login_page/components/login_button.dart';
import 'package:weather/presentation/login_page/components/password_form_field.dart';
import 'package:weather/presentation/login_page/components/register_button.dart';
import 'package:weather/utils/authentications.dart';
import 'package:weather/utils/autocomplete_show_dialog.dart';
import 'package:weather/utils/error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

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

  @override
  Widget build(BuildContext context) {
    Widget firstChild = BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.signInStatus == SignInStatus.error) {
          errorDialog(context, state.error);
        } else if (state.signInStatus == SignInStatus.success) {
          AutocompleteShowDialog.loginShowDialog(
            context: context,
            contentText: 'Czy chcesz schynchronizować bieżące miasta?',
            child: TextButton(
              child: Text('Tak'),
              onPressed: () {
                Authentication.updateDataWhenRegisterAndLogin()
                    .then((_) => Authentication.clearAndUpdate());
                //This could be strange that u see 2x pop, but it helps me with the bug
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            secondChild: TextButton(
              child: Text('Nie'),
              onPressed: () {
                Authentication.clearAndUpdate();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          );
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
                    .then(
                      (_) => context.read<UserCubit>().getProfile(
                          uid: fb_auth.FirebaseAuth.instance.currentUser?.uid),
                    );
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
          AutocompleteShowDialog.loginShowDialog(
            context: context,
            contentText: 'accountRegistered'.tr,
            child: TextButton(
              child: Text('ok'.tr),
              onPressed: () {
                Authentication.updateDataWhenRegisterAndLogin();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            secondChild: Container(),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.blue),
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
                  validator: Authentication.passwordValidator,
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
                        if (context.read<SignUpCubit>().state.signUpStatus ==
                            SignUpStatus.submitting) {
                          null;
                        } else {
                          context
                              .read<SignUpCubit>()
                              .SignUp(
                                email: _email.text,
                                password: _pass.text,
                                cities: [],
                              )
                              .then((_) => context.read<UserCubit>().getProfile(
                                  uid: fb_auth
                                      .FirebaseAuth.instance.currentUser?.uid))
                              .then((_) => Authentication
                                  .updateDataWhenRegisterAndLogin());
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
