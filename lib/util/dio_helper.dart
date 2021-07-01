import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:klutter/data/dataproviders/client/book_controller.dart';
import 'package:klutter/data/dataproviders/client/library_controller.dart';
import 'package:klutter/data/dataproviders/client/series_controller.dart';
import 'package:klutter/data/models/server.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

Future<Dio> _configuredDio() async {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  String serverString = await storage.read(key: "Current Server") as String;
  Server server = Server.fromJson(jsonDecode(serverString));

  final cacheOptions =
      CacheOptions(store: MemCacheStore(), policy: CachePolicy.forceCache);

  Dio _dio = Dio(BaseOptions(baseUrl: server.url, headers: {
    'Authorization': genBasicAuthHeaderValue(server.username, server.password)
  }))
    ..interceptors.add(DioCacheInterceptor(options: cacheOptions));
  // _dio.interceptors.add(PrettyDioLogger(request: true, responseBody: false));
  return _dio;
}

Future<BookController> getBookController() async {
  Dio _dio = await _configuredDio();
  // print("Book Cont: " + _dio.options.baseUrl);

  return BookController(_dio);
}

Future<SeriesController> getSeriesController() async {
  Dio _dio = await _configuredDio();
  // print("Series Cont: " + _dio.options.baseUrl);
  return SeriesController(_dio);
}

Future<LibraryController> getLibraryController() async {
  Dio _dio = await _configuredDio();
  // print("Lib Cont: " + _dio.options.baseUrl);

  return LibraryController(_dio);
}

String genBasicAuthHeaderValue(String user, String pass) {
  return 'Basic ' + base64Encode(utf8.encode('$user:$pass'));
}
