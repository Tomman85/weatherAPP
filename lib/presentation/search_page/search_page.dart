import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:weather/bloc/auth/auth_bloc.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/const/page_name_routes.dart';
import 'package:weather/cubit/user/user_cubit.dart';
import 'package:weather/presentation/search_page/components/autocomplete.dart';
import 'package:weather/presentation/search_page/components/favorites_cities.dart';
import 'package:weather/utils/authentications.dart';
import 'package:weather/utils/autocomplete_show_dialog.dart';
import 'package:weather/utils/custom_typography.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          context.watch<AuthBloc>().state.authStatus != AuthStatus.authenticated
              ? Container()
              : IconButton(
                  onPressed: () {
                    AutocompleteShowDialog.loginShowDialog(
                      context: context,
                      contentText: 'logout'.tr,
                      child: TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(SignOutRequestEvent());
                          Navigator.of(context).pop();
                        },
                        child: Text('yes'.tr),
                      ),
                      secondChild: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('cancelDelete'.tr),
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout),
                ),
          IconButton(
              onPressed: () {
                AutocompleteShowDialog.loginShowDialog(
                  context: context,
                  contentText: 'deleteData'.tr,
                  child: TextButton(
                    onPressed: () {
                      Hive.box(favCity).clear();
                      Authentication.clearAllData();
                      Navigator.of(context).pop();
                    },
                    child: Text('deleteCity'.tr),
                  ),
                  secondChild: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('cancelDelete'.tr),
                  ),
                );
              },
              icon: const Icon(Icons.delete)),
        ],
        title: context.watch<AuthBloc>().state.authStatus ==
                AuthStatus.authenticated
            ? Text(
                'Witaj ${context.watch<UserCubit>().state.user.name}',
                style: CustomTypography.textStyleAutocompleteBasic,
              )
            : GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, loginPageRouteName);
                },
                child: Text(
                  'login'.tr,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'cityManagement'.tr,
                    textAlign: TextAlign.end,
                    style: CustomTypography.textStyleSettingsTitle,
                  ),
                ),
                const Spacer(),
                const AutocompletePredictions(),
                const FavoritesCities(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
