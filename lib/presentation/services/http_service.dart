import 'package:dio/dio.dart';

class HttpService {
  Dio? _dio;

  final baseUrl = 'https://api.geoapify.com/v1/geocode/autocomplete';

  HttpService() {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
    initializeInterceptors();
  }

  Future<Response?> getRequest(String endPoint) async {
    Response? response;
    try {
      response = await _dio?.get(endPoint);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  initializeInterceptors() {
    _dio?.interceptors.add(InterceptorsWrapper(
      onError: (error, errorInterceptorHandler) {
        print(error.message);
      }, onRequest: (request, requestInterceptorHandler) {
      print(request.method);
    }, onResponse: (response, responseInterceptorHandler) {
      print(response.data);
    },);
    }

}