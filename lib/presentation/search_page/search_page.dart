import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:weather/bloc/auth/auth_bloc.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/const/page_name_routes.dart';
import 'package:weather/presentation/search_page/components/autocomplete.dart';
import 'package:weather/presentation/search_page/components/favorites_cities.dart';
import 'package:weather/utils/custom_typography.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? elo;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Hive.box(favCity).clear();
              },
              icon: const Icon(Icons.delete))
        ],
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(loginPageRouteName);
          },
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.authStatus == AuthStatus.unauthenticated) {
                elo = 'ZALOGUJ SIE';
              } else if (state.authStatus == AuthStatus.authenticated) {
                elo = 'Witaj';
              }
            },
            builder: (context, state) {
              return Text(
                elo.toString(),
                style: CustomTypography.textStyleAutocompleteBasic,
              );
            },
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
