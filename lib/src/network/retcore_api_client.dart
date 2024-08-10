/*
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:retcore/src/config/imports.dart';

class RetCoreApiClient{

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

  Map<String, String> _buildHeaders({String? cookies}) {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    if (cookies != null && cookies.isNotEmpty) {
      headers.addAll({'Cookie': cookies});
    }
    return headers;
  }

  Future<dynamic> get({required String endpoint, Map<String, dynamic>? params,String? cookies}) async {
    return _sendRequest(tGET, endpoint,cookies, params: params);
  }

  Future<dynamic> post({required String endpoint, dynamic body,String? cookies}) async {
    return _sendRequest(tPOST, endpoint,cookies, body: body);
  }

  Future<dynamic> put({required String endpoint, dynamic body,String? cookies}) async {
    return _sendRequest(tPUT, endpoint,cookies, body: body);
  }

  Future<dynamic> patch({required String endpoint, dynamic body,String? cookies}) async {
    return _sendRequest(tPATCH, endpoint,cookies, body: body);
  }

  Future<dynamic> delete({required String endpoint,String? cookies}) async {
    return _sendRequest(tDELETE, endpoint,cookies);
  }

  Future<dynamic> _sendRequest(String method, String endpoint, String? setCookies, {Map<String, dynamic>? params, dynamic body}) async {
    try {
      final headers = setCookies == null ? _buildHeaders() : _buildHeaders(cookies: setCookies);
      http.Response response;
      final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
      switch (method) {
        case tGET:
          response = await http.get(uri, headers: headers);
          break;
        case tPOST:
          response = await http.post(uri, headers: headers, body: json.encode(body));
          break;
        case tPUT:
          response = await http.put(uri, headers: headers, body: json.encode(body));
          break;
        case tPATCH:
          response = await http.patch(uri, headers: headers, body: json.encode(body));
          break;
        case tDELETE:
          response = await http.delete(uri, headers: headers);
          break;
        default:
          throw Exception(tHttpError);
      }
      ApiClientLog().printRequest(response);
      String cookieResponse = _cookieSet(response:response);
      var handleResponse = _handleResponse(response);
      Map<String , dynamic> data = {
        "records": handleResponse,
        "cookie": cookieResponse,
      };
      return data;
    } catch (e) {
      dev.log('Error occurred while making $method request: $e');
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 400) {
      try {
        final decodedResponse = jsonDecode(response.body);
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
    } else {
      dev.log('$tErrorCode ${response.statusCode}');
    }
  }

  String _cookieSet({required http.Response response}){
    String? setCookieHeaders = response.headers["set-cookie"];
    return setCookieHeaders ?? '';
  }
}*/



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
        case 'GET':
          response = await http.get(uri, headers: requestHeaders);
          break;
        case 'POST':
          response = await http.post(uri, headers: requestHeaders, body: requestBody);
          break;
        case 'PUT':
          response = await http.put(uri, headers: requestHeaders, body: requestBody);
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: requestHeaders, body: requestBody);
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      ApiClientLog().printRequest(response);
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