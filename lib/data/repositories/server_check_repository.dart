import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:klutter/data/dataproviders/client/user_controller.dart';
import 'package:klutter/data/models/server.dart';

class ServerCheckRepository {
  Future<bool> isServerOnline(Server server) async {
    BaseOptions baseOptions = BaseOptions(baseUrl: server.url, headers: {
      'Authorization': genBasicAuthHeaderValue(server.username, server.password)
    });
    Dio _dio = Dio(baseOptions);
    UserController userController = UserController(_dio);
    try {
      await userController.getMe();
      return true;
    } catch (_) {
      return false;
    }
  }
}

String genBasicAuthHeaderValue(String user, String pass) {
  return 'Basic ' + base64Encode(utf8.encode('$user:$pass'));
}
