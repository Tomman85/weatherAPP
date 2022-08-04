import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:weather/bloc/auth/auth_bloc.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/const/page_name_routes.dart';
import 'package:weather/cubit/sign_in/sign_in_cubit.dart';
import 'package:weather/cubit/user/user_cubit.dart';
import 'package:weather/presentation/search_page/components/autocomplete.dart';
import 'package:weather/presentation/search_page/components/favorites_cities.dart';
import 'package:weather/services/repository_services/firebase_repository/profile_repository.dart';
import 'package:weather/utils/custom_typography.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                if(context.read<AuthBloc>().state.authStatus ==
                    AuthStatus.authenticated){ProfileRepository.updateData('mojeid');}
              },
              icon: Icon(Icons.ac_unit_outlined)),
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequestEvent());
              context.read<UserCubit>().initialUser();
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
              onPressed: () {
                Hive.box(favCity).clear();
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
                  'Zaloguj sie',
                  style: TextStyle(color: Colors.red),
                ),
              ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'cityManagement'.tr,
              textAlign: TextAlign.end,
              style: CustomTypography.textStyleSettingsTitle,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const AutocompletePredictions(),
          const FavoritesCities(),
        ],
      ),
    );
  }
}
