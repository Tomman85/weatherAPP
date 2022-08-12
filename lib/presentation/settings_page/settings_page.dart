import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:weather/bloc/auth/auth_bloc.dart';
import 'package:weather/cubit/user/user_cubit.dart';
import 'package:weather/presentation/settings_page/components/build_settings_page_row.dart';
import 'package:weather/services/repository_services/firebase_repository/profile_repository.dart';
import 'package:weather/utils/change_language.dart';
import 'package:weather/utils/custom_typography.dart';
import 'package:weather/utils/data_custom_format.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final languageItems = ['PL', 'EN'];

  String? selectedItem = 'language'.tr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              'settings'.tr,
              style: CustomTypography.textStyleSettingsTitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'changeLanguage'.tr,
              style: CustomTypography.textStyleSettingsSubtitle,
            ),
          ),
          BuildSettingsPageRow(
            firstStyle: CustomTypography.textStyleAutocompleteBasic,
            secondStyle: CustomTypography.textStyleSettingsSubtitle,
            firstColumnData: 'chooseLanguage'.tr,
            secondColumnData: DropdownButton<String>(
              icon: Icon(Icons.unfold_more),
              dropdownColor: Colors.grey.shade300,
              style: CustomTypography.textStyleSettingsSubtitle,
              value: selectedItem,
              elevation: 0,
              borderRadius: BorderRadius.circular(20),
              underline: const SizedBox(),
              items: languageItems.map(buildLanguageItem).toList(),
              onChanged: (item) {
                selectedItem = item;
                LanguageFormat.changeLanguage();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'accountDelete'.tr,
              style: CustomTypography.textStyleSettingsSubtitle,
            ),
          ),
          context.read<AuthBloc>().state.authStatus == AuthStatus.authenticated
              ? BuildSettingsPageRow(
                  firstStyle: CustomTypography.textStyleAutocompleteBasic,
                  secondStyle: CustomTypography.textStyleSettingsSubtitle,
                  firstColumnData: 'deleteAccount'.tr,
                  secondColumnData: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _showDialog();
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildLanguageItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );

  _showDialog() {
    return showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: Text('deleteAccount'.tr),
            content: Text('wantDelete'.tr),
            actions: [
              TextButton(
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.pop(context);

                  context.read<ProfileRepository>().deleteCurrentUserDatabase();
                  context.read<AuthBloc>().add(DeletionRequestedEvent());
                  context.read<UserCubit>().initialUser();

                },
              ),
              TextButton(
                child: Text('cancel'.tr),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )),
    );
  }
}
