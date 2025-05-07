import 'dart:convert';
import 'package:flutter_application/models/helloworld.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HelloworldApi {
  final String baseUrl = dotenv.env['BASE_URL'] ?? 'default_url';

  Future<HelloWorld?> getHelloWorld() async {
    var client = http.Client();
    var uri = Uri.parse('$baseUrl/helloworld');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      return helloWorldFromJson(
        const Utf8Decoder().convert(response.bodyBytes),
      );
    }
    return null;
  }
}
