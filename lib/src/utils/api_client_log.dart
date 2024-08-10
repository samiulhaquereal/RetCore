import 'dart:developer';
import 'package:http/http.dart' as http;
class ApiClientLog{

  static ApiClientLog? _instance;
  ApiClientLog._internal();
  factory ApiClientLog(){
    _instance ??= ApiClientLog._internal();
    return _instance!;
  }

  void printRequest(http.Response response) {
    log('Request  ${response.request}');
    log('Status code: ${response.statusCode}');
    log('Headers: ${response.headers}');
    log('Body: ${response.body}');
  }
}