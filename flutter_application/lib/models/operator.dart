import 'dart:convert';

import 'package:flutter_application/models/activity.dart';
import 'package:flutter_application/models/zone.dart';

class Operator {
  int id;
  String name;
  String? description;
  String? phone;
  String? email;
  String? website;
  List<Activity>? activities;
  List<Zone>? zones;

  Operator({
    required this.id,
    required this.name,
    this.description,
    this.phone,
    this.email,
    this.website,
    this.activities,
    this.zones,
  });

  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      activities:
          (json['activities'] as List)
              .map((x) => Activity.fromJson(x))
              .toList(),
      zones: (json['zones'] as List).map((x) => Zone.fromJson(x)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'phone': phone,
      'email': email,
      'website': website,
      'activities': activities,
      'zones': zones,
    };
  }

  static Operator operatorFromJson(String str) =>
      Operator.fromJson(json.decode(str));

  static List<Operator> listOperatorFromJson(String str) =>
      List<Operator>.from(json.decode(str).map((x) => Operator.fromJson(x)));
}
