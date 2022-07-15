import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/const/api_data.dart';
import 'package:weather/presentation/autocomplete/components/prediction_dto.dart';
import 'package:weather/presentation/autocomplete/services/autocomplete_services.dart';
import 'package:weather/presentation/autocomplete/services/data_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> cities = [];

  Future getHttp(TextEditingValue name) async {
    try {
      var response = await Dio().get(
          'https://api.geoapify.com/v1/geocode/autocomplete?text=${name}&format=json&apiKey=09dbac0c276948199f26e5ce40662f1a');
      // print(response.data['results'][0]['formatted']);

      cities.add(response.data['results'][0]['city'] );
      
      return (response.data);
    } catch (e) {
      print(e);
    }
  }
  late TextEditingValue _textEditingValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getHttp(_textEditingValue),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
               List<String> _kOptions =cities;
              print(_kOptions);
              return Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '' || textEditingValue.text.length <3) {
                    return const Iterable<String>.empty();
                  }
                  return _kOptions.where((String option) {
                    return option.contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  debugPrint('You just selected $selection');
                }

              );
            }
            return Center();
          },
        ),
      ),
    );
  }
}
//snapshot.data['results'][2]['formatted']
