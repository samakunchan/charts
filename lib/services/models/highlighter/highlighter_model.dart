import 'dart:convert';

import 'package:flutter/services.dart';

class AppHighlighterModel {
  const AppHighlighterModel({
    required this.message,
    required this.code,
    required this.startTime,
    required this.endTime,
    required this.result,
  });

  final String message;
  final int code;
  final int startTime;
  final int endTime;
  final Result result;

  factory AppHighlighterModel.fromJson(Map<String, dynamic> json,) {
    return AppHighlighterModel(
        message: json['message'],
        code: json['code'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        result: Result.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'code': code,
      'startTime': startTime,
      'endTime': endTime,
      'result': result,
    };
  }

  static Future<AppHighlighterModel> loadJson() async {
    final contents = await rootBundle.loadString('examples/highlighter.json');

    return AppHighlighterModel.fromJson(jsonDecode(contents) as Map<String, dynamic>);
  }
}

class Result {
  Result({required this.namedEntities});
  List<HighlighterModel> namedEntities;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        namedEntities: (json['namedEntities'] as List)
            .map((keyword) => HighlighterModel.fromJson(keyword))
            .toList()
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'namedEntities': namedEntities,
    };
  }
}

class HighlighterModel {
  const HighlighterModel({
    required this.value,
    required this.refValue,
    required this.tags,
    required this.start,
    required this.end,
  });
  
  final String value;
  final String refValue;
  final List<dynamic> tags;
  final int start;
  final int end;

  factory HighlighterModel.fromJson(Map<String, dynamic> json) {
    return HighlighterModel(
      value: json['value'],
      refValue: json['refValue'],
      tags: json['tags'],
      start: json['start'],
      end: json['end'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'value': value,
      'refValue': refValue,
      'tags': tags,
      'start': start,
      'end': end,
    };
  }
}

class Target {
  Target({required this.name, required this.label, required this.description});
  final String name;
  final String label;
  final String description;

  factory Target.fromJson(Map<String, dynamic> json) {
    return Target(name: json['name'], label: json['label'], description: json['description']);
  }
}