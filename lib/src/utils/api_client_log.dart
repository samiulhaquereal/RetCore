import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:retcore/src/config/imports.dart';
class ApiClientLog{

  static ApiClientLog? _instance;
  ApiClientLog._internal();
  factory ApiClientLog(){
    _instance ??= ApiClientLog._internal();
    return _instance!;
  }

  /*void printRequest(http.Response response) {
    log('Request: ${response.request}');
    log('Status code: ${response.statusCode}');
    log('Headers: ${response.headers}');
    log('Body: ${response.body}');
  }*/
  void printRequest(http.Response response) {
    final request = response.request;

    // Format and style the request and response logs
    final buffer = StringBuffer();

    buffer.writeln('--- HTTP Request ---');
    if (request != null) {
      buffer.writeln('Method: ${request.method}');
      buffer.writeln('URL: ${request.url}');
      buffer.writeln('Headers: ${_formatHeaders(request.headers)}');
      buffer.writeln('Body: ${_formatBody(response.body)}');
    } else {
      buffer.writeln('Request details are not available.');
    }

    buffer.writeln('--- HTTP Response ---');
    buffer.writeln('Status Code: ${response.statusCode}');
    buffer.writeln('Headers: ${_formatHeaders(response.headers)}');
    buffer.writeln('Body: ${_formatBody(response.body)}');

    dev.log(buffer.toString(), name: 'HTTP Logger');
  }

  String _formatHeaders(Map<String, String> headers) {
    final buffer = StringBuffer();
    headers.forEach((key, value) {
      buffer.writeln('  $key: $value');
    });
    return buffer.toString().trim();
  }

  String _formatBody(String? body) {
    if (body == null || body.isEmpty) {
      return 'No body';
    }
    try {
      final jsonBody = jsonDecode(body);
      return jsonEncode(jsonBody); // Format JSON body
    } catch (e) {
      return body; // Return raw body if it's not JSON
    }
  }
}