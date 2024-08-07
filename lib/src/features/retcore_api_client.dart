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
    return _sendRequest('GET', endpoint,cookies, params: params);
  }

  Future<dynamic> post({required String endpoint, dynamic body,String? cookies}) async {
    return _sendRequest('POST', endpoint,cookies, body: body);
  }

  Future<dynamic> put({required String endpoint, dynamic body,String? cookies}) async {
    return _sendRequest('PUT', endpoint,cookies, body: body);
  }

  Future<dynamic> patch({required String endpoint, dynamic body,String? cookies}) async {
    return _sendRequest('PATCH', endpoint,cookies, body: body);
  }

  Future<dynamic> delete({required String endpoint,String? cookies}) async {
    return _sendRequest('DELETE', endpoint,cookies);
  }

  Future<dynamic> _sendRequest(String method, String endpoint, String? setCookies, {Map<String, dynamic>? params, dynamic body}) async {
    try {
      final headers = setCookies == null ? _buildHeaders() : _buildHeaders(cookies: setCookies);
      http.Response response;
      final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
      switch (method) {
        case 'GET':
          response = await http.get(uri, headers: headers);
          break;
        case 'POST':
          response = await http.post(uri, headers: headers, body: json.encode(body));
          break;
        case 'PUT':
          response = await http.put(uri, headers: headers, body: json.encode(body));
          break;
        case 'PATCH':
          response = await http.patch(uri, headers: headers, body: json.encode(body));
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: headers);
          break;
        default:
          throw Exception('Unsupported HTTP method');
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
        dev.log('Failed to parse error response: ${response.body}');
      }
    }else if (response.statusCode >= 200) {
      final decodedResponse = json.decode(response.body);
      if (decodedResponse is Map<String, dynamic>) {
        return decodedResponse;
      } else if (decodedResponse is List<dynamic>) {
        return decodedResponse;
      } else {
        dev.log('Unsupported response type: ${decodedResponse.runtimeType}');
      }
    } else {
      dev.log('Failed to make request with status code: ${response.statusCode}');
    }
  }

  String _cookieSet({required http.Response response}){
    String? setCookieHeaders = response.headers["set-cookie"];
    return setCookieHeaders ?? '';
  }
}