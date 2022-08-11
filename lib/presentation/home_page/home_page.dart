import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/const/page_name_routes.dart';
import 'package:weather/cubit/user/user_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:weather/reusable_widgets/border_text_style.dart';
import 'components/main_page_weather_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

String splitBox(Box box) {
  String boxToString =
      box.isEmpty ? '' : box.getAt(box.length - 1).cityName.toString();
  return boxToString.split(',')[0];
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context
        .read<UserCubit>()
        .getProfile(uid: fbAuth.FirebaseAuth.instance.currentUser?.uid);
    super.initState();
  }

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      body:  const MainPageWeatherContent(),
    );
  }
}
