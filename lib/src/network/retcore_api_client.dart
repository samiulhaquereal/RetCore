import 'package:retcore/src/config/imports.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

class RetCoreApiClient {

  final String baseUrl;
  // Private static variable to hold the single instance
  static RetCoreApiClient? _instance;
  // Private constructor
  RetCoreApiClient._internal({required this.baseUrl});
  // Factory constructor to return the single instance
  factory RetCoreApiClient({required String baseUrl}) {
    // Check if the instance is null, if so, create one
    _instance ??= RetCoreApiClient._internal(baseUrl: baseUrl);
    return _instance!;
  }

  Map<String, String> _buildHeaders({Map<String, String>? additionalHeaders,String? cookies}) {
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      if (additionalHeaders != null) ...additionalHeaders,
    };
    if (cookies != null && cookies.isNotEmpty) {
      headers.addAll({'Cookie': cookies});
    }
    return headers;
  }

  Future<dynamic> get({required String endpoint, Map<String, String>? params,String? cookies,Map<String, String>? additionalHeaders,bool? needEncode}) async {
    return _sendRequest(
        method: tGET,
        endpoint: endpoint,
        params: params,
        setCookies: cookies,
        needEncode: needEncode,
        additionalHeaders: additionalHeaders
    );
  }
  Future<dynamic> post({required String endpoint, dynamic body,String? cookies,Map<String, String>? additionalHeaders,bool? needEncode}) async {
    return _sendRequest(
      method: tPOST,
      endpoint: endpoint,
      body: body,
      setCookies: cookies,
      additionalHeaders: additionalHeaders,
      needEncode: needEncode,
    );
  }
  Future<dynamic> put({required String endpoint, dynamic body,String? cookies,Map<String, String>? additionalHeaders,bool? needEncode}) async {
    return _sendRequest(
        method: tPUT,
        endpoint: endpoint,
        body: body,
        setCookies: cookies,
        needEncode: needEncode,
        additionalHeaders: additionalHeaders
    );
  }
  Future<dynamic> patch({required String endpoint, dynamic body,String? cookies,Map<String, String>? additionalHeaders,bool? needEncode}) async {
    return _sendRequest(
        method: tPATCH,
        endpoint: endpoint,
        body: body,
        needEncode: needEncode,
        setCookies: cookies,
        additionalHeaders: additionalHeaders
    );
  }
  Future<dynamic> delete({required String endpoint, dynamic body,String? cookies,Map<String, String>? params,Map<String, String>? additionalHeaders}) async {
    return _sendRequest(
        method: tDELETE,
        endpoint: endpoint,
        params: params,
        setCookies: cookies,
        additionalHeaders: additionalHeaders
    );
  }

  Future<dynamic> _sendRequest({
    required String method,
    bool? needEncode,
    required String endpoint,
    dynamic? body,
    Map<String, String>? params,
    String? setCookies,
    Map<String, String>? additionalHeaders
  }) async {
    String os = RetCore.getOS();
    if (os == 'Web') {
      return _sendRequestHandler(
          method: method,
          needEncode: needEncode,
          endpoint: endpoint,
          body: body,
          params: params,
          setCookies: setCookies,
          additionalHeaders: additionalHeaders
      );
    } else {
      final receivePort = ReceivePort();
      await Isolate.spawn(_isolateRequestHandler, {
        'sendPort': receivePort.sendPort,
        'method': method,
        'needEncode': needEncode,
        'endpoint': endpoint,
        'body': body,
        'params': params,
        'setCookies': setCookies,
        'additionalHeaders': additionalHeaders,
      });
      final response = await receivePort.first;
      return response;
    }
  }

  Future<void> _isolateRequestHandler(Map<String, dynamic> params) async {
    final sendPort = params['sendPort'];
    final method = params['method'];
    final needEncode = params['needEncode'];
    final endpoint = params['endpoint'];
    final body = params['body'];
    final queryParams = params['params'];
    final setCookies = params['setCookies'];
    final additionalHeaders = params['additionalHeaders'];

    final response = await _sendRequestHandler(
        method: method,
        needEncode: needEncode,
        endpoint: endpoint,
        body: body,
        params: queryParams,
        setCookies: setCookies,
        additionalHeaders: additionalHeaders
    );
    sendPort.send(response);
  }

  Future<dynamic> _sendRequestHandler<T>({
    required String method,
    bool? needEncode,
    required String endpoint,
    dynamic? body,
    Map<String, String>? params,
    SendPort? sendPort,
    String? setCookies,
    Map<String, String>? additionalHeaders
  }) async {
    try {
      http.Response response;
      final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
      final requestHeaders = _buildHeaders(cookies: setCookies,additionalHeaders: additionalHeaders);
      final requestBody = needEncode == true ? jsonEncode(body) : body;

      switch (method) {
        case tGET:
          response = await http.get(uri, headers: requestHeaders);
          break;
        case tPOST:
          response = await http.post(uri, headers: requestHeaders, body: requestBody);
          break;
        case tPUT:
          response = await http.put(uri, headers: requestHeaders, body: requestBody);
          break;
        case tPATCH:
          response = await http.patch(uri, headers: requestHeaders, body: requestBody);
          break;
        case tDELETE:
          response = await http.delete(uri, headers: requestHeaders, body: requestBody);
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      ApiClientLog().printRequest(response,uri.toString(),method);
      String cookieResponse = ApiClientHandler().cookieSet(response:response);
      var handleResponse = ApiClientHandler().handleResponse(response: response,sendPort: sendPort);
      Map<String , dynamic> data = {
        "records": handleResponse,
        "cookie": cookieResponse,
      };
      return data;
    } catch (e) {
      dev.log('Error occurred while making $method request: $e');
    }
  }
}