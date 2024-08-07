import 'package:http/http.dart' as http;
import 'package:retcore/src/config/imports.dart';


void apiIsolate(SendPort sendPort) async {
  final port = ReceivePort();
  sendPort.send(port.sendPort);

  await for (final message in port) {
    final data = message as Map<String, dynamic>;
    final method = data['method'] as String;
    final baseUrl = data['baseUrl'] as String;
    final endpoint = data['endpoint'] as String;
    final cookies = data['cookies'] as String?;
    final params = data['params'] as Map<String, dynamic>?;
    final body = data['body'];

    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
      final headers = _buildHeaders(cookies: cookies);
      http.Response response;
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
      final cookieResponse = _cookieSet(response: response);
      final handleResponse = _handleResponse(response);
      final result = {
        "records": handleResponse,
        "cookie": cookieResponse,
      };
      sendPort.send(result);
    } catch (e) {
      sendPort.send({'error': e.toString()});
    }
  }
}

Map<String, String> _buildHeaders({String? cookies}) {
  final headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  if (cookies != null && cookies.isNotEmpty) {
    headers['Cookie'] = cookies;
  }
  return headers;
}

String _cookieSet({required http.Response response}) {
  return response.headers["set-cookie"] ?? '';
}

dynamic _handleResponse(http.Response response) {
  if (response.statusCode >= 400) {
    try {
      final decodedResponse = jsonDecode(response.body);
      return decodedResponse;
    } catch (e) {
      return 'Failed to parse error response: ${response.body}';
    }
  } else if (response.statusCode >= 200) {
    final decodedResponse = json.decode(response.body);
    if (decodedResponse is Map<String, dynamic>) {
      return decodedResponse;
    } else if (decodedResponse is List<dynamic>) {
      return decodedResponse;
    } else {
      return 'Unsupported response type: ${decodedResponse.runtimeType}';
    }
  } else {
    return 'Failed to make request with status code: ${response.statusCode}';
  }
}
