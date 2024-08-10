import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:retcore/src/config/imports.dart';

class ApiClientHandler{

  static ApiClientHandler? _instance;
  ApiClientHandler._internal();
  factory ApiClientHandler(){
    _instance ??= ApiClientHandler._internal();
    return _instance!;
  }

  dynamic handleResponse({required http.Response response, SendPort? sendPort}) {
    if (response.statusCode >= 400) {
      try {
        final decodedResponse = json.decode(response.body);
        return decodedResponse;
      } catch (e) {
        dev.log('$tErrorResponse ${response.body}');
      }
    }else if (response.statusCode >= 200) {
      final decodedResponse = json.decode(response.body);
      if (decodedResponse is Map<String, dynamic>) {
        return decodedResponse;
      } else if (decodedResponse is List<dynamic>) {
        return decodedResponse;
      } else {
        dev.log('$tResponseError ${decodedResponse.runtimeType}');
      }
      if (sendPort != null) {
        sendPort.send(decodedResponse);
      } else {
        return decodedResponse;
      }
    } else {
      dev.log('$tErrorCode ${response.statusCode}');
      final error = {'error': '$tErrorCode ${response.statusCode}'};
      if (sendPort != null) {
        sendPort.send(error);
      } else {
        throw Exception('$tErrorCode ${response.statusCode}');
      }
    }
  }

  String cookieSet({required http.Response response}){
    String? setCookieHeaders = response.headers["set-cookie"];
    return setCookieHeaders ?? '';
  }

}