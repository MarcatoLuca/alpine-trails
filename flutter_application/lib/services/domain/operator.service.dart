import 'package:dio/dio.dart';
import 'package:flutter_application/providers/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_application/models/operator.dart';

class OperatorService {
  final _apiClient = ApiClient();
  final _storage = const FlutterSecureStorage();

  Future<List<Operator>> getOperatorAll() async {
    final token = await _storage.read(key: 'access_token');

    final response = await _apiClient.get(
      '/operators/',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return (response.data as List).map((op) => Operator.fromJson(op)).toList();
  }

  Future<List<Operator>> getOperatorFiltered({
    String? name,
    String? zoneName,
    List<String>? activities,
  }) async {
    final token = await _storage.read(key: 'access_token');

    final Map<String, dynamic> queryParams = {};
    if (name != null && name.isNotEmpty) queryParams['name'] = name;
    if (zoneName != null && zoneName.isNotEmpty) {
      queryParams['zone_name'] = zoneName;
    }

    if (activities != null && activities.isNotEmpty) {
      queryParams['activity_names'] = activities;
    }

    final response = await _apiClient.get(
      '/operators/',
      queryParameters: queryParams,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return (response.data as List).map((op) => Operator.fromJson(op)).toList();
  }

  Future<Operator?> getOperatorById(int id) async {
    try {
      final token = await _storage.read(key: 'access_token');

      final response = await _apiClient.get(
        '/operators/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return Operator.fromJson(response.data);
    } catch (e) {
      // Qui possiamo gestirla e restituire null.
      return null;
    }
  }

  Future<Operator?> addOperatorAsFavorite(int id) async {
    final token = await _storage.read(key: 'access_token');

    final response = await _apiClient.post(
      '/operators/favorites/$id',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return Operator.fromJson(response.data);
  }

    Future<Operator?> removeOperatorAsFavorite(int id) async {
    final token = await _storage.read(key: 'access_token');

    final response = await _apiClient.delete(
      '/operators/favorites/$id',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return Operator.fromJson(response.data);
  }
}
