import 'dart:async';
import 'package:dio/dio.dart';

class Client {
  Dio init() {
    Dio _dio = new Dio();
    _dio.interceptors.add(new ApiInterceptors());
    _dio.options.baseUrl =
        "https://api.openweathermap.org/data/2.5/onecall?appid=45865970ebbfbc127eb2a16dd7f753e7&exclude=minutely&units=metric";
    return _dio;
  }
}

class ApiInterceptors extends Interceptor {
  @override
  Future onError(DioError err) {
    // TODO: implement onError
    return super.onError(err);
  }

  @override
  Future onRequest(RequestOptions options) {
    // TODO: implement onRequest
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    // TODO: implement onResponse
    return super.onResponse(response);
  }
}
