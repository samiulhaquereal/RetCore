import 'dart:developer' as dev;
import 'package:retcore/src/config/imports.dart'; // Import the isolate function

class RetCoreIsolateApiClient {
  final String baseUrl;
  static RetCoreIsolateApiClient? _instance;
  static final _isolatePorts = <String, SendPort>{};

  RetCoreIsolateApiClient._internal({required this.baseUrl});

  factory RetCoreIsolateApiClient({required String baseUrl}) {
    _instance ??= RetCoreIsolateApiClient._internal(baseUrl: baseUrl);
    return _instance!;
  }

  Future<void> _initializeIsolate() async {
    final receivePort = ReceivePort();
    await Isolate.spawn(apiIsolate, receivePort.sendPort);
    final sendPort = await receivePort.first as SendPort;
    _isolatePorts[baseUrl] = sendPort;
  }

  Future<dynamic> get({required String endpoint, Map<String, dynamic>? params, String? cookies}) async {
    return _sendRequest('GET', endpoint, params: params, cookies: cookies);
  }

  Future<dynamic> post({required String endpoint, dynamic body, String? cookies}) async {
    return _sendRequest('POST', endpoint, body: body, cookies: cookies);
  }

  Future<dynamic> put({required String endpoint, dynamic body, String? cookies}) async {
    return _sendRequest('PUT', endpoint, body: body, cookies: cookies);
  }

  Future<dynamic> patch({required String endpoint, dynamic body, String? cookies}) async {
    return _sendRequest('PATCH', endpoint, body: body, cookies: cookies);
  }

  Future<dynamic> delete({required String endpoint, String? cookies}) async {
    return _sendRequest('DELETE', endpoint, cookies: cookies);
  }

  Future<dynamic> _sendRequest(
      String method,
      String endpoint, {
        Map<String, dynamic>? params,
        dynamic body,
        String? cookies,
      }) async {
    try {
      final sendPort = _isolatePorts[baseUrl];
      if (sendPort == null) {
        await _initializeIsolate();
      }

      final port = ReceivePort();
      sendPort?.send({
        'method': method,
        'baseUrl': baseUrl,
        'endpoint': endpoint,
        'cookies': cookies,
        'params': params,
        'body': body,
        'port': port.sendPort,
      });

      final response = await port.first;

      if (response is Map) {
        if (response.containsKey('error')) {
          throw Exception(response['error']);
        }
        return response;
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      dev.log('Error occurred while making $method request: $e');
    }
  }
}
