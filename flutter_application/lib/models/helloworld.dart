import 'dart:convert';

HelloWorld helloWorldFromJson(String str) => HelloWorld.fromJson(json.decode(str));

class HelloWorld {
  String? message;
  HelloWorld({this.message});
  factory HelloWorld.fromJson(Map<String, dynamic> json) {
    return HelloWorld(message: json['message'] as String?);
  }
  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
