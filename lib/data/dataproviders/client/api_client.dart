import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:klutter/data/dataproviders/client/book_controller.dart';
import 'package:klutter/data/dataproviders/client/library_controller.dart';
import 'package:klutter/data/dataproviders/client/series_controller.dart';
import 'package:klutter/data/models/server.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:path_provider/path_provider.dart' as pp;

class ApiClient {
  static ApiClient? _apiClient;
  late BookController bookController;
  late SeriesController seriesController;
  late LibraryController libraryController;

  ApiClient._();

  factory ApiClient() {
    if (_apiClient == null) {
      _apiClient = ApiClient._();
    }
    return _apiClient!;
  }

  static init() async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    final String serverString =
        await storage.read(key: "Current Server") as String;
    final Server server = Server.fromJson(jsonDecode(serverString));

    // final Directory dir = await pp.getApplicationDocumentsDirectory();
    // final cacheOptions = CacheOptions(
    //     hitCacheOnErrorExcept: [],
    //     allowPostMethod: false,
    //     store: HiveCacheStore(dir.path),
    //     policy: CachePolicy.request);

    Dio _dio = Dio(
      BaseOptions(
        baseUrl: server.url,
        headers: {
          'Authorization':
              genBasicAuthHeaderValue(server.username, server.password)
        },
      ),
    );
    // ..interceptors.add(DioCacheInterceptor(options: cacheOptions));
    _dio.interceptors.add(PrettyDioLogger(request: true, responseBody: false));
    _apiClient!.bookController = BookController(_dio);
    _apiClient!.libraryController = LibraryController(_dio);
    _apiClient!.seriesController = SeriesController(_dio);
  }
}

String genBasicAuthHeaderValue(String user, String pass) {
  return 'Basic ' + base64Encode(utf8.encode('$user:$pass'));
}
