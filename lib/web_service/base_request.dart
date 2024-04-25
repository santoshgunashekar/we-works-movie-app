import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:we_works_movie_app/web_service/mock_config.dart';

abstract class BaseRequest {
  late Uri uri;
  late Map<String, String>? headers;
  late Map<String, dynamic>? queryParameters;
  late HttpMethod method;
  dynamic body;

  Future<http.Response?> constructAndExecuteRequest({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    required HttpMethod method,
    MockConfig? mockConfig,
  }) {
    headers = {};
    constructRequest(
      endPoint: endPoint,
      method: method,
      body: body,
      queryParameters: queryParameters,
    );
    return executeRequest(mockConfig: mockConfig);
  }

  void constructRequest({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    required HttpMethod method,
  }) {
    this.method = method;
    uri = Uri.https(
      getBaseUrl(),
      endPoint,
      queryParameters,
    );
    this.body = body;
    addHeaders();
  }

  Future<http.Response?> executeRequest({
    MockConfig? mockConfig,
  }) async {
    http.Response? response;

    if (mockConfig != null) {
      return http.Response(
        jsonEncode(mockConfig.response),
        mockConfig.statusCode,
      );
    }

    if (kDebugMode) {
      log('http/request: ${DateTime.now()}\n$uri\n$headers\n$body');
    }

    switch (method) {
      case HttpMethod.get:
        response = await http.get(uri, headers: headers);
      case HttpMethod.post:
        response = await http.post(uri, headers: headers, body: body);
      case HttpMethod.put:
        response = await http.put(uri, headers: headers, body: body);
      case HttpMethod.delete:
        response = await http.delete(uri, headers: headers);
      default:
        break;
    }

    if (kDebugMode) {
      log('http/response: ${DateTime.now()}  ${response?.statusCode}\n$uri\n${response?.headers}\n${response?.body}');
    }

    return response;
  }

  ///Add necessary headers here
  void addHeaders() {}

  // TODO(SantoshG): Get base url based on flavor - qa or prod
  String getBaseUrl() {
    return "cross-platform.rp.devfactory.com";
  }
}

enum HttpMethod { get, post, put, delete }
