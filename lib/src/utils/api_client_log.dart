import 'package:http/http.dart' as http;
import 'package:retcore/src/config/imports.dart';
class ApiClientLog{

  static ApiClientLog? _instance;
  ApiClientLog._internal();
  factory ApiClientLog(){
    _instance ??= ApiClientLog._internal();
    return _instance!;
  }

  void printRequest(http.Response response,String url) {
    final body = json.decode(response.body);
    retcoreLogger.info(url, level: 'REQUEST', method: '${response.request}', status: '');
    retcoreLogger.info('${response.headers}', level: 'HEADERS', method: '${response.request}', status: '');
    retcoreLogger.info(body,title: url, level: 'RESPONSE', method: '${response.request}', status: '${response.statusCode}');
  }
}