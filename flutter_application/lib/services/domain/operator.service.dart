import 'package:flutter_application/models/operator.dart';
import 'package:flutter_application/providers/api/operator_api.dart';

class OperatorService {
  final _api = OperatorApi();

  Future<List<Operator>> getOperatorAll() {
    return _api.getOperatorAll();
  }

  Future<Operator?> getOperatorById(int id) {
    return _api.getOperatorById(id);
  }
}
