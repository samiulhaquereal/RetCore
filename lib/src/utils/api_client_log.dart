import 'package:http/http.dart' as http;
import 'package:retcore/src/config/imports.dart';

class ApiClientLog{

  static ApiClientLog? _instance;
  ApiClientLog._internal();
  factory ApiClientLog(){
    _instance ??= ApiClientLog._internal();
    return _instance!;
  }

  void printRequest(http.Response response,String url,String method) {
    retcoreLogger.info(url, level: 'REQUEST', method: method, status: '');
    retcoreLogger.info('${response.headers}', level: 'HEADERS', method: method, status: '');
    retcoreLogger.info(response.body,title: url, level: 'RESPONSE', method: method, status: '${response.statusCode}');
  }
}