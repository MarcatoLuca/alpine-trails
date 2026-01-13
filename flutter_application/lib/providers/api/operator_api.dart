import 'dart:convert';

import 'package:flutter_application/models/operator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OperatorApi {
  final String baseUrl = dotenv.env['BASE_URL'] ?? 'default_url';
  final client = http.Client();

  Future<List<Operator>> getOperatorAll() async {
    var uri = Uri.parse('$baseUrl/operators/');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      return Operator.listOperatorFromJson(
        const Utf8Decoder().convert(response.bodyBytes),
      );
    }
    return [];
  }

  Future<List<Operator>> getOperatorFiltered(String queryString) async {
    var uri = Uri.parse('$baseUrl/operators?$queryString');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      return Operator.listOperatorFromJson(
        const Utf8Decoder().convert(response.bodyBytes),
      );
    }
    return [];
  }

  Future<Operator?> getOperatorById(int id) async {
    var uri = Uri.parse('$baseUrl/operators/$id');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      return Operator.operatorFromJson(
        const Utf8Decoder().convert(response.bodyBytes),
      );
    }
    return null;
  }
}
