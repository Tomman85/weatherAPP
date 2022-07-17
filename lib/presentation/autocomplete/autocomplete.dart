import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather/presentation/models/single_test_response.dart';
import 'package:weather/presentation/models/test_model.dart';
import 'package:weather/presentation/services/http_service.dart';

class SingleUserScreen extends StatefulWidget {
  const SingleUserScreen({Key? key}) : super(key: key);

  @override
  State<SingleUserScreen> createState() => _SingleUserScreenState();
}

class _SingleUserScreenState extends State<SingleUserScreen> {
  HttpService? http;
  SingleTestResponse? singleTestResponse;
  TestModel? testModel;
  bool isLoading = false;

  Future getUser() async {
    Response? response;
    try {
      print('ses');
      isLoading = true;
      response = await http?.getRequest(
          "?text=ber&format=json&apiKey=09dbac0c276948199f26e5ce40662f1a");
      print(response?.statusCode);

      isLoading = false;

      if (response?.statusCode == 200) {
        setState(() {
          singleTestResponse = SingleTestResponse.fromJson(response?.data);
          testModel = singleTestResponse?.testModel;
        });

      } else {
        print('not good');
      }
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }
@override
  void initState() {
    http =HttpService();
    getUser();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('elo'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(width: double.infinity,
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("${testModel?.formatted}")],
              ),
            ),
    );
  }
}
