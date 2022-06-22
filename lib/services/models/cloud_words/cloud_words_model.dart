import 'dart:convert';

import 'package:flutter/services.dart';

class CloudWordModel {
  const CloudWordModel({
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

  factory CloudWordModel.fromJson(Map<String, dynamic> json) {
    return CloudWordModel(
        message: json['message'],
        code: json['code'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        result: Result.fromJson(json['result'])
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

  static Future<CloudWordModel> loadCloudWordsJson() async {
    final contents = await rootBundle.loadString(
      'examples/cloud-words.json',
    );
    return CloudWordModel.fromJson(jsonDecode(contents) as Map<String, dynamic>);
  }
}

class Result {
  Result({required this.concepts});
  List<Concept> concepts;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        concepts: (json['concepts'] as List)
            .map((concept) => Concept.fromJson(concept))
            .toList());
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'concepts': concepts,
    };
  }
}

class Concept {
  const Concept({
    required this.value,
    required this.source,
    required this.refSource,
    required this.score,
  });
  final String value;
  final List<dynamic> source;
  final List<dynamic> refSource;
  final int score;

  factory Concept.fromJson(Map<String, dynamic> json) {
    return Concept(
      value: json['value'],
      source: json['source'],
      refSource: json['refSource'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'value': value,
      'source': source,
      'refSource': refSource,
      'score': score,
    };
  }
}
