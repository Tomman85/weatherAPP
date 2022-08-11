import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/const/page_name_routes.dart';
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
    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.signUpStatus == SignUpStatus.error) {
              errorDialog(context, state.error);
            } else if (state.signUpStatus == SignUpStatus.success) {
              _buildSignUpDialog();
            }
          },
        ),
        BlocListener<SignInCubit, SignInState>(
          listener: (context, state) {
            if (state.signInStatus == SignInStatus.error) {
              errorDialog(context, state.error);
            } else if (state.signInStatus == SignInStatus.success) {
              _buildSignInDialog();
            }
          },
        ),
      ],
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
                  child:
                      !wantRegister ? _buildFirstChild() : _buildSecondChild(),
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
                    _signUpUser();
                    wantRegister = true;
                    setState(() {});
                  },
                ),
                wantRegister ? _changeLoginToRegister() : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildFirstChild() {
    return LoginButton(
      pointToOnPress: () {
        _signInUser();
      },
    );
  }

  _buildSecondChild() {
    return PasswordFormField(
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
  }

  _buildSignUpDialog() {
    return AutocompleteShowDialog.loginShowDialog(
      context: context,
      contentText: 'accountRegistered'.tr,
      child: TextButton(
        child: Text('ok'.tr),
        onPressed: () {
          Authentication.updateDataWhenRegisterAndLogin();
          Navigator.of(context).popUntil(
            ModalRoute.withName(searchPageRouteName),
          );
        },
      ),
      secondChild: Container(),
    );
  }

  _signInUser() {
    if (formKey.currentState!.validate()) {
      context.read<SignInCubit>().state.signInStatus == SignInStatus.submitting
          ? null
          : context
              .read<SignInCubit>()
              .SignIn(email: _email.text, password: _pass.text)
              .then(
                (_) => context.read<UserCubit>().getProfile(
                    uid: fb_auth.FirebaseAuth.instance.currentUser?.uid),
              );
    }
  }

  _signUpUser() {
    if (wantRegister == true) {
      if (formKey.currentState!.validate()) {
        if (context.read<SignUpCubit>().state.signUpStatus ==
            SignUpStatus.submitting) {
          null;
        } else {
          context
              .read<SignUpCubit>()
              .signUp(
                email: _email.text,
                password: _pass.text,
                cities: [],
              )
              .then((_) => context.read<UserCubit>().getProfile(
                  uid: fb_auth.FirebaseAuth.instance.currentUser?.uid))
              .then((_) => Authentication.updateDataWhenRegisterAndLogin());
        }
      }
    }
  }

  _buildSignInDialog() {
    return AutocompleteShowDialog.loginShowDialog(
      context: context,
      contentText: 'Czy chcesz schynchronizować bieżące miasta?',
      child: TextButton(
        child: Text('Tak'),
        onPressed: () async {
          Hive.box(favCity).isEmpty
              ? Authentication.clearAndUpdate()
              : await Authentication.updateDataWhenRegisterAndLogin().then((_) {
                  Authentication.clearAndUpdate();
                });
          Navigator.of(context).popUntil(
            ModalRoute.withName(searchPageRouteName),
          );
        },
      ),
      secondChild: TextButton(
        child: Text('Nie'),
        onPressed: () {
          Authentication.clearAndUpdate();
          Navigator.of(context).popUntil(
            ModalRoute.withName(searchPageRouteName),
          );
        },
      ),
    );
  }

  _changeLoginToRegister() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: () {
          wantRegister = false;
          setState(() {});
        },
        child: context.read<SignUpCubit>().state.signUpStatus ==
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
    );
  }
}
