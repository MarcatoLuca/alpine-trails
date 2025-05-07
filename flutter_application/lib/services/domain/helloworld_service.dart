
import 'package:flutter_application/models/helloworld.dart';
import 'package:flutter_application/providers/api/helloworld_api.dart';

class HelloWorldService {
  final _api = HelloworldApi();

  Future<HelloWorld?> getHelloWorld() async {
    return _api.getHelloWorld();
  }
}