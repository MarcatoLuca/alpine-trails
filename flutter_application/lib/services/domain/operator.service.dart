import 'package:flutter_application/models/operator.dart';
import 'package:flutter_application/providers/api/operator_api.dart';

class OperatorService {
  final _api = OperatorApi();

  Future<List<Operator>> getOperatorAll() {
    return _api.getOperatorAll();
  }

  Future<List<Operator>> getOperatorFiltered({String? name, String? zoneName, List<String>? activities}) {
    String queryString = '';

    if(name != null && name.isNotEmpty) {
      queryString += 'name=$name';
    }
    if(zoneName != null && zoneName.isNotEmpty) {
      if(queryString.isNotEmpty) {
        queryString += '&';
      }
      queryString += 'zone_name=$zoneName';
    }
    if(activities != null && activities.isNotEmpty) {
      if(queryString.isNotEmpty) {
        queryString += '&';
      }
      queryString += activities.map((activity) => 'activity_names=$activity').join('&');
    }

    if(queryString.isEmpty) {
      return _api.getOperatorAll();
    }
    return _api.getOperatorFiltered(queryString);
  }

  Future<Operator?> getOperatorById(int id) {
    return _api.getOperatorById(id);
  }
}
