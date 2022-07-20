import 'package:dio/dio.dart';

class HttpWeatherService {
  Dio? _dio;

  final baseUrl = 'https://api.openweathermap.org/data/2.5/onecall?';

  HttpWeatherService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    );
    // initializeInterceptors();
  }

  Future<Response?> getRequest(String endPoint) async {
    Response response;
    try {
      response = await _dio!.get(endPoint);

      print(response.statusCode);
    } on DioError catch (e) {
      print(e.error);
      throw Exception(e.message);
    }
    return response;
  }

  initializeInterceptors() {
    _dio?.interceptors.add(InterceptorsWrapper(
      onError: (error, errorInterceptorHandler) {
        print("Error message: ${error.message}");
      },
      onRequest: (request, requestInterceptorHandler) {
        print("Request method: ${request.method}");
      },
      onResponse: (response, responseInterceptorHandler) {
        print("Response data: ${response.data}");
      },
    ));
  }
}
