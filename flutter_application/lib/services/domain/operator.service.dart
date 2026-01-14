import 'package:flutter_application/providers/api_client.dart';
import 'package:flutter_application/models/operator.dart';

class OperatorService {
  final _apiClient = ApiClient();

  Future<List<Operator>> getOperatorAll() async {
    final response = await _apiClient.get('/operators/');
    return (response.data as List).map((op) => Operator.fromJson(op)).toList();
  }

  Future<List<Operator>> getOperatorFiltered({
    String? name,
    String? zoneName,
    List<String>? activities,
  }) async {
    final Map<String, dynamic> queryParams = {};
    if (name != null && name.isNotEmpty) queryParams['name'] = name;
    if (zoneName != null && zoneName.isNotEmpty)
      queryParams['zone_name'] = zoneName;

    if (activities != null && activities.isNotEmpty)
      queryParams['activity_names'] = activities;

    final response = await _apiClient.get(
      '/operators/',
      queryParameters: queryParams,
    ); 

    return (response.data as List).map((op) => Operator.fromJson(op)).toList();
  }

  Future<Operator?> getOperatorById(int id) async {
    try {
      final response = await _apiClient.get('/operators/$id');
      return Operator.fromJson(response.data);
    } catch (e) {
      // Qui possiamo gestirla e restituire null.
      return null;
    }
  }
}
