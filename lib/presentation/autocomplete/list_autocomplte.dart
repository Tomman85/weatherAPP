import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather/presentation/models/list_response.dart';
import 'package:weather/presentation/models/test_model.dart';
import 'package:weather/presentation/services/http_service.dart';

import '../models/single_test_response.dart';

class ListUSerScrren extends StatefulWidget {
  const ListUSerScrren({Key? key}) : super(key: key);

  @override
  State<ListUSerScrren> createState() => _ListUSerScrrenState();
}

class _ListUSerScrrenState extends State<ListUSerScrren> {
  HttpService? httpService;

  ListDataResponse? listDataResponse;
  List<TestModel>? testModels;
  bool isLoading = false;

  Future getListUser() async {
    Response? response;
    try {
      isLoading = true;
      response = await httpService?.getRequest(
          "?text=tyc&format=json&apiKey=09dbac0c276948199f26e5ce40662f1a");
      print(response?.statusCode);


      isLoading = false;

      if (response?.statusCode == 200) {
        listDataResponse = ListDataResponse.fromJson(response?.data);
        testModels = listDataResponse?.testModel;
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
    httpService = HttpService();
    getListUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('elki'),),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final user = testModels?[index];

          return user?.formatted !=null?ListTile(
            title: Text("${user?.formatted}"),
          ):Container();
        },
        itemCount:5
      ),
    );
  }
}
