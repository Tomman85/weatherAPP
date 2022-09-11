import 'package:dio/dio.dart';

class NetworkService {
  Dio? _api;

  NetworkService() {
    _api ??= Dio(
      BaseOptions(
        connectTimeout: 20000,
        receiveTimeout: 20000,
        sendTimeout: 20000,
      ),
    );
    // initializeInterceptors();
  }

  Future<Response> get(String path) async {
    return await _api!.get(path);
  }

  Future<Response> post(
    String path,
    Map<String, dynamic> data,
  ) async {
    return await _api!.post(
      path,
      data: data,
    );
  }

  Future<Response> put(String path, Map<String, dynamic> data) async {
    return await _api!.put(
      path,
      data: data,
    );
  }
}
